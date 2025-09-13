# 🐾 Pets First Database System

This project involves creating, populating, and manipulating a relational database in **Oracle Database** using SQL and PL/SQL, with JSON export for **MongoDB** integration. It implements a complete schema for **Pets First (PF)**, a fictional network of veterinary clinics, featuring realistic data population, schema modifications, and enforcement of business rules through triggers and procedures.

## Project Structure

| File                            | Description                                                                                                                                                         |
|------------------------------   |---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `01-pf-initialSchemaInsert.sql` | Defines and populates base schema tables (`animal`, `clinic`, `drug`, etc.)                                                                                         |
| `02-pf-schema.sql`              | Creates remaining schema tables: `visit`, `visit_service`, and `visit_drug` with keys and constraints                                                               |
| `03-pf-insert.sql`              | Inserts visit records with detailed service and drug data                                                                                                           |
| `04-pf-dml.sql`                 | Creates sequence and performs inserts/updates/deletes for `visit`, `visit_service`, and `visit_drug`                                                                |
| `05-pf-mods.sql`                | Modifies schema to support new business requirements                                                                                                                |
| `06-pf-plsql.sql`               | Creates trigger and procedure for visits:<br>• `check_visit_service_cost`: Validates service charges for visits<br>• `prc_followup_visit`: Inserts follow-up visits |
| `07-pf-json.sql`                | Exports clinic and vet data as nested JSON using SQL query                                                                                                          |
| `08-pf-mongo.mongodb.js`        | Loads and manipulates JSON documents in MongoDB                                                                                                                     |

## Key Features

- **Referential Integrity**: Enforced through foreign key constraints and valid inserts.
- **Service Pricing Integrity**: Trigger enforces a ±10% limit on service charge deviations.
- **Follow-Up Visit Automation**: Procedure schedules follow-up visits with inherited data from previous visits.
- **Test Harnesses**: Trigger and procedure are supported with robust test cases for validation.
- **Hybrid SQL–NoSQL Architecture**: Integrates relational schema with MongoDB documents to support both structured storage and flexible data handling.

## Sample JSON Structure

Each MongoDB document represents a clinic, its head vet, and all associated vets:

```json
{
  "_id": 5,
  "name": "Brighton East Pet Care",
  "address": "123 Thomas St, Brighton East VIC 3187",
  "phone": "0398765412",
  "head_vet": {
    "id": 1007,
    "name": "Jessica Lee"
  },
  "no_of_vets": 3,
  "vets": [
    {
      "id": 1010,
      "name": "Michael Clarkson",
      "specialisation": "Cardiology"
    },
    {
      "id": 1009,
      "name": "Sarah Morris",
      "specialisation": "N/A"
    },
    {
      "id": 1007,
      "name": "Jessica Lee",
      "specialisation": "Behavioral Medicine"
    }
  ]
}
```

## Technologies Used

- **Database Platforms**: Oracle Database, MongoDB
- **Languages**: SQL (DDL/DML), PL/SQL, MongoDB Query Language

## Author

Developed by Juan Nathan.






