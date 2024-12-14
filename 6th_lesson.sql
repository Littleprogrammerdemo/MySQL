USE `soft_uni`;

# 1

SELECT `first_name`, `last_name`
FROM `employees`
WHERE UPPER(LEFT(`first_name`, 2)) = 'SA';

# 2

SELECT `first_name`, `last_name`
FROM `employees`
WHERE REGEXP_LIKE(`last_name`, 'ei');

# 3

SELECT `first_name`
FROM `employees`
WHERE `department_id` IN (3, 10)
  AND YEAR(`hire_date`) BETWEEN '1995' AND '2005'
ORDER BY `employee_id`;

# 4

SELECT `first_name`, `last_name`
FROM `employees`
WHERE NOT REGEXP_LIKE(`job_title`, 'engineer')
ORDER BY `employee_id`;

# 5

SELECT `name`
FROM `towns`
WHERE LENGTH(`name`) IN (5, 6)
ORDER BY `name`;

# 6

SELECT `town_id`, `name`
FROM `towns`
WHERE UPPER(LEFT(`name`, 1)) IN ('M', 'K', 'B', 'E')
ORDER BY `name`;

# 7

SELECT `town_id`, `name`
FROM `towns`
WHERE UPPER(LEFT(`name`, 1)) NOT IN ('R', 'B', 'D')
ORDER BY `name`;

# 8

CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`, `last_name`
FROM `employees`
WHERE YEAR(`hire_date`) > 2000;

SELECT *
FROM `v_employees_hired_after_2000`;

# 9

SELECT `first_name`, `last_name`
FROM `employees`
WHERE LENGTH(`last_name`) = 5;

USE `geography`;

# 10

SELECT `country_name`, `iso_code`
FROM `countries`
WHERE LOWER(`country_name`) LIKE '%a%a%a%'
ORDER BY `iso_code`;

# 11

SELECT `peak_name`, `river_name`, CONCAT(LOWER(`peak_name`), LOWER(SUBSTR(`river_name`, 2))) AS `mix`
FROM `peaks`,
     `rivers`
WHERE LOWER(RIGHT(`peak_name`, 1)) = LOWER(LEFT(`river_name`, 1))
ORDER BY `mix`;

CREATE DATABASE orders;

USE orders;

SELECT user_name,SUBSTRING(email,LOCATE('@', email) +1) AS `email provider`
FROM users
ORDER BY `email provider`, user_name;
DROP DATABASE orders;

SELECT name,DATE_FORMAT(start, '%Y-%m-%d') AS start FROM games
WHERE EXTRACT(YEAR FROM start) IN (2011,2012)
ORDER BY start, name
LIMIT 50;
#--------13--------

SELECT `user_name`, 
	SUBSTRING(`email`, LOCATE('@', `email`) + 1) AS `Email Provider`
FROM `users`
ORDER BY `Email Provider`, `user_name`; 

#--------14--------

SELECT `user_name`, `ip_address`
FROM `users`
WHERE `ip_address` LIKE('___.1%.%.___')
ORDER BY `user_name`;

#--------15--------

SELECT g.name,
	CASE 
		WHEN EXTRACT(HOUR FROM start) >= 0 AND EXTRACT(HOUR FROM g.start) < 12
			THEN 'Morning'
		WHEN EXTRACT(HOUR FROM start) >= 12 AND EXTRACT(HOUR FROM g.start) < 18
			THEN 'Afternoon'
		WHEN EXTRACT(HOUR FROM start) >= 18 AND EXTRACT(HOUR FROM g.start) < 24
			THEN 'Evening'
	END AS 'Part Of The Day',
	CASE
		WHEN g.duration <= 3 THEN 'Extra Short'
        WHEN g.duration BETWEEN 3 AND 6 THEN 'Short'
        WHEN g.duration BETWEEN 6 AND 10 THEN 'Long'
        ELSE 'Extra Long'
        END AS Duration
FROM games g;

#--------16--------

USE `orders`;

SELECT `product_name`, 
	`order_date`, 
	DATE_ADD(`order_date`, INTERVAL 3 DAY) AS `pay_due`, 
	DATE_ADD(`order_date`, INTERVAL 1 MONTH) AS `delivery_due` 
FROM `orders`;