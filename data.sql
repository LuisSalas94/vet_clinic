/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true, 11);

/*Insert the following data: */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, FALSE, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, TRUE, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, TRUE, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, TRUE, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-04-14', 4, TRUE, 22);

/*
Insert the following data into the owners table:
  Sam Smith 34 years old.
  Jennifer Orwell 19 years old.
  Bob 45 years old.
  Melody Pond 77 years old.
  Dean Winchester 14 years old.
  Jodie Whittaker 38 years old.
*/
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/*
Insert the following data into the species table:
  Pokemon
  Digimon
*/
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/*
Modify your inserted animals so it includes the species_id value:
  If the name ends in "mon" it will be Digimon
  All other animals are Pokemon
*/
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

/*
Modify your inserted animals to include owner information (owner_id):
  Sam Smith owns Agumon.
  Jennifer Orwell owns Gabumon and Pikachu.
  Bob owns Devimon and Plantmon.
  Melody Pond owns Charmander, Squirtle, and Blossom.
  Dean Winchester owns Angemon and Boarmon.
*/
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';

/*Vet clinic database: add "join table" for visits*/
/*
Insert the following data for vets:
  Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
  Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
  Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
  Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
*/
INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

/*
Insert the following data for specialties:
  Vet William Tatcher is specialized in Pokemon.
  Vet Stephanie Mendez is specialized in Digimon and Pokemon.
  Vet Jack Harkness is specialized in Digimon.
*/

INSERT INTO specializations (vets_id, species_id) VALUES (1, 1);
INSERT INTO specializations (vets_id, species_id) VALUES (3, 1);
INSERT INTO specializations (vets_id, species_id) VALUES (3, 2);
INSERT INTO specializations (vets_id, species_id) VALUES (4, 2);

/*Insert the following data for visits:*/
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (1, 1, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (1, 3, '2020-07-22');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (2, 4, '2021-02-02');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (3, 2, '2020-01-05');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (3, 2, '2020-03-08');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (3, 2, '2020-05-14');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (4, 3, '2021-05-04');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (5, 4, '2021-02-24');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (6, 2, '2019-12-21');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (6, 1, '2020-08-10');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (6, 2, '2021-04-07');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (7, 3, '2019-09-29');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (8, 4, '2020-10-03');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (8, 4, '2020-11-04');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (9, 2, '2019-01-24');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (9, 2, '2019-05-15');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (9, 2, '2020-02-27');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (9, 2, '2020-08-03');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (10, 3, '2020-05-24');
INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (10, 1, '2021-01-11');