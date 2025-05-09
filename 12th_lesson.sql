USE `soft_uni`;

# 1

SELECT `employee_id`, `job_title`, `addresses`.`address_id`, `address_text`
FROM `employees`
         JOIN `addresses`
              ON `employees`.`address_id` = `addresses`.`address_id`
ORDER BY `address_id`
LIMIT 5;

# 2

SELECT `e`.`first_name`, `e`.`last_name`, `t`.`name` AS 'town', `a`.`address_text`
FROM `employees` as `e`
         JOIN `addresses` AS `a` ON `e`.`address_id` = `a`.`address_id`
         JOIN `towns` AS `t` ON `a`.`town_id` = `t`.`town_id`
ORDER BY `first_name`, `last_name`
LIMIT 5;

# 3

SELECT `e`.`employee_id`, `e`.`first_name`, `e`.`last_name`, `d`.`name` AS 'department_name'
FROM `employees` AS `e`
         INNER JOIN `departments` AS `d`
                    ON `e`.`department_id` = `d`.`department_id`
WHERE `d`.`name` = 'Sales'
ORDER BY `e`.`employee_id` DESC;

# 4

SELECT `e`.`employee_id`, `e`.`first_name`, `e`.`salary`, `d`.`name` AS 'department_name'
FROM `employees` AS `e`
         INNER JOIN `departments` AS `d`
                    ON `e`.`department_id` = `d`.`department_id`
WHERE `salary` > 15000
ORDER BY `d`.`department_id` DESC
LIMIT 5;

# 5

SELECT `employees`.`employee_id`, `first_name`
FROM `employees`
         LEFT JOIN `employees_projects` ON `employees`.`employee_id` = `employees_projects`.`employee_id`
WHERE `project_id` IS NULL
ORDER BY `employee_id` DESC
LIMIT 3;

# 6

SELECT `first_name`, `last_name`, `hire_date`, `name` AS 'dept_name'
FROM `employees`
         INNER JOIN `departments`
                    ON `employees`.`department_id` = `departments`.`department_id`
WHERE `hire_date` > DATE('1999-01-01')
  AND `name` IN ('Sales', 'Finance')
ORDER BY `hire_date`;

# 7

SELECT `employees`.`employee_id`, `first_name`, `name` AS 'project_name'
FROM `employees`
         INNER JOIN `employees_projects` ON `employees`.`employee_id` = `employees_projects`.`employee_id`
         INNER JOIN `projects` ON `employees_projects`.`project_id` = `projects`.`project_id`
WHERE DATE(`start_date`) > '2002-08-13'
  AND `end_date` IS NULL
ORDER BY `first_name`, `name`
LIMIT 5;

# 8

SELECT `e`.`employee_id`,
       `first_name`,
       (IF(YEAR(`p`.`start_date`) >= '2005', NULL, `name`)) AS 'project_name'
FROM `employees` `e`
         INNER JOIN `employees_projects` `ep` on `e`.`employee_id` = `ep`.`employee_id`
         INNER JOIN `projects` `p` ON `ep`.`project_id` = `p`.`project_id`
WHERE `ep`.`employee_id` = 24
ORDER BY `project_name`;

# 9

SELECT `e1`.`employee_id`,
       `e1`.`first_name`,
       `e1`.`manager_id`,
       (SELECT `em`.`first_name`
        FROM `employees` `em`
        WHERE `em`.`employee_id` = `e1`.`manager_id`) AS 'manager_name'
FROM `employees` as `e1`
WHERE `e1`.`manager_id` IN (3, 7)
ORDER BY `first_name`;

# 10

SELECT `employee_id`,
       CONCAT_WS(' ', `first_name`, `last_name`)     AS 'employee_name',
       (SELECT CONCAT_WS(' ', `first_name`, `last_name`)
        FROM `employees` `em`
        WHERE `e`.`manager_id` = `em`.`employee_id`) AS 'manager_name',
       `d`.`name`                                    AS 'department_name'
FROM `employees` `e`
         JOIN `departments` `d` USING (`department_id`)
WHERE `e`.`manager_id` IS NOT NULL
ORDER BY `e`.`employee_id`
LIMIT 5;

# 11

SELECT AVG(`salary`) AS 'min_average_salary'
FROM `employees` `e`
GROUP BY `department_id`
ORDER BY `min_average_salary`
LIMIT 1;
USE `geography`;

# 12

SELECT `mc`.`country_code`, `m`.`mountain_range`, `p`.`peak_name`, `p`.`elevation`
FROM `mountains_countries` `mc`
         INNER JOIN `mountains` `m` ON `mc`.`mountain_id` = `m`.`id`
         INNER JOIN `peaks` `p` USING (`mountain_id`)
WHERE `mc`.`country_code` = 'BG'
  AND `p`.`elevation` > 2835
ORDER BY `p`.`elevation` DESC;


# 13

SELECT `country_code`, COUNT(*) AS 'mountain_range'
FROM `mountains_countries`
WHERE `country_code` IN ('BG', 'RU', 'US')
GROUP BY `country_code`
ORDER BY `mountain_range` DESC;

# 14

SELECT `c`.`country_name`, `river_name`
FROM `countries` `c`
         LEFT JOIN `countries_rivers` `cr` USING (`country_code`)
         LEFT JOIN `rivers` `r` ON `cr`.`river_id` = `r`.`id`
WHERE `continent_code` = 'AF'
ORDER BY `country_name`
LIMIT 5;

# 15

SELECT `continent_code`, `currency_code`, COUNT(`currency_code`) AS `currency_usage`
FROM `countries` `c1`
GROUP BY `continent_code`, `currency_code`
HAVING `currency_usage` = (SELECT COUNT(`currency_code`) AS `count`
                           FROM `countries` `c2`
                           WHERE `c2`.`continent_code` = `c1`.`continent_code`
                           GROUP BY `c2`.`currency_code`
                           ORDER BY `count` DESC
                           LIMIT 1)
   AND `currency_usage` > 1
ORDER BY `continent_code`, `currency_code`;

# 16

SELECT COUNT(`country_code`) AS 'country_count'
FROM `countries`
         LEFT JOIN `mountains_countries` USING (`country_code`)
WHERE `mountain_id` IS NULL;

# 17

SELECT `country_name`,

       (SELECT MAX(`p`.`elevation`)
        FROM `mountains_countries`
                 LEFT JOIN `peaks` AS `p` USING (`mountain_id`)
        WHERE `country_code` = `c`.`country_code`) AS `highest_peak_elevation`,

       (SELECT MAX(`r`.`length`)
        FROM `countries_rivers` AS `cr`
                 LEFT JOIN `rivers` AS `r`
                           ON `cr`.`river_id` = `r`.`id`
        WHERE `country_code` = `c`.`country_code`) AS `longest_river_length`

FROM `countries` AS `c`
ORDER BY `highest_peak_elevation` DESC, `longest_river_length` DESC, `country_name`
LIMIT 5;