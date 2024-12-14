USE minions;

# 1

CREATE TABLE `minions`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `age`  INT          NOT NULL
);

CREATE TABLE `towns`
(
    `town_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name`    VARCHAR(255) NOT NULL
);


## MIDDLE (NOT FOR JUDGE)
alter table towns
    change town_id id int auto_increment;

# 2

ALTER TABLE minions
    ADD COLUMN town_id INT NOT NULL,
    ADD FOREIGN KEY (town_id) REFERENCES towns (id);

# 3

INSERT INTO towns(`id`, `name`)
VALUES (1, 'Sofia'),
       (2, 'Plovdiv'),
       (3, 'Varna');

INSERT INTO minions(`id`, `name`, `age`, `town_id`)
VALUES (1, 'Kevin', '22', '1'),
       (2, 'Bob', '15', '3'),
       (3, 'Steward', NULL, '2');

# 4

TRUNCATE TABLE `minions`;

# 5

DROP TABLE `minions`;
DROP TABLE `towns`;
CREATE TABLE `towns`
(
    `id`   INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `addresses`
(
    `id`           INT AUTO_INCREMENT PRIMARY KEY,
    `address_text` TEXT NOT NULL,
    `town_id`      INT  NOT NULL
);

CREATE TABLE `departments`
(
    `id`   INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `employees`
(
    `id`            INT AUTO_INCREMENT PRIMARY KEY,
    `first_name`    VARCHAR(255) NOT NULL,
    `middle_name`   VARCHAR(255) NOT NULL,
    `last_name`     VARCHAR(255) NOT NULL,
    `job_title`     VARCHAR(255) NOT NULL,
    `department_id` INT          NOT NULL,
    `hire_date`     DATETIME     NOT NULL,
    `salary`        DOUBLE,
    `address_id`    INT
);

# 13

INSERT INTO `towns`(`name`)
VALUES ('Sofia'),
       ('Plovdiv'),
       ('Varna'),
       ('Burgas');

INSERT INTO `departments` (`name`)
VALUES ('Engineering'),
       ('Sales'),
       ('Marketing'),
       ('Software Development'),
       ('Quality Assurance');

INSERT INTO `employees` (`first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`, `salary`)
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
       ('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
       ('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
       ('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
       ('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

# 14

SELECT *
FROM `towns`;

SELECT *
FROM `departments`;

SELECT *
FROM `employees`;

# 15

SELECT *
FROM `towns`
ORDER BY `name`;

SELECT *
FROM `departments`
ORDER BY `name`;

SELECT *
FROM `employees`
ORDER BY `salary` DESC;

# 16

SELECT `name`
FROM `towns`
ORDER BY `name`;

SELECT `name`
FROM `departments`
ORDER BY `name`;

SELECT `first_name`, `last_name`, `job_title`, `salary`
FROM `employees`
ORDER BY `salary` DESC;

# 17

UPDATE `employees`
SET `salary` = `salary` * 1.10;

SELECT `salary`
FROM `employees`;
# 6

CREATE DATABASE `exercises`;

USE exercises;

CREATE TABLE `people`
(
    `id`        INT AUTO_INCREMENT PRIMARY KEY,
    `name`      VARCHAR(200)    NOT NULL,
    `picture`   BLOB,
    `height`    DOUBLE(10, 2),
    `weight`    DOUBLE(10, 2),
    `gender`    ENUM ('m', 'f') NOT NULL,
    `birthdate` DATE            NOT NULL,
    `biography` TEXT
);

INSERT INTO people(`name`, `gender`, `birthdate`)
VALUES ('Boris', 'm', DATE(NOW())),
       ('Aleksander', 'm', DATE(NOW())),
       ('Peter', 'm', DATE(NOW())),
       ('Ivana', 'f', DATE(NOW())),
       ('Suzan', 'f', DATE(NOW()));

# MIDDLE (NOT FOR JUDGE)
ALTER TABLE people
    MODIFY COLUMN gender ENUM ('m', 'f');

# 7

CREATE TABLE `users`
(
    `id`              INT AUTO_INCREMENT PRIMARY KEY,
    `username`        VARCHAR(30) NOT NULL,
    `password`        VARCHAR(26) NOT NULL,
    `profile_picture` BLOB,
    `last_login_time` TIME,
    `is_deleted`      BOOLEAN
);

INSERT INTO `users`(`username`, `password`)
VALUES ('pesho123', 'password123'),
       ('ivan123', 'password123'),
       ('maria123', 'password123'),
       ('peter123', 'password123'),
       ('viktor123', 'password123');

# 8

ALTER TABLE users
    DROP PRIMARY KEY,
    ADD PRIMARY KEY `pk_users` (`id`, `username`);

# 9

ALTER TABLE users
    MODIFY COLUMN `last_login_time` DATETIME DEFAULT NOW();

# MIDDLE (NOT FOR JUDGE)
INSERT INTO `users` (`username`, `password`) VALUE ('test1', 'password');

# 10

ALTER TABLE `users`
    DROP PRIMARY KEY,
    ADD CONSTRAINT pk_users
    PRIMARY KEY `users` (`id`),
    MODIFY COLUMN `username` VARCHAR(30) UNIQUE;
# 11

CREATE TABLE `directors`
(
    `id`            INT AUTO_INCREMENT PRIMARY KEY,
    `director_name` VARCHAR(200) NOT NULL,
    `notes`         TEXT
);

INSERT INTO `directors`(`director_name`, `notes`)
VALUES ('Ivan', 'I\'m film director.'),
       ('John', 'I\'m film director.'),
       ('Lily', 'I\'m film director.'),
       ('Sarah', 'I\'m film director.'),
       ('James', 'I\'m film director.');

CREATE TABLE `genres`
(
    `id`         INT AUTO_INCREMENT PRIMARY KEY,
    `genre_name` VARCHAR(200) NOT NULL,
    `notes`      TEXT
);


INSERT INTO `genres`(`genre_name`, `notes`)
VALUES ('Action', 'This is just a movie genre.'),
       ('Drama', 'This is just a movie genre.'),
       ('Western', 'This is just a movie genre.'),
       ('Horror', 'This is just a movie genre.'),
       ('Comedy', 'This is just a movie genre.');

CREATE TABLE `categories`
(
    `id`            INT AUTO_INCREMENT PRIMARY KEY,
    `category_name` VARCHAR(200) NOT NULL,
    `notes`         TEXT
);

INSERT INTO `categories`(`category_name`, `notes`)
VALUES ('Kids', 'Film category.'),
       ('Adults', 'Film category.'),
       ('Teen', 'Film category.'),
       ('Series', 'Film category.'),
       ('Long movies', 'Film category.');

CREATE TABLE `movies`
(
    `id`             INT AUTO_INCREMENT PRIMARY KEY,
    `title`          VARCHAR(200) NOT NULL,
    `director_id`    INT         NOT NULL,
    `copyright_year` VARCHAR(4)  NOT NULL,
    `length`         DOUBLE,
    `genre_id`       INT         NOT NULL,
    `category_id`    INT         NOT NULL,
    `rating`         INT,
    `notes`          TEXT
);

INSERT INTO `movies`(`title`, `director_id`, `copyright_year`, `length`, `genre_id`, `category_id`, `rating`, `notes`)
VALUES ('Morbius', 1, '2022', 2.15, 1, 1, 2, 'A great movie.'),
       ('Eternals', 2, '2021', 2.10, 2, 2, 3, 'A great movie.'),
       ('Fantastic Beasts 3', 3, '2022', 2.42, 3, 3, 8, 'A great movie.'),
       ('Uncharted ', 4, '2022', 1.57, 4, 4, 8, 'A great movie.'),
       ('The Lord of the Rings 1', 5, '2001', 3.36, 5, 5, 10, 'A great movie.');
       
       CREATE DATABASE `car_rental`;

USE `car_rental`;

CREATE TABLE `categories`
(
    `id`           INT PRIMARY KEY AUTO_INCREMENT,
    `category`     VARCHAR(100) NOT NULL,
    `daily_rate`   INT,
    `weekly_rate`  INT,
    `monthly_rate` INT,
    `weekend_rate` INT
);

INSERT INTO `categories` (`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES ('Minicompact ', 4, 5, 3, 6),
       ('Mid-size', 5, 6, 5, 9),
       ('Full-size luxury', 10, 10, 10, 10);

CREATE TABLE `cars`
(
    `id`            INT PRIMARY KEY AUTO_INCREMENT,
    `plate_number`  VARCHAR(7),
    `make`          VARCHAR(50) NOT NULL,
    `model`         VARCHAR(50),
    `car_year`      INT(4),
    `category_id`   INT         NOT NULL,
    `doors`         INT(1),
    `picture`       BLOB,
    `car_condition` VARCHAR(20),
    `available`     BOOLEAN     NOT NULL
);

INSERT INTO `cars` (`plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`, `car_condition`, `available`)
VALUES ('22TY921', 'Gillig', 'Fs65', 1998, 1, 4, 'Bad', TRUE),
       ('SC39683', 'Hyundai', '4Runner Limited', 1999, 2, 4, 'Average', TRUE),
       ('6UMN164', 'Nissan', 'Altima S', 2012, 3, 4, 'Excellent!', TRUE);

CREATE TABLE `employees`
(
    `id`         INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name`  VARCHAR(50) NOT NULL,
    `title`      VARCHAR(50) NOT NULL,
    `notes`      TEXT
);

INSERT INTO `employees` (`first_name`, `last_name`, `title`)
VALUES ('Shawn', 'Reynolds', 'CEO'),
       ('Sean', 'Reynolds', 'CTO'),
       ('Stephen', 'Shaun', 'Administrator');

CREATE TABLE `customers`
(
    `id`                    INT PRIMARY KEY AUTO_INCREMENT,
    `driver_licence_number` VARCHAR(20)  NOT NULL,
    `full_name`             VARCHAR(100) NOT NULL,
    `address`               VARCHAR(100),
    `city`                  VARCHAR(55),
    `zip_code`              INT(4),
    `notes`                 TEXT
);

INSERT INTO `customers` (`driver_licence_number`, `full_name`, `address`, `city`, `zip_code`, `notes`)
VALUES ('JAMIE901059VI9LA', 'Jamie Garland', 'street Nezabravka 10', 'Cambridge', 2114, NULL),
       ('EMBUR703254NI9AT', 'Florence Embury', 'street Nezabravka 10', 'Frankfurt', 60308, NULL),
       ('OWEN9802273GA9WO', 'Gary Owen', 'street Nezabravka 10', 'London', 5208, NULL);

CREATE TABLE `rental_orders`
(
    `id`                INT PRIMARY KEY AUTO_INCREMENT,
    `employee_id`       INT      NOT NULL,
    `customer_id`       INT      NOT NULL,
    `car_id`            INT      NOT NULL,
    `car_condition`     ENUM ('Bad', 'Average', 'Excellent!'),
    `tank_level`        ENUM ('Empty', 'Half', 'Full'),
    `kilometrage_start` INT      NOT NULL,
    `kilometrage_end`   INT,
    `total_kilometrage` INT                                                     DEFAULT 0,
    `start_date`        DATETIME NOT NULL,
    `end_date`          DATE,
    `total_days`        INT                                                     DEFAULT 0,
    `rate_applied`      BOOLEAN,
    `tax_rate`          DECIMAL  NOT NULL,
    `order_status`      ENUM ('Processing', 'Created', 'Released', 'Fulfilled'),
    `notes`             TEXT
);

INSERT INTO `rental_orders`(`employee_id`, `customer_id`, `car_id`, `car_condition`, `tank_level`, `kilometrage_start`,
                            `start_date`, `tax_rate`, `order_status`)
VALUES (1, 1, 3, 'Excellent!', 'Full', 217, DATE('2012-12-12'), 3.12, 'Released'),
       (2, 2, 2, 'Average', 'Half', 987, DATE('1999-10-02'), 2.07, 'Created'),
       (3, 3, 1, 'Bad', 'Half', 1723, DATE('1998-07-24'), 4.11, 'Processing');