# 🐾 Pets First (PF) Veterinary Database System

This project implements a complete **relational and NoSQL database solution** for **Pets First**, a fictional network of veterinary clinics. The system models clinics, vets, animals, visits, and treatments using **Oracle SQL** and extends to **MongoDB** for advanced JSON-based data representation and flexible queries.

## 📦 Project Structure

| File Name                  | Description |
|--------------------------- |-------------|
| `T1-pf-ddl.sql`            | DDL statements: `CREATE TABLE`, `ALTER TABLE`, and constraints |
| `T2-pf-inserts.sql`        | Valid `INSERT` statements for visits, services, and drugs |
| `T3-pf-dml.sql`            | DML operations: sequences, inserting visits, assigning services and drugs |
| `T4-pf-updates.sql`        | Modifications to the database for new business rules |
| `T5-pf-plsql.sql`          | PL/SQL trigger and procedure:
  - `check_visit_service_cost`: Ensures service cost within ±10% of standard
  - `prc_followup_visit`: Automates follow-up visit insertion |
| `T6-pf-json.sql`           | SQL query to export clinic and vet data in JSON format |
| `T6-pf-mongo.mongodb.js`   | MongoDB script to create and manipulate JSON documents for clinics and vets |

## 🧰 Technologies Used

- **Oracle SQL**
  - DDL and DML scripting
  - PL/SQL trigger and procedure development
  - JSON generation via `JSON_OBJECT` and `JSON_ARRAYAGG`

- **MongoDB**
  - Document-based modelling of clinic-vet relationships
  - Queries with `$in`, `$push`, `$set`, and `$inc`
  - Data manipulation via `insertMany()` and `updateOne()`

## ✨ Key Features

- **Referential Integrity**: Enforced through foreign key constraints and valid inserts.
- **Business Rule Enforcement**: Trigger restricts service pricing deviations beyond 10%.
- **Automation via Procedures**: Follow-up visits are scheduled with inherited data from previous visits.
- **Hybrid SQL-NoSQL Design**: Combines structured relational storage with document-style JSON/MongoDB views for flexibility and analytics.
- **Test Harnesses**: All triggers and procedures are supported with robust test cases for validation.

## 🧪 Sample JSON Structure

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


Developed by Juan Nathan for FIT3171 at Monash University.
