/*
  --Pets First Visit Insert Data--
  --pf-insert.sql

  Description:
  This script inserts visit records and their associated
  services and drugs into the Pets First database.
  Includes detailed visit information for animals, 
  including follow-ups, health programs, and treatments.
*/

--------------------------------------
--INSERT INTO visit
--------------------------------------
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (1, TO_DATE('2024-04-05 10:00', 'YYYY-MM-DD HH24:MI'), 60, 'Buddy looks skinny this year, he is lacking supplements', 22.0, 220.00, 1, 1001, 1, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (2, TO_DATE('2024-04-05 12:30', 'YYYY-MM-DD HH24:MI'), 30, 'Charlie is a healthy dog, today he gets his routine rabies vaccination', 24.8, 139.99, 2, 1001, 1, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (3, TO_DATE('2024-04-08 15:45', 'YYYY-MM-DD HH24:MI'), 90, 'Max requires an emergency surgery due to a fractured leg', 30.8, 596.00, 4, 1003, 2, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (4, TO_DATE('2024-04-10 09:00', 'YYYY-MM-DD HH24:MI'), 70, 'Whisker''s teeth need cleaning', 5.4, 100.00, 3, 1004, 3, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (5, TO_DATE('2024-04-12 16:00', 'YYYY-MM-DD HH24:MI'), 35, 'Rocky is fit and strong, today he gets his first monthly heartworm prevention medication', 25.6, 70.00, 10, 1001, 1, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (6, TO_DATE('2024-04-15 17:00', 'YYYY-MM-DD HH24:MI'), 45, 'Max''s leg is healing well; splint can be removed, another follow-up won''t be required', 30.5, 158.00, 4, 1003, 2, 3);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (7, TO_DATE('2024-04-17 10:30', 'YYYY-MM-DD HH24:MI'), 60, 'Oreo''s fur needs to be treated to remove fleas and ticks, also has an allergic reaction to the flea/tick bites', 2.2, 233.00, 7, 1006, 1, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (8, TO_DATE('2024-04-19 11:15', 'YYYY-MM-DD HH24:MI'), 90, 'Shadow has an ear infection', 6.8, 165.00, 9, 1008, 3, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (9, TO_DATE('2024-04-21 15:00', 'YYYY-MM-DD HH24:MI'), 45, 'Thumper''s cardiology examination results are not ideal', 3.5, 370.00, 6, 1010, 5, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (10, TO_DATE('2024-04-22 16:45', 'YYYY-MM-DD HH24:MI'), 60, 'Max''s heart needs some help', 30.6, 370.00, 4, 1011, 4, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (11, TO_DATE('2024-04-25 17:00', 'YYYY-MM-DD HH24:MI'), 90, 'Rex is exhibiting aggressive behaviour', 5.5, 410.00, 12, 1007, 5, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (12, TO_DATE('2024-04-27 10:30', 'YYYY-MM-DD HH24:MI'), 30, 'Bailey is visibly overweight', 31.5, 195.00, 8, 1005, 2, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (13, TO_DATE('2024-04-30 08:00', 'YYYY-MM-DD HH24:MI'), 60, 'First Senior Pet Care Program session for Whiskers', 5.3, 190.00, 3, 1001, 1, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (14, TO_DATE('2024-05-02 09:30', 'YYYY-MM-DD HH24:MI'), 45, 'First Kitten Health Program session for Smokey', 1.8, 160.00, 11, 1001, 1, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (15, TO_DATE('2024-05-05 16:00', 'YYYY-MM-DD HH24:MI'), 35, 'Rocky gets his second monthly heartworm prevention medication', 25.8, 70.00, 10, 1001, 1, 5);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (16, TO_DATE('2024-05-08 17:45', 'YYYY-MM-DD HH24:MI'), 90, 'Rex''s behaviour is a lot more stable now', 5.7, 410.00, 12, 1007, 5, 11);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (17, TO_DATE('2024-05-29 14:00', 'YYYY-MM-DD HH24:MI'), 60, null, null, null, 5, 1009, 5, null);
INSERT INTO visit (visit_id, visit_date_time, visit_length, visit_notes, visit_weight, visit_total_cost, animal_id, vet_id, clinic_id, from_visit_id) VALUES (18, TO_DATE('2024-06-03 13:30', 'YYYY-MM-DD HH24:MI'), 45, null, null, null, 9, 1002, 4, null);
--------------------------------------
--INSERT INTO visit_service
--------------------------------------
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (1, 'S011', 96.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (1, 'S019', 58.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (2, 'S002', 40.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (3, 'S004', 150.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (3, 'S014', 200.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (4, 'S006', 90.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (5, 'S007', 54.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (6, 'S001', 60.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (7, 'S008', 40.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (7, 'S009', 85.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (8, 'S001', 60.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (8, 'S010', 75.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (9, 'S016', 130.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (10, 'S016', 130.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (11, 'S020', 90.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (12, 'S001', 70.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (12, 'S019', 50.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (13, 'S017', 109.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (14, 'S018', 120.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (15, 'S007', 54.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (16, 'S020', 90.00);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (17, 'S001', null);
INSERT INTO visit_service (visit_id, service_code, visit_service_linecost) VALUES (18, 'S008', null);
--------------------------------------
--INSERT INTO visit_drug
--------------------------------------
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (1, 111, '700 mg', 'One tablet daily', 30, 36.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (1, 119, '700 mg', 'One tablet daily', 30, 30.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (2, 102, '1 mL', 'One injection', 1, 99.99);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (3, 105, '250 mg', 'One injection', 1, 50.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (3, 114, '0.308 mg', 'One tablet daily', 14, 196.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (4, 106, '350 mL', null, 1, 10.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (5, 107, '2.56 mg', 'Monthly', 1, 16);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (6, 114, '0.305 mg', 'One tablet daily', 7, 98.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (7, 108, '3 mL', 'Monthly', 1, 45.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (7, 109, '4 mg', 'One tablet daily', 14, 63.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (8, 110, '0.5 mL', 'Apply twice daily', 1, 30.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (9, 116, '100 mg', 'One tablet daily', 30, 240.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (10, 116, '500 mg', 'One tablet daily', 30, 240.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (11, 120, '250 mg', 'One tablet weekly', 4, 320.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (12, 119, '750 mg', 'One tablet daily', 30, 30.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (12, 117, '500 mg', 'One tablet daily', 30, 45.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (13, 111, '600 mg', 'One tablet daily', 30, 36.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (13, 117, '500 mg', 'One tablet daily', 30, 45.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (14, 118, '250 mg', 'One tablet daily', 1, 40.00);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (15, 107, '2.58 mg', 'Monthly', 1, 16);
INSERT INTO visit_drug (visit_id, drug_id, visit_drug_dose, visit_drug_frequency, visit_drug_qtysupplied, visit_drug_linecost) VALUES (16, 120, '250 mg', 'One tablet weekly', 4, 320.00);

COMMIT;
