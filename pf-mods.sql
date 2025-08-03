/*
  --Pets First Schema Modifications and Payment Tables--
  --pf-mods.sql

  Description:
  This script modifies the service table to track non-standard charges
  and creates new tables for payment and payment methods. It also populates
  historical payment data using sequence-generated payment numbers.
*/

/* 
   Adds a new column to the service table to count how many times a service
   has been charged at a non-standard cost. Populates the column accordingly.
*/
ALTER TABLE service
ADD service_non_std_charge_count NUMBER(3) DEFAULT 0 NOT NULL;

COMMENT ON COLUMN service.service_non_std_charge_count IS
    'Number of non-standard charges for the service';

UPDATE service
SET service_non_std_charge_count = (
    SELECT COUNT(*)
    FROM visit_service
    WHERE visit_service.service_code = service.service_code
    AND visit_service.visit_service_linecost != service.service_std_cost
);

COMMIT;

SELECT *
FROM service
ORDER BY service_code;

DESC service;

/* 
   Creates new tables: payment_method and payment.
   Establishes constraints and inserts predefined payment methods.
   Then populates the payment table with historical data from past visits
   using a new sequence to generate unique payment numbers.
*/
DROP TABLE payment_method CASCADE CONSTRAINTS PURGE;

CREATE TABLE payment_method (
    payment_method_id   NUMBER(2) NOT NULL,
    payment_method_name VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN payment_method.payment_method_id IS
    'Identifier for the payment method';

COMMENT ON COLUMN payment_method.payment_method_name IS
    'Name of the payment method';

ALTER TABLE payment_method ADD CONSTRAINT payment_method_pk PRIMARY KEY ( payment_method_id );

DROP TABLE payment CASCADE CONSTRAINTS PURGE;

CREATE TABLE payment (
    payment_no         NUMBER(5) NOT NULL,
    payment_date_time  DATE NOT NULL,
    payment_amount     NUMBER(6,2) NOT NULL,
    visit_id           NUMBER(5) NOT NULL,
    payment_method_id  NUMBER(2) NOT NULL
);

COMMENT ON COLUMN payment.payment_no IS
    'Unique payment number';

COMMENT ON COLUMN payment.payment_date_time IS
    'Date and time of the payment';

COMMENT ON COLUMN payment.payment_amount IS
    'Amount of the payment';

COMMENT ON COLUMN payment.visit_id IS
    'Identifier for the visit';

COMMENT ON COLUMN payment.payment_method_id IS
    'Identifier for the payment method';

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( payment_no );

ALTER TABLE payment
    ADD CONSTRAINT visit_payment_fk FOREIGN KEY ( visit_id )
        REFERENCES visit ( visit_id );

ALTER TABLE payment
    ADD CONSTRAINT paymentmethod_payment_fk FOREIGN KEY ( payment_method_id )
        REFERENCES payment_method ( payment_method_id );

INSERT INTO payment_method (payment_method_id, payment_method_name) VALUES (1, 'Card');
INSERT INTO payment_method (payment_method_id, payment_method_name) VALUES (2, 'Cash');
INSERT INTO payment_method (payment_method_id, payment_method_name) VALUES (3, 'Historical');

COMMIT;

DROP SEQUENCE payment_no_seq;

CREATE SEQUENCE payment_no_seq START WITH 1 INCREMENT BY 1;

INSERT INTO payment (payment_no, payment_date_time, payment_amount, visit_id, payment_method_id)
SELECT 
    payment_no_seq.NEXTVAL, 
    visit_date_time, 
    visit_total_cost, 
    visit_id, 
    3
FROM
    (SELECT 
        visit_date_time, 
        visit_total_cost, 
        visit_id
    FROM
        visit
    WHERE
        visit_total_cost IS NOT NULL
    ORDER BY
        visit_id);

COMMIT;

SELECT *
FROM payment_method
ORDER BY payment_method_id;

SELECT *
FROM payment
ORDER BY payment_no;

DESC payment_method;

DESC payment;
