/*
  --Pets First Visit Tables--
  --pf-schema.sql

  Description:
  This file defines the schema for recording clinic visits,
  including associated drugs and services, with all relevant constraints.
*/

-- VISIT
CREATE TABLE visit (
    visit_id         NUMBER(5) NOT NULL,
    visit_date_time  DATE NOT NULL,
    visit_length     NUMBER(2) NOT NULL,
    visit_notes      VARCHAR2(200),
    visit_weight     NUMBER(4,1),
    visit_total_cost NUMBER(6,2),
    animal_id        NUMBER(5) NOT NULL,
    vet_id           NUMBER(4) NOT NULL,
    clinic_id        NUMBER(2) NOT NULL,
    from_visit_id    NUMBER(5)
);

COMMENT ON COLUMN visit.visit_id IS
    'Identifier for the visit';

COMMENT ON COLUMN visit.visit_date_time IS
    'Date and time of the visit';

COMMENT ON COLUMN visit.visit_length IS
    'Visit length in minutes';

COMMENT ON COLUMN visit.visit_notes IS
    'Vet notes from the visit';

COMMENT ON COLUMN visit.visit_weight IS
    'Weight of the animal in Kgs';

COMMENT ON COLUMN visit.visit_total_cost IS
    'Total cost of the visit';

COMMENT ON COLUMN visit.animal_id IS
    'Animal identifier';

COMMENT ON COLUMN visit.vet_id IS
    'Identifier for the vet';

COMMENT ON COLUMN visit.clinic_id IS
    'Identifier for clinic';

COMMENT ON COLUMN visit.from_visit_id IS
    'Identifier for the visit';

ALTER TABLE visit ADD CONSTRAINT visit_pk PRIMARY KEY ( visit_id );

ALTER TABLE visit ADD CONSTRAINT chk_visit_length CHECK ( visit_length BETWEEN 30 AND 90 );

ALTER TABLE visit ADD CONSTRAINT visit_uq UNIQUE ( visit_date_time, animal_id );

ALTER TABLE visit ADD CONSTRAINT visit_uq_2 UNIQUE ( visit_date_time, vet_id );

-- VISIT_DRUG
CREATE TABLE visit_drug (
    visit_id               NUMBER(5) NOT NULL,
    drug_id                NUMBER(4) NOT NULL,
    visit_drug_dose        VARCHAR2(20) NOT NULL,
    visit_drug_frequency   VARCHAR2(20),
    visit_drug_qtysupplied NUMBER(2) NOT NULL,
    visit_drug_linecost    NUMBER(5,2) NOT NULL
);

COMMENT ON COLUMN visit_drug.visit_id IS
    'Identifier for the visit';

COMMENT ON COLUMN visit_drug.drug_id IS
    'Drug identifier';

COMMENT ON COLUMN visit_drug.visit_drug_dose IS
    'Dose of the drug prescribed in the visit';

COMMENT ON COLUMN visit_drug.visit_drug_frequency IS
    'Frequency prescribed for the drug in the visit';

COMMENT ON COLUMN visit_drug.visit_drug_qtysupplied IS
    'Quantity of the drug supplied';

COMMENT ON COLUMN visit_drug.visit_drug_linecost IS
    'Cost charged for the drug in the visit';

ALTER TABLE visit_drug ADD CONSTRAINT visit_drug_pk PRIMARY KEY ( visit_id, drug_id );

-- VISIT_SERVICE
CREATE TABLE visit_service (
    visit_id               NUMBER(5) NOT NULL,
    service_code           CHAR(5) NOT NULL,
    visit_service_linecost NUMBER(6,2)
);

COMMENT ON COLUMN visit_service.visit_id IS
    'Identifier for the visit';

COMMENT ON COLUMN visit_service.service_code IS
    'Service code identifier';

COMMENT ON COLUMN visit_service.visit_service_linecost IS
    'Cost charged for the service in the visit';

ALTER TABLE visit_service ADD CONSTRAINT visit_service_pk PRIMARY KEY ( visit_id, service_code );

-- Add all missing FK Constraints below here
ALTER TABLE visit
    ADD CONSTRAINT animal_visit_fk FOREIGN KEY ( animal_id )
        REFERENCES animal ( animal_id );

ALTER TABLE visit
    ADD CONSTRAINT vet_visit_fk FOREIGN KEY ( vet_id )
        REFERENCES vet ( vet_id );

ALTER TABLE visit
    ADD CONSTRAINT clinic_visit_fk FOREIGN KEY ( clinic_id )
        REFERENCES clinic ( clinic_id );

ALTER TABLE visit
    ADD CONSTRAINT fromvisit_visit_fk FOREIGN KEY ( from_visit_id )
        REFERENCES visit ( visit_id );

ALTER TABLE visit_drug
    ADD CONSTRAINT visit_visitdrug_fk FOREIGN KEY ( visit_id )
        REFERENCES visit ( visit_id );

ALTER TABLE visit_drug
    ADD CONSTRAINT drug_visitdrug_fk FOREIGN KEY ( drug_id )
        REFERENCES drug ( drug_id );

ALTER TABLE visit_service
    ADD CONSTRAINT visit_visitservice_fk FOREIGN KEY ( visit_id )
        REFERENCES visit ( visit_id );

ALTER TABLE visit_service
    ADD CONSTRAINT service_visitservice_fk FOREIGN KEY ( service_code )
        REFERENCES service ( service_code );
