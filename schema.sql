/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id);
    
);

/*Add a column species of type string to your animals table. Modify your schema.sql file.*/
ALTER TABLE animals ADD species VARCHAR(20);


/*
Create a table named owners with the following columns:
   id: integer (set it as autoincremented PRIMARY KEY)
   full_name: string
   age: integer
*/
CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50),
    age INT,
    PRIMARY KEY(id)
);

/*
Create a table named species with the following columns:
   id: integer (set it as autoincremented PRIMARY KEY)
   name: string
*/
CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    PRIMARY KEY(id)
);
/*
Modify animals table:
  Make sure that id is set as autoincremented PRIMARY KEY
  Remove column species
  Add column species_id which is a foreign key referencing species table
  Add column owner_id which is a foreign key referencing the owners table
*/
ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT REFERENCES species(id);

ALTER TABLE animals
ADD owner_id INT REFERENCES owners(id);

/*
Create a table named vets with the following columns:
 id: integer (set it as autoincremented PRIMARY KEY)
 name: string
 age: integer
 date_of_graduation: date
*/
CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

/*
There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship.
*/
CREATE TABLE specializations(
    vets_id INT REFERENCES vets(id),
    species_id INT REFERENCES species(id),
    PRIMARY KEY(vets_id, species_id )
);

/*
There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
*/
CREATE TABLE visits(
    id INT GENERATED ALWAYS AS IDENTITY,
    vets_id INT REFERENCES vets(id),
    animals_id INT REFERENCES animals(id),
    visit_date DATE,
    PRIMARY KEY(id, vets_id, animals_id)
);