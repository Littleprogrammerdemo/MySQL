CREATE DATABASE summer_olympics;
USE summer_olympics;
CREATE TABLE countries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE sports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE disciplines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(40) NOT NULL UNIQUE,
    sport_id INT NOT NULL,
    FOREIGN KEY (sport_id) REFERENCES sports(id)
);

CREATE TABLE athletes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    age INT NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries(id)
);

CREATE TABLE medals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE disciplines_athletes_medals (
    discipline_id INT NOT NULL,
    athlete_id INT NOT NULL,
    medal_id INT NOT NULL,
    FOREIGN KEY (discipline_id) REFERENCES disciplines(id),
FOREIGN KEY (athlete_id) REFERENCES athletes(id),
FOREIGN KEY (medal_id) REFERENCES medals(id),

 KEY (discipline_id, athlete_id, medal_id),
 
UNIQUE KEY unique_discipline_medal (discipline_id, medal_id)

 );
    
);



INSERT INTO athletes (first_name, last_name, age, country_id)
SELECT 
    UPPER(a.first_name) AS first_name,
    CONCAT(a.last_name, ' comes from ', c.name) AS last_name,
    a.age + a.country_id AS age,
    a.country_id
FROM 
    athletes a
JOIN 
    countries c ON a.country_id = c.id
WHERE 
    c.name LIKE 'A%';

UPDATE disciplines
SET name = REPLACE(name, 'weight', '')
WHERE name LIKE '%weight%';

DELETE FROM athletes
WHERE age > 35;

SELECT c.id, c.name
FROM countries c
LEFT JOIN athletes a ON c.id = a.country_id
WHERE a.id IS NULL
ORDER BY c.name DESC
LIMIT 15;

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name,
    a.age
FROM 
    athletes a
JOIN 
    disciplines_athletes_medals dam ON a.id = dam.athlete_id
GROUP BY 
    a.id, a.first_name, a.last_name, a.age
ORDER BY 
    a.age ASC
LIMIT 2;

SELECT 
    a.id,
    a.first_name,
    a.last_name
FROM 
    athletes a
LEFT JOIN 
    disciplines_athletes_medals dam ON a.id = dam.athlete_id
WHERE 
    dam.medal_id IS NULL
ORDER BY 
    a.id ASC;


SELECT 
    a.id,
    a.first_name,
    a.last_name,
    COUNT(dam.medal_id) AS medals_count,
    s.name AS sport
FROM 
    athletes a
JOIN 
    disciplines_athletes_medals dam ON a.id = dam.athlete_id
JOIN 
    disciplines d ON dam.discipline_id = d.id
JOIN 
    sports s ON d.sport_id = s.id
GROUP BY 
    a.id, a.first_name, a.last_name, s.name
ORDER BY 
    medals_count DESC, 
    a.first_name ASC
LIMIT 10;

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS full_name,
    CASE
        WHEN a.age <= 18 THEN 'Teenager'
        WHEN a.age > 18 AND a.age <= 25 THEN 'Young adult'
        ELSE 'Adult'
    END AS age_group
FROM 
    athletes a
ORDER BY 
    a.age DESC, 
    a.first_name ASC;



DELIMITER //

CREATE FUNCTION udf_total_medals_count_by_country(country_name VARCHAR(40))
RETURNS INT
BEGIN
    DECLARE total_medals INT;

    SELECT COUNT(dam.medal_id) INTO total_medals
    FROM disciplines_athletes_medals dam
    JOIN athletes a ON dam.athlete_id = a.id
    JOIN countries c ON a.country_id = c.id
    WHERE c.name = country_name;

    RETURN total_medals;
END;

//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE udp_first_name_to_upper_case(letter CHAR(1))
BEGIN
    UPDATE athletes
    SET first_name = UPPER(first_name)
    WHERE first_name LIKE CONCAT('%', letter);
END//

DELIMITER ;
CALL udp_first_name_to_upper_case('s');
