/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE escape_attempts < 3 AND neutered = true;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/*
Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
*/
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

/*
Inside a transaction:
    Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
    Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
    Commit the transaction.
    Verify that change was made and persists after commit.
*/
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

/*
Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual.
*/
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*
Inside a transaction:
    Delete all animals born after Jan 1st, 2022.
    Create a savepoint for the transaction.
    Update all animals' weight to be their weight multiplied by -1.
    Rollback to the savepoint
    Update all animals' weights that are negative to be their weight multiplied by -1.
    Commit transaction
*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
COMMIT;

/*
Write queries to answer the following questions:
 How many animals are there?
 How many animals have never tried to escape?
 What is the average weight of animals?
 Who escapes the most, neutered or not neutered animals?
 What is the minimum and maximum weight of each type of animal?
 What is the average number of escape attempts per animal type of those born between 1990 and 2000?
*/

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT name FROM animals WHERE escape_attempts = (
  SELECT MAX(escape_attempts) FROM animals
);

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '19900101'
 AND date_of_birth < '20010101' GROUP BY species;
 
/*
 Write queries (using JOIN) to answer the following questions:
  What animals belong to Melody Pond?
  List of all animals that are pokemon (their type is Pokemon).
  List all owners and their animals, remember to include those that don't own any animal.
  How many animals are there per species?
  List all Digimon owned by Jennifer Orwell.
  List all animals owned by Dean Winchester that haven't tried to escape.
  Who owns the most animals?
*/

SELECT name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT * FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT full_name, animals.name from owners LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.species_id) FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;


SELECT full_name, animals.name FROM animals INNER JOIN owners ON animals.owner_id = owners.id INNER JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT full_name, name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT full_name FROM owners INNER JOIN animals ON owners.id = animals.owner_id GROUP BY owners.id ORDER BY COUNT(animals) DESC LIMIT 1;

/*Vet clinic database: add "join table" for visits
Write queries to answer the following:
*/
/*Who was the last animal seen by William Tatcher?*/
SELECT animals.name, visit_date FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY visits.visit_date DESC LIMIT 1;

/*How many different animals did Stephanie Mendez see?*/
SELECT DISTINCT COUNT(animals.name) FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Stephanie Mendez';

/*List all vets and their specialties, including vets with no specialties.*/
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON specializations.species_id = species.id;

/*List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT animals.name FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date >= '2020-04-01' AND visits.visit_date <= '2020-08-30';

/*What animal has the most visits to vets?*/

SELECT animals.name, COUNT(animals.name) FROM animals INNER JOIN visits ON animals.id = visits.animals_id GROUP BY animals.name ORDER BY COUNT DESC LIMIT 1;


/*Who was Maisy Smith's first visit?*/
SELECT animals.name, visits.visit_date FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id WHERE vets.name = 'Maisy Smith' ORDER BY visits.visit_date ASC LIMIT 1;

/*Details for most recent visit: animal information, vet information, and date of visit.*/
SELECT animals.*, vets.*, visits.visit_date FROM animals INNER JOIN visits ON animals.id = visits.animals_id INNER JOIN vets ON visits.vets_id = vets.id ORDER BY visits.visit_date DESC LIMIT 1;

/*How many visits were with a vet that did not specialize in that animal's species?*/
SELECT COUNT(visits.visit_date) FROM vets INNER JOIN visits ON visits.vets_id = vets.id INNER JOIN animals ON animals.id = visits.animals_id INNER JOIN specializations ON vets.id = specializations.vets_id INNER JOIN species ON specializations.species_id = species.id WHERE animals.species_id <> specializations.species_id;


/*What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT species.name, COUNT(*) FROM animals INNER JOIN visits ON visits.animals_id = animals.id INNER JOIN vets ON vets.id = visits.vets_id INNER JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY count DESC LIMIT 1;