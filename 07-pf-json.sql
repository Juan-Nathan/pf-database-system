/*
  --Pets First JSON Export Query--
  --pf-json.sql

  Description:
  This script generates a JSON collection of all clinics in the Pets First system,
  including each clinic's head vet, list of all vets, and their specialisations.
  The output is structured for use in NoSQL environments such as MongoDB.
*/

SELECT 
    JSON_OBJECT ('_id' VALUE c.clinic_id,
                'name' VALUE c.clinic_name,
                'address' VALUE c.clinic_address,
                'phone' VALUE c.clinic_phone,
                'head_vet' VALUE JSON_OBJECT (
                            'id' VALUE hv.vet_id,
                            'name' VALUE TRIM(hv.vet_givenname || ' ' || hv.vet_familyname)),
                'no_of_vets' VALUE COUNT(v.vet_id),
                'vets' VALUE JSON_ARRAYAGG (
                            JSON_OBJECT (
                                    'id' VALUE v.vet_id,
                                    'name' VALUE TRIM(v.vet_givenname || ' ' || v.vet_familyname),
                                    'specialisation' VALUE NVL(s.spec_description, 'N/A'))
                        )
    FORMAT JSON )
    || ','
FROM 
    clinic c
    JOIN vet hv ON hv.vet_id = c.vet_id
    LEFT JOIN vet v ON v.clinic_id = c.clinic_id
    LEFT JOIN specialisation s ON s.spec_id = v.spec_id
GROUP BY 
    c.clinic_id, 
    c.clinic_name, 
    c.clinic_address, 
    c.clinic_phone, 
    hv.vet_id, 
    hv.vet_givenname, 
    hv.vet_familyname
ORDER BY 
    c.clinic_id;
