postgres=> CREATE DATABASE universe;
postgres=> \c universe;
universe=> CREATE TABLE galaxy();
CREATE TABLE
universe=> CREATE TABLE planet();
CREATE TABLE
universe=> CREATE TABLE moon();
CREATE TABLE
universe=> CREATE TABLE star();
CREATE TABLE
universe=> ALTER TABLE galaxy ADD COLUMN galaxy_id SERIAL;
ALTER TABLE
universe=> ALTER TABLE planet ADD COLUMN planet_id SERIAL;
ALTER TABLE
universe=> ALTER TABLE moon ADD COLUMN moon_id SERIAL UNIQUE NOT NULL;
ALTER TABLE
universe=> ALTER TABLE star ADD COLUMN star_id SERIAL UNIQUE NOT NULL;
ALTER TABLE
universe=> ALTER TABLE galaxy ADD PRIMARY KEY(galaxy_id);
ALTER TABLE
universe=> ALTER TABLE moon ADD PRIMARY KEY(moon_id);
ALTER TABLE
universe=> ALTER TABLE planet ADD PRIMARY KEY(planet_id);
ALTER TABLE
universe=> ALTER TABLE star ADD PRIMARY KEY(star_id);
ALTER TABLE
universe=> ALTER TABLE galaxy ADD COLUMN name VARCHAR(30) UNIQUE NOT NULL;
ALTER TABLE
universe=> ALTER TABLE moon ADD COLUMN name VARCHAR(30) UNIQUE NOT NULL;
ALTER TABLE
universe=> ALTER TABLE planet ADD COLUMN name VARCHAR(30) UNIQUE NOT NULL;
ALTER TABLE
universe=> ALTER TABLE star ADD COLUMN name VARCHAR(30) UNIQUE NOT NULL;
ALTER TABLE
universe=> ALTER TABLE galaxy ADD COLUMN galaxy_type VARCHAR(30);
ALTER TABLE
universe=> ALTER TABLE galaxy ADD COLUMN constellation VARCHAR(30);
ALTER TABLE
universe=> ALTER TABLE galaxy ADD COLUMN age_in_billions_of_years NUMERIC;
ALTER TABLE
universe=> ALTER TABLE galaxy ADD COLUMN dist_from_earth_kly INT;
ALTER TABLE
universe=> INSERT INTO  galaxy (name, galaxy_type, constellation, age_in_billions_of_years, dist_from_earth_kly) VALUES ('Milky Way', 'barred spiral', 'Sagittarius', 13.61, 26);
INSERT 0 1
universe=> INSERT INTO galaxy (name, galaxy_type, constellation, age_in_billions_of_years, dist_from_earth_kly) VALUES ('Andromeda', 'spiral', 'Andromeda', 10.01, 2537), ('Hoags Object', 'ring', 'Serpens Caput', 12.75, 612800), ('Cigar Galaxy', 'starburst', 'Ursa Major', NULL, 12000);
INSERT 0 3
universe=> INSERT INTO galaxy (name, galaxy_type, constellation, age_in_billions_of_years, dist_from_earth_kly) VALUES ('Large Magellanic Cloud', 'dwarf', 'Dorado/Mensa', 1.101, 158.2);
INSERT 0 1
universe=> SELECT*FROM galaxy;
+-----------+------------------------+---------------+---------------+---------------------+--------------------------+
| galaxy_id |          name          |  galaxy_type  | constellation | dist_from_earth_kly | age_in_billions_of_years |
+-----------+------------------------+---------------+---------------+---------------------+--------------------------+
|         1 | Milky Way              | barred spiral | Sagittarius   |                  26 |                    13.61 |
|         2 | Andromeda              | spiral        | Andromeda     |                2537 |                    10.01 |
|         3 | Hoags Object           | ring          | Serpens Caput |              612800 |                    12.75 |
|         4 | Cigar Galaxy           | starburst     | Ursa Major    |               12000 |                          |
|         5 | Large Magellanic Cloud | dwarf         | Dorado/Mensa  |                 158 |                    1.101 |
+-----------+------------------------+---------------+---------------+---------------------+--------------------------+
(5 rows)

universe=> ALTER TABLE star ADD COLUMN star_color VARCHAR(20);
ALTER TABLE
universe=> ALTER TABLE star ADD COLUMN galaxy_id INT;
ALTER TABLE
universe=> ALTER TABLE star ADD FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id);
ALTER TABLE
universe=> \d star
                                         Table "public.star"
+------------+-----------------------+-----------+----------+---------------------------------------+
|   Column   |         Type          | Collation | Nullable |                Default                |
+------------+-----------------------+-----------+----------+---------------------------------------+
| star_id    | integer               |           | not null | nextval('star_star_id_seq'::regclass) |
| name       | character varying(30) |           | not null |                                       |
| star_color | character varying(20) |           |          |                                       |
| galaxy_id  | integer               |           |          |                                       |
+------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "star_pkey" PRIMARY KEY, btree (star_id)
    "star_name_key" UNIQUE CONSTRAINT, btree (name)
    "star_star_id_key" UNIQUE CONSTRAINT, btree (star_id)
Foreign-key constraints:
    "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> INSERT INTO galaxy (name, galaxy_type, constellation, age_in_billions_of_years, dist_from_earth_kly) VALUES ('Sombrero Galaxy', 'unclear', 'Virgo', 13.25, 311000);
INSERT 0 1
universe=> ALTER TABLE star ADD COLUMN apparent_magnitude INT;
ALTER TABLE
universe=> \d star;
                                             Table "public.star"
+--------------------+-----------------------+-----------+----------+---------------------------------------+
|       Column       |         Type          | Collation | Nullable |                Default                |
+--------------------+-----------------------+-----------+----------+---------------------------------------+
| star_id            | integer               |           | not null | nextval('star_star_id_seq'::regclass) |
| name               | character varying(30) |           | not null |                                       |
| star_color         | character varying(20) |           |          |                                       |
| galaxy_id          | integer               |           |          |                                       |
| apparent_magnitude | integer               |           |          |                                       |
+--------------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "star_pkey" PRIMARY KEY, btree (star_id)
    "star_name_key" UNIQUE CONSTRAINT, btree (name)
    "star_star_id_key" UNIQUE CONSTRAINT, btree (star_id)
Foreign-key constraints:
    "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> INSERT INTO star(name, star_color, galaxy_id, apparent_magnitude) VALUES('Sun', 'yellow', 1, -26.74);
INSERT 0 1
universe=> INSERT INTO star(name, star_color, galaxy_id, apparent_magnitude) VALUES('Betelgeuse', 'red', 1, 1.6), ('Sirius', 'white', 1, -1.46), ('Alpheratz', 'blue-white', 2, 2.06);
INSERT 0 3
universe=> INSERT INTO star(name, star_color, galaxy_id, apparent_magnitude) VALUES('Vega', 'blue-white', 1, 0.03);
INSERT 0 1
universe=> SELECT*FROM star;
+---------+------------+------------+-----------+--------------------+
| star_id |    name    | star_color | galaxy_id | apparent_magnitude |
+---------+------------+------------+-----------+--------------------+
|       1 | Sun        | yellow     |         1 |                -27 |
|       2 | Betelgeuse | red        |         1 |                  2 |
|       3 | Sirius     | white      |         1 |                 -1 |
|       4 | Alpheratz  | blue-white |         2 |                  2 |
|       5 | Vega       | blue-white |         1 |                  0 |
+---------+------------+------------+-----------+--------------------+
(5 rows)

universe=> INSERT INTO star(name, star_color, galaxy_id, apparent_magnitude) VALUES('Mirach', 'red', 2, 2.07);
INSERT 0 1
universe=> ALTER TABLE planet ADD COLUMN star_id INT;
ALTER TABLE
universe=> ALTER TABLE planet ADD FOREIGN KEY(star_id) REFERENCES star(star_id);
ALTER TABLE
universe=> ALTER TABLE planet ADD COLUMN description TEXT;
ALTER TABLE
universe=> ALTER TABLE planet ADD COLUMN has_life BOOLEAN;
ALTER TABLE
universe=> \d planet;
                                          Table "public.planet"
+-------------+-----------------------+-----------+----------+-------------------------------------------+
|   Column    |         Type          | Collation | Nullable |                  Default                  |
+-------------+-----------------------+-----------+----------+-------------------------------------------+
| planet_id   | integer               |           | not null | nextval('planet_planet_id_seq'::regclass) |
| name        | character varying(30) |           | not null |                                           |
| star_id     | integer               |           |          |                                           |
| description | text                  |           |          |                                           |
| has_life    | boolean               |           |          |                                           |
+-------------+-----------------------+-----------+----------+-------------------------------------------+
Indexes:
    "planet_pkey" PRIMARY KEY, btree (planet_id)
    "planet_name_key" UNIQUE CONSTRAINT, btree (name)
Foreign-key constraints:
    "planet_star_id_fkey" FOREIGN KEY (star_id) REFERENCES star(star_id)

universe=> INSERT INTO planet(name, star_id, description, has_life) VALUES('Earth', 1, 'Rocky, terrestrial planet, with 70% of the surface covered in water', TRUE);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id, description, has_life) VALUES('Mercury', 1, 'Closest planet to the sun and smallest in the solar system', FALSE), ('Venus', 1, 'Second planet from the sun and hottest in the solar system', FALSE), ('Mars', 1, 'Dry, rocky, and cold, fourth planet from the sun', FALSE);
INSERT 0 3
universe=> INSERT INTO planet(name, star_id, description, has_life) VALUES('Jupiter', 1, 'Largest planet in the solar system', FALSE), ('Saturn', 1, 'Known for its icy rings', FALSE), ('Neptune', 'One of the ice giants, farthest major planet from Earth', FALSE);
ERROR:  VALUES lists must all be the same length
LINE 1: ...('Saturn', 1, 'Known for its icy rings', FALSE), ('Neptune',...
                                                             ^
universe=>  INSERT INTO planet(name, star_id, description, has_life) VALUES('Jupiter', 1, 'Largest planet in the solar system', FALSE), ('Saturn', 1, 'Known for its icy rings', FALSE), ('Neptune', 1, 'Furthest major planet from the sun, ice giant', FALSE);
INSERT 0 3
universe=> INSERT INTO planet(name, star_id, description, has_life) VALUES('Uranus', 1, 'Ice giant', FALSE), ('Pluto', 1, 'Dwarf planet far from the sun', FALSE);

universe=> INSERT INTO star(name, star_color, galaxy_id, apparent_magnitude) VALUES('Proxima Centauri', 'red', 1, -0.27);
INSERT 0 1
universe=> UPDATE star SET name = 'Alpha Centauri' WHERE star_id = 7;
UPDATE 1
universe=> SELECT*FROM star;
+---------+----------------+------------+-----------+--------------------+
| star_id |      name      | star_color | galaxy_id | apparent_magnitude |
+---------+----------------+------------+-----------+--------------------+
|       1 | Sun            | yellow     |         1 |                -27 |
|       2 | Betelgeuse     | red        |         1 |                  2 |
|       3 | Sirius         | white      |         1 |                 -1 |
|       4 | Alpheratz      | blue-white |         2 |                  2 |
|       5 | Vega           | blue-white |         1 |                  0 |
|       6 | Mirach         | red        |         2 |                  2 |
|       7 | Alpha Centauri | red        |         1 |                  0 |
+---------+----------------+------------+-----------+--------------------+
(7 rows)

universe=> INSERT INTO planet(name, star_id, description, has_life) VALUES('Proxima Centauri b', 7, 'Nearest exoplanet to Earth, orbits in habitable zone', FALSE);
INSERT 0 1
universe=> INSERT INTO star(name, star_color, galaxy_id, apparent_magnitude) VALUES('51 Pegasi', 'yellow', 1, 5.49);
INSERT 0 1
universe=> INSERT INTO planet(name, star_id, description, has_life) VALUES('51 Pegasi b', 8, 'First exoplanet discovered', FALSE);
INSERT 0 1
universe=> SELECT*FROM planet;
+-----------+--------------------+---------+---------------------------------------------------------------------+----------+
| planet_id |        name        | star_id |                             description                             | has_life |
+-----------+--------------------+---------+---------------------------------------------------------------------+----------+
|         1 | Earth              |       1 | Rocky, terrestrial planet, with 70% of the surface covered in water | t        |
|         2 | Mercury            |       1 | Closest planet to the sun and smallest in the solar system          | f        |
|         3 | Venus              |       1 | Second planet from the sun and hottest in the solar system          | f        |
|         4 | Mars               |       1 | Dry, rocky, and cold, fourth planet from the sun                    | f        |
|         5 | Jupiter            |       1 | Largest planet in the solar system                                  | f        |
|         6 | Saturn             |       1 | Known for its icy rings                                             | f        |
|         7 | Neptune            |       1 | Furthest major planet from the sun, ice giant                       | f        |
|         8 | Uranus             |       1 | Ice giant                                                           | f        |
|         9 | Pluto              |       1 | Dwarf planet far from the sun                                       | f        |
|        10 | Proxima Centauri b |       7 | Nearest exoplanet to Earth, orbits in habitable zone                | f        |
|        11 | 51 Pegasi b        |       8 | First exoplanet discovered                                          | f        |
+-----------+--------------------+---------+---------------------------------------------------------------------+----------+
(11 rows)

universe=> INSERT INTO planet(name, star_id, description, has_life) VALUES('Proxima Centauri d', 7, 'Among lighest plane
ts detected by radial velocity', FALSE);
INSERT 0 1
universe=> \d moon;
                                       Table "public.moon"
+---------+-----------------------+-----------+----------+---------------------------------------+
| Column  |         Type          | Collation | Nullable |                Default                |
+---------+-----------------------+-----------+----------+---------------------------------------+
| moon_id | integer               |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name    | character varying(30) |           | not null |                                       |
+---------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_moon_id_key" UNIQUE CONSTRAINT, btree (moon_id)
    "moon_name_key" UNIQUE CONSTRAINT, btree (name)
universe=> ALTER TABLE moon ADD COLUMN has_ice BOOLEAN;
ALTER TABLE
universe=> ALTER TABLE moon ADD COLUMN name_origin TEXT;
ALTER TABLE
universe=> ALTER TABLE moon ADD COLUMN planet_id INT;
ALTER TABLE
universe=> ALTER TABLE moon ADD FOREIGN KEY(planet_id) REFERENCES planet(planet_id);
ALTER TABLE
universe=> \d moon;
                                         Table "public.moon"
+-------------+-----------------------+-----------+----------+---------------------------------------+
|   Column    |         Type          | Collation | Nullable |                Default                |
+-------------+-----------------------+-----------+----------+---------------------------------------+
| moon_id     | integer               |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name        | character varying(30) |           | not null |                                       |
| has_ice     | boolean               |           |          |                                       |
| name_origin | text                  |           |          |                                       |
| planet_id   | integer               |           |          |                                       |
+-------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_moon_id_key" UNIQUE CONSTRAINT, btree (moon_id)
    "moon_name_key" UNIQUE CONSTRAINT, btree (name)
Foreign-key constraints:
    "moon_planet_id_fkey" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> INSERT INTO moon(name, has_ice, name_origin, planet_id) VALUES('Moon', FALSE, NULL, 1);
INSERT 0 1
universe=> INSERT INTO moon(name, has_ice, name_origin, planet_id) VALUES('Phobos', FALSE, 'Fear', 4), ('Deimos', FALSE,'Dread', 4), ('Europa', TRUE, 'Queen of Crete, lover of Zeus', 5);
INSERT 0 3
universe=> INSERT INTO moon(name, has_ice, name_origin, planet_id) VALUES('Ganymede', TRUE, 'Cupbearer for Zeus', 5), ('Callisto', TRUE, 'nymph lover of Zeus', 5);
INSERT 0 2
universe=> INSERT INTO moon(name, has_ice, name_origin, planet_id) VALUES('Mimas', TRUE, 'Giant killed by Mars in battle between gods and Titans', 6), ('Titan', TRUE, 'Titans of Greek mythology', 6);
INSERT 0 2
universe=> INSERT INTO moon(name, has_ice, name_origin, planet_id) VALUES('Enceladus', TRUE, 'Giant from Greek mythology', 6), ('Triton', TRUE, 'Roman god of the sea', 7);
INSERT 0 2
universe=> INSERT INTO moon(name, has_ice, name_origin, planet_id) VALUES('Umbriel', TRUE, 'Character in the poem The Rape of the Lock', 8), ('Charon', TRUE, 'Boatman that ferries the dead in Greek mythology', 9);
INSERT 0 2
universe=> INSERT INTO moon(name, has_ice, name_origin, planet_id) VALUES('Io', FALSE, 'nymph lover to Zeus in Greek mythology', 5), ('Metis', FALSE, 'first wife of Zeus in Greek mythology', 5), ('Adrastea', FALSE, 'goddess of inevitable fate', 5), ('Amalthea', FALSE, 'name of the mountain goat that nursed the infant Zeus in Greek mythology', 5);
INSERT 0 4
universe=> INSERT INTO moon(name, has_ice, name_origin, planet_id) VALUES('Thebe', FALSE, 'daughter of Zeus in Greek mythology', 5), ('Tethys', FALSE, 'Titan of Greek mythology', 6), ('Dione', FALSE, 'mother of Aphrodite in Greek mythology', 6), ('Rhea', FALSE, 'Greek earth goddess', 6);
INSERT 0 4
universe=> CREATE TABLE comets();
CREATE TABLE
universe=> ALTER TABLE comets ADD COLUMN comet_id SERIAL NOT NULL UNIQUE;
ALTER TABLE
universe=> ALTER TABLE comets ADD COLUMN name VARCHAR(30) NOT NULL;
ALTER TABLE
universe=> ALTER TABLE comets ADD COLUMN orbital_period_in_years INT;
ALTER TABLE
universe=> \d comets;
                                                Table "public.comets"
+-------------------------+-----------------------+-----------+----------+------------------------------------------+
|         Column          |         Type          | Collation | Nullable |                 Default                  |
+-------------------------+-----------------------+-----------+----------+------------------------------------------+
| comet_id                | integer               |           | not null | nextval('comets_comet_id_seq'::regclass) |
| name                    | character varying(30) |           | not null |                                          |
| orbital_period_in_years | integer               |           |          |                                          |
+-------------------------+-----------------------+-----------+----------+------------------------------------------+
Indexes:
    "comets_comet_id_key" UNIQUE CONSTRAINT, btree (comet_id)
universe=> ALTER TABLE comets ADD PRIMARY KEY(comet_id);
ALTER TABLE
universe=> ALTER TABLE comets RENAME COLUMN comet_id TO comets_id;
ALTER TABLE
universe=> INSERT INTO comets(name, orbital_period_in_years) VALUES('Swift-Tuttle', 133), ('Halleys Comet', 76), ('Hale-
Bopp', 2534);
INSERT 0 3


