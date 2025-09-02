# 🐾 Pets First Veterinary Database System

This project involves creating, populating, and manipulating a relational database in Oracle Database, with data exported as JSON for MongoDB integration. It implements a complete schema for Pets First (PF)—a fictional network of veterinary clinics—featuring realistic data population, schema modifications, and business rules enforced through triggers and procedures.

## Project Structure

| File Name                    | Description                                                                                                           |
|------------------------------|-----------------------------------------------------------------------------------------------------------------------|
| `pf-initialSchemaInsert.sql` | Creates and populates base schema tables (`animal`, `clinic`, `drug`, etc.)                                           |
| `pf-ddl.sql`                 | Defines remaining schema: `CREATE TABLE`, `ALTER TABLE`, and constraints for `visit`, `visit_service`, and `visit_drug` |
| `pf-inserts.sql`             | Inserts visit records with detailed service and drug data                                                   |
| `pf-dml.sql`                 | DML operations: sequences, inserting visits, assigning services and drugs                                             |
| `pf-mods.sql`                | Schema and data updates to support new requirements                                                                 |
| `pf-plsql.sql`               | Trigger and procedure:<br>• `check_visit_service_cost`: Validates service charges<br>• `prc_followup_visit`: Inserts follow-up visits |
| `pf-json.sql`                | SQL query to export clinic and vet data as nested JSON                                                                |
| `pf-mongo.mongodb.js`        | MongoDB script to load and manipulate the JSON documents                                                              |

## Technologies Used

- **Oracle Database**
  - DDL and DML scripting
  - PL/SQL trigger and procedure development
  - JSON generation via `JSON_OBJECT` and `JSON_ARRAYAGG`

- **MongoDB**
  - Document-based modeling of clinic-vet relationships
  - Queries with `$in`, `$push`, `$set`, and `$inc`
  - Data manipulation via `insertMany()` and `updateOne()`

## Key Features

- **Referential Integrity**: Enforced through foreign key constraints and valid inserts.
- **Business Rule Enforcement**: Trigger restricts service pricing deviations beyond or under 10%.
- **Automation via Procedures**: Follow-up visits are scheduled with inherited data from previous visits.
- **Hybrid SQL-NoSQL Design**: Combines structured relational storage with document-style JSON/MongoDB views for flexibility and analytics.
- **Test Harnesses**: All triggers and procedures are supported with robust test cases for validation.

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

## 👤 Author

Developed by Juan Nathan for FIT3171 at Monash University Malaysia.














