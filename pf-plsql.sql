/*
  --Pets First PL/SQL Trigger and Procedure--
  --pf-plsql.sql

  Description:
  This script defines and tests a trigger to enforce visit service cost limits
  and a stored procedure to schedule follow-up visits with validation logic.
*/

/* 
   Trigger: check_visit_service_cost
   Ensures that inserted or updated visit service costs are within ±10% 
   of the standard service cost. Displays confirmation messages for successful 
   inserts or updates, and raises an error if the threshold is exceeded.
*/
SET serveroutput ON

CREATE OR REPLACE TRIGGER check_visit_service_cost BEFORE
    INSERT OR UPDATE ON visit_service FOR EACH ROW
DECLARE
    var_service_std_cost NUMBER(6,2);
BEGIN
    SELECT service_std_cost INTO var_service_std_cost
    FROM service
    WHERE service_code = :NEW.service_code;

    IF :NEW.visit_service_linecost < (var_service_std_cost * 0.9) OR
       :NEW.visit_service_linecost > (var_service_std_cost * 1.1) THEN
        RAISE_APPLICATION_ERROR(-20000, 'The visit service cost must be within 10% of the standard service cost');
    ELSE
        IF inserting THEN
            dbms_output.put_line('Insert successful');
        ELSIF updating THEN
            dbms_output.put_line('Update successful');
        END IF;

    END IF;
END;
/

-- Write Test Harness
-- Initial data
SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 1: Insert beyond 10% threshold
-- Expected Result: Error
BEGIN
    INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
    VALUES (2, 'S001', 67.00);
END;
/

-- Data after Test Case 1
SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 2: Insert below 10% threshold
-- Expected Result: Error
BEGIN
    INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
    VALUES (5, 'S003', 62.00);
END;
/

-- Data after Test Case 2
SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 3: Insert within 10% threshold
-- Expected Result: Success
BEGIN
    INSERT INTO visit_service (visit_id, service_code, visit_service_linecost)
    VALUES (14, 'S019', 55.00);
END;
/

-- Data after Test Case 3
SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 4: Update beyond 10% threshold
-- Expected Result: Error
BEGIN
    UPDATE visit_service
    SET visit_service_linecost = 45.00
    WHERE visit_id = 7 AND service_code = 'S008';
END;
/

-- Data after Test Case 4
SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 5: Update below 10% threshold
-- Expected Result: Error
BEGIN
    UPDATE visit_service
    SET visit_service_linecost = 75.50
    WHERE visit_id = 7 AND service_code = 'S009';
END;
/

-- Data after Test Case 5
SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 6: Update within 10% threshold
-- Expected Result: Success
BEGIN
    UPDATE visit_service
    SET visit_service_linecost = 54.00
    WHERE visit_id = 12 AND service_code = 'S001';
END;
/

-- Data after Test Case 6
SELECT *
FROM visit_service
ORDER BY visit_id;

ROLLBACK;

/* (b)
   Procedure: prc_followup_visit
   Schedules a follow-up visit based on an existing visit.
   Validates that the previous visit exists and that the new visit 
   is scheduled after it. If valid, inserts a new visit and 
   assigns a default service.
*/
CREATE OR REPLACE PROCEDURE prc_followup_visit (
    p_prevvisit_id IN NUMBER,
    p_newvisit_datetime IN DATE,
    p_newvisit_length IN NUMBER,
    p_output OUT VARCHAR2
) IS
    var_prevvisit_found NUMBER;
    var_prevvisit_datetime DATE;
    var_animal_id NUMBER(5);
    var_vet_id NUMBER(4);
    var_clinic_id NUMBER(2);
    var_service_code CHAR(5) := 'S001';

BEGIN
    SELECT COUNT(*) INTO var_prevvisit_found
    FROM visit
    WHERE visit_id = p_prevvisit_id;

    IF var_prevvisit_found = 0 THEN
        p_output := 'The previous visit does not exist, scheduling of follow-up visit cancelled';
    ELSE
        SELECT visit_date_time, animal_id, vet_id, clinic_id INTO var_prevvisit_datetime, var_animal_id, var_vet_id, var_clinic_id
        FROM visit
        WHERE visit_id = p_prevvisit_id;

        IF p_newvisit_datetime <= var_prevvisit_datetime THEN
            p_output := 'The follow-up visit must be scheduled after the previous visit, scheduling of follow-up visit cancelled';
        ELSE
            INSERT INTO visit 
            (
                visit_id, 
                visit_date_time,
                visit_length,
                visit_notes, 
                visit_weight, 
                visit_total_cost, 
                animal_id, 
                vet_id, 
                clinic_id, 
                from_visit_id
            )
            VALUES
            (
                visit_id_seq.NEXTVAL,
                p_newvisit_datetime,
                p_newvisit_length,
                null,
                null,
                null,
                var_animal_id,
                var_vet_id,
                var_clinic_id,
                p_prevvisit_id
            );

            INSERT INTO visit_service
            (
                visit_id,
                service_code,
                visit_service_linecost
            )
            VALUES
            (
                visit_id_seq.CURRVAL,
                var_service_code,
                null
            );

            p_output := 'Follow-up visit successfully scheduled';
        END IF;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        p_output := SQLERRM;

END;
/

-- Write Test Harness
-- Initial data
SELECT *
FROM visit
ORDER BY visit_id;

SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 1: Previous visit does not exist
-- Expected Result: Fail - The previous visit does not exist
DECLARE
    var_output VARCHAR2(200);
BEGIN
    prc_followup_visit(205, SYSDATE, 60, var_output);
    dbms_output.put_line(var_output);
END;
/

-- Data after Test Case 1
SELECT *
FROM visit
ORDER BY visit_id;

SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 2: Previous visit exists but follow-up visit is scheduled before previous visit
-- Expected Result: Fail - The follow-up visit must be scheduled after the previous visit
DECLARE
    var_output VARCHAR2(200);
BEGIN
    prc_followup_visit(9, TO_DATE('2024-04-19 15:00', 'YYYY-MM-DD HH24:MI'), 45, var_output);
    dbms_output.put_line(var_output);
END;
/

-- Data after Test Case 2
SELECT *
FROM visit
ORDER BY visit_id;

SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 3: Previous visit exists but follow-up visit is scheduled on the same exact date and time as previous visit
-- Expected Result: Fail - The follow-up visit must be scheduled after the previous visit
DECLARE
    var_output VARCHAR2(200);
BEGIN
    prc_followup_visit(9, TO_DATE('2024-04-21 15:00', 'YYYY-MM-DD HH24:MI'), 45, var_output);
    dbms_output.put_line(var_output);
END;
/

-- Data after Test Case 3
SELECT *
FROM visit
ORDER BY visit_id;

SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 4: Previous visit exists and follow-up visit is scheduled on the same day as previous visit but at a later time
-- Expected Result: Success - Follow-up visit successfully scheduled
DECLARE
    var_output VARCHAR2(200);
BEGIN
    prc_followup_visit(8, TO_DATE('2024-04-19 16:15', 'YYYY-MM-DD HH24:MI'), 90, var_output);
    dbms_output.put_line(var_output);
END;
/

-- Data after Test Case 4
SELECT *
FROM visit
ORDER BY visit_id;

SELECT *
FROM visit_service
ORDER BY visit_id;

-- Test Case 5: Previous visit exists and follow-up visit is scheduled on a later date than previous visit
-- Expected Result: Success - Follow-up visit successfully scheduled
DECLARE
    var_output VARCHAR2(200);
BEGIN
    prc_followup_visit(12, TO_DATE('2024-05-04 10:30', 'YYYY-MM-DD HH24:MI'), 30, var_output);
    dbms_output.put_line(var_output);
END;
/

-- Data after Test Case 5
SELECT *
FROM visit
ORDER BY visit_id;

SELECT *
FROM visit_service
ORDER BY visit_id;

ROLLBACK;

SET serveroutput OFF
