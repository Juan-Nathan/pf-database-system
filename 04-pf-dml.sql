/*
  --Pets First Visit DML Operations--
  --pf-dml.sql

  Description:
  This script performs DML operations on the Pets First database.
  It includes insertions, updates, deletions, and sequence creation
  for recording and managing animal visit information.
*/

/*
   Drops the existing sequence (if any) and creates a new one
   for generating visit IDs starting from 100 with increments of 10.
*/
DROP SEQUENCE visit_id_seq;

CREATE SEQUENCE visit_id_seq START WITH 100 INCREMENT BY 10;

/* 
   Inserts a new visit record for Oreo using sequence-generated ID.
   Also inserts the initial service with null cost (to be updated later).
*/
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
    TO_DATE('2024-05-19 14:00', 'YYYY-MM-DD HH24:MI'), 
    30, 
    null, 
    null, 
    null, 
    (
        SELECT animal_id 
        FROM animal 
        WHERE 
            UPPER(animal_name) = UPPER('Oreo') 
            AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
            AND UPPER(animal_deceased) = UPPER('N') 
            AND owner_id = 
            (
                SELECT owner_id 
                FROM owner 
                WHERE 
                    UPPER(owner_givenname) = UPPER('Jack') 
                    AND UPPER(owner_familyname) = UPPER('JONES')
            )
            AND atype_id = 
            (
                SELECT atype_id 
                FROM animal_type 
                WHERE UPPER(atype_description) = UPPER('rabbit')
            )
    ), 
    (
        SELECT vet_id 
        FROM vet 
        WHERE 
            UPPER(vet_givenname) = UPPER('Anna') 
            AND UPPER(vet_familyname) = UPPER('KOWALSKI')
    ), 
    3, 
    null
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
    'S001', 
    null
);

COMMIT;

/* 
   Adds an additional service and a drug for the same visit.
   Updates the visit's service cost, total cost, notes, and weight.
   Then inserts a follow-up visit scheduled 7 days later.
*/
INSERT INTO visit_service
(
    visit_id,
    service_code,
    visit_service_linecost
)
VALUES
(
    (
        SELECT visit_id
        FROM visit
        WHERE
            animal_id = 
        (
            SELECT animal_id 
            FROM animal 
            WHERE 
                UPPER(animal_name) = UPPER('Oreo') 
                AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
                AND UPPER(animal_deceased) = UPPER('N') 
                AND owner_id = 
                (
                    SELECT owner_id 
                    FROM owner 
                    WHERE 
                        UPPER(owner_givenname) = UPPER('Jack') 
                        AND UPPER(owner_familyname) = UPPER('JONES')
                )
                AND atype_id = 
                (
                    SELECT atype_id 
                    FROM animal_type 
                    WHERE UPPER(atype_description) = UPPER('rabbit')
                )
        )
        AND visit_date_time = TO_DATE('2024-05-19 14:00', 'YYYY-MM-DD HH24:MI')
    ),
    (
        SELECT service_code
        FROM service
        WHERE
            UPPER(service_desc) = UPPER('ear infection treatment')
    ),
    (
        SELECT service_std_cost 
        FROM service
        WHERE
            UPPER(service_desc) = UPPER('ear infection treatment')
    )
);

UPDATE visit_service
SET
    visit_service_linecost = 
    (
        SELECT service_std_cost 
        FROM service 
        WHERE UPPER(service_code) = UPPER('S001')
    )
WHERE
    visit_id = 
    (
        SELECT visit_id
        FROM visit
        WHERE
            animal_id = 
        (
            SELECT animal_id 
            FROM animal 
            WHERE 
                UPPER(animal_name) = UPPER('Oreo') 
                AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
                AND UPPER(animal_deceased) = UPPER('N') 
                AND owner_id = 
                (
                    SELECT owner_id 
                    FROM owner 
                    WHERE 
                        UPPER(owner_givenname) = UPPER('Jack') 
                        AND UPPER(owner_familyname) = UPPER('JONES')
                )
                AND atype_id = 
                (
                    SELECT atype_id 
                    FROM animal_type 
                    WHERE UPPER(atype_description) = UPPER('rabbit')
                )
        )
        AND visit_date_time = TO_DATE('2024-05-19 14:00', 'YYYY-MM-DD HH24:MI')
    )
    AND UPPER(service_code) = UPPER('S001');

INSERT INTO visit_drug
(
    visit_id,
    drug_id,
    visit_drug_dose,
    visit_drug_frequency,
    visit_drug_qtysupplied,
    visit_drug_linecost
)
VALUES
(
    (
        SELECT visit_id
        FROM visit
        WHERE
            animal_id = 
        (
            SELECT animal_id 
            FROM animal 
            WHERE 
                UPPER(animal_name) = UPPER('Oreo') 
                AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
                AND UPPER(animal_deceased) = UPPER('N') 
                AND owner_id = 
                (
                    SELECT owner_id 
                    FROM owner 
                    WHERE 
                        UPPER(owner_givenname) = UPPER('Jack') 
                        AND UPPER(owner_familyname) = UPPER('JONES')
                )
                AND atype_id = 
                (
                    SELECT atype_id 
                    FROM animal_type 
                    WHERE UPPER(atype_description) = UPPER('rabbit')
                )
        )
        AND visit_date_time = TO_DATE('2024-05-19 14:00', 'YYYY-MM-DD HH24:MI')
    ),
    (
        SELECT drug_id
        FROM drug
        WHERE
            UPPER(drug_name) = UPPER('Clotrimazole')
    ),
    '0.5 mL',
    'Apply twice daily',
    1,
    (
        SELECT drug_std_cost * 1
        FROM drug
        WHERE UPPER(drug_name) = UPPER('Clotrimazole')
    )
);

UPDATE visit
SET
    visit_notes = 'Oreo has an ear infection',
    visit_weight = 2.2,
    visit_total_cost = 
    (
        SELECT SUM(visit_service_linecost)
        FROM visit_service
        WHERE visit_id = 
        (
            SELECT visit_id
            FROM visit
            WHERE
                animal_id = 
            (
                SELECT animal_id 
                FROM animal 
                WHERE 
                    UPPER(animal_name) = UPPER('Oreo') 
                    AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
                    AND UPPER(animal_deceased) = UPPER('N') 
                    AND owner_id = 
                    (
                        SELECT owner_id 
                        FROM owner 
                        WHERE 
                            UPPER(owner_givenname) = UPPER('Jack') 
                            AND UPPER(owner_familyname) = UPPER('JONES')
                    )
                    AND atype_id = 
                    (
                        SELECT atype_id 
                        FROM animal_type 
                        WHERE UPPER(atype_description) = UPPER('rabbit')
                    )
            )
            AND visit_date_time = TO_DATE('2024-05-19 14:00', 'YYYY-MM-DD HH24:MI')
        )
    )
    +
    (
        SELECT SUM(visit_drug_linecost)
        FROM visit_drug
        WHERE visit_id = 
        (
            SELECT visit_id
            FROM visit
            WHERE
                animal_id = 
            (
                SELECT animal_id 
                FROM animal 
                WHERE 
                    UPPER(animal_name) = UPPER('Oreo') 
                    AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
                    AND UPPER(animal_deceased) = UPPER('N') 
                    AND owner_id = 
                    (
                        SELECT owner_id 
                        FROM owner 
                        WHERE 
                            UPPER(owner_givenname) = UPPER('Jack') 
                            AND UPPER(owner_familyname) = UPPER('JONES')
                    )
                    AND atype_id = 
                    (
                        SELECT atype_id 
                        FROM animal_type 
                        WHERE UPPER(atype_description) = UPPER('rabbit')
                    )
            )
            AND visit_date_time = TO_DATE('2024-05-19 14:00', 'YYYY-MM-DD HH24:MI')
        )
    )
WHERE
    animal_id = 
    (
        SELECT animal_id 
        FROM animal 
        WHERE 
            UPPER(animal_name) = UPPER('Oreo') 
            AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
            AND UPPER(animal_deceased) = UPPER('N') 
            AND owner_id = 
            (
                SELECT owner_id 
                FROM owner 
                WHERE 
                    UPPER(owner_givenname) = UPPER('Jack') 
                    AND UPPER(owner_familyname) = UPPER('JONES')
            )
            AND atype_id = 
            (
                SELECT atype_id 
                FROM animal_type 
                WHERE UPPER(atype_description) = UPPER('rabbit')
            )
    )
    AND visit_date_time = TO_DATE('2024-05-19 14:00', 'YYYY-MM-DD HH24:MI');

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
    TO_DATE('2024-05-19 14:00', 'YYYY-MM-DD HH24:MI') + 7,
    30,
    null,
    null,
    null,
    (
        SELECT animal_id 
        FROM animal 
        WHERE 
            UPPER(animal_name) = UPPER('Oreo') 
            AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
            AND UPPER(animal_deceased) = UPPER('N') 
            AND owner_id = 
            (
                SELECT owner_id 
                FROM owner 
                WHERE 
                    UPPER(owner_givenname) = UPPER('Jack') 
                    AND UPPER(owner_familyname) = UPPER('JONES')
            )
            AND atype_id = 
            (
                SELECT atype_id 
                FROM animal_type 
                WHERE UPPER(atype_description) = UPPER('rabbit')
            )
    ),
    (
        SELECT vet_id 
        FROM vet 
        WHERE 
            UPPER(vet_givenname) = UPPER('Anna') 
            AND UPPER(vet_familyname) = UPPER('KOWALSKI')
    ),
    3,
    (
        SELECT visit_id
        FROM visit
        WHERE
            animal_id = 
        (
            SELECT animal_id 
            FROM animal 
            WHERE 
                UPPER(animal_name) = UPPER('Oreo') 
                AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
                AND UPPER(animal_deceased) = UPPER('N') 
                AND owner_id = 
                (
                    SELECT owner_id 
                    FROM owner 
                    WHERE 
                        UPPER(owner_givenname) = UPPER('Jack') 
                        AND UPPER(owner_familyname) = UPPER('JONES')
                )
                AND atype_id = 
                (
                    SELECT atype_id 
                    FROM animal_type 
                    WHERE UPPER(atype_description) = UPPER('rabbit')
                )
        )
        AND visit_date_time = TO_DATE('2024-05-19 14:00', 'YYYY-MM-DD HH24:MI')
    )
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
    (
        SELECT service_code
        FROM service
        WHERE
            UPPER(service_desc) = UPPER('ear infection treatment')
    ),
    null
);

COMMIT;

/* 
   Deletes the follow-up visit and its associated services
   for Oreo on 2024-05-26 at 14:00.
*/
DELETE FROM visit_service
WHERE
    visit_id = 
    (
        SELECT visit_id
        FROM visit
        WHERE
            animal_id = 
        (
            SELECT animal_id 
            FROM animal 
            WHERE 
                UPPER(animal_name) = UPPER('Oreo') 
                AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
                AND UPPER(animal_deceased) = UPPER('N') 
                AND owner_id = 
                (
                    SELECT owner_id 
                    FROM owner 
                    WHERE 
                        UPPER(owner_givenname) = UPPER('Jack') 
                        AND UPPER(owner_familyname) = UPPER('JONES')
                )
                AND atype_id = 
                (
                    SELECT atype_id 
                    FROM animal_type 
                    WHERE UPPER(atype_description) = UPPER('rabbit')
                )
        )
        AND visit_date_time = TO_DATE('2024-05-26 14:00', 'YYYY-MM-DD HH24:MI')
    );

DELETE FROM visit
WHERE
    visit_id = 
    (
        SELECT visit_id
        FROM visit
        WHERE
            animal_id = 
        (
            SELECT animal_id 
            FROM animal 
            WHERE 
                UPPER(animal_name) = UPPER('Oreo') 
                AND animal_born = TO_DATE('2018-06-01', 'YYYY-MM-DD') 
                AND UPPER(animal_deceased) = UPPER('N') 
                AND owner_id = 
                (
                    SELECT owner_id 
                    FROM owner 
                    WHERE 
                        UPPER(owner_givenname) = UPPER('Jack') 
                        AND UPPER(owner_familyname) = UPPER('JONES')
                )
                AND atype_id = 
                (
                    SELECT atype_id 
                    FROM animal_type 
                    WHERE UPPER(atype_description) = UPPER('rabbit')
                )
        )
        AND visit_date_time = TO_DATE('2024-05-26 14:00', 'YYYY-MM-DD HH24:MI')
    );

COMMIT;
