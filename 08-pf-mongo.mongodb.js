// =============================================================================
// Pets First MongoDB Script
// pf-mongo.mongodb.js

// Description:
// This script creates and manages the `clinicvets` collection for the Pets First
// database in MongoDB. It includes data insertion, JSON-based document queries,
// and updates such as adding a new vet and changing the head vet.
// =============================================================================

use("jnat0014");

// Creates the `clinicvets` collection by inserting JSON documents
// that represent clinics along with their head vet and list of vets.
// Existing collection (if any) is dropped before insertion.

// Drop collection
db.clinicvets.drop();

// Create collection and insert documents
db.clinicvets.insertMany([
    {"_id":1,"name":"East Melbourne Veterinary Center","address":"47 Blackburn Road, Burwood East VIC 3151","phone":"0398123456","head_vet":{"id":1001,"name":"Emily Tanner"},"no_of_vets":2,"vets":[{"id":1001,"name":"Emily Tanner","specialisation":"General Practice"},{"id":1006,"name":"Sophie Grant","specialisation":"Dermatology"}]},
    {"_id":2,"name":"Northern Suburbs Animal Hospital","address":"78 High St, Thornbury VIC 3071","phone":"0390215478","head_vet":{"id":1003,"name":"John"},"no_of_vets":2,"vets":[{"id":1003,"name":"John","specialisation":"Emergency Medicine"},{"id":1005,"name":"Owen Murphy","specialisation":"N/A"}]},
    {"_id":3,"name":"Bayside Veterinary Clinic","address":"32 Bay Rd, Sandringham VIC 3191","phone":"0398765433","head_vet":{"id":1004,"name":"Anna Kowalski"},"no_of_vets":2,"vets":[{"id":1004,"name":"Anna Kowalski","specialisation":"Dentistry"},{"id":1008,"name":"Watson","specialisation":"N/A"}]},
    {"_id":4,"name":"Glen Iris Vet Clinic","address":"1501 High St, Glen Iris VIC 3146","phone":"0398123458","head_vet":{"id":1002,"name":"Lucas Bennet"},"no_of_vets":2,"vets":[{"id":1002,"name":"Lucas Bennet","specialisation":"Dermatology"},{"id":1011,"name":"Liam Foster","specialisation":"Cardiology"}]},
    {"_id":5,"name":"Brighton East Pet Care","address":"123 Thomas St, Brighton East VIC 3187","phone":"0398765412","head_vet":{"id":1007,"name":"Jessica Lee"},"no_of_vets":3,"vets":[{"id":1010,"name":"Michael Clarkson","specialisation":"Cardiology"},{"id":1009,"name":"Sarah Morris","specialisation":"N/A"},{"id":1007,"name":"Jessica Lee","specialisation":"Behavioral Medicine"}]}
]);

// List all documents you added
db.clinicvets.find();

// Queries for all clinics that have at least one vet specialising in
// either Dermatology or Cardiology, returning only the clinic name and address.
db.clinicvets.find({"vets.specialisation": {"$in": ["Dermatology", "Cardiology"]}}, {"_id": 0, "name": 1, "address": 1});

// Updates clinic with _id: 5 by adding a new vet to the list,
// incrementing the number of vets, and setting the new vet as the head vet.
// Shows the document before and after modification.

// Show document before the new vet is added
db.clinicvets.find({"_id": 5});

// Add new vet and set the vet as the head of clinic
db.clinicvets.updateOne({"_id": 5}, {"$push": {"vets": {"id": 1020, "name": "Sarah Wilkinson", "specialisation": "Dentistry"}}});
db.clinicvets.updateOne({"_id": 5}, {"$inc": {"no_of_vets": 1}});
db.clinicvets.updateOne({"_id": 5}, {"$set": {"head_vet": {"id": 1020, "name": "Sarah Wilkinson"}}});

// Illustrate/confirm changes made
db.clinicvets.find({"_id": 5});
