-- Create the test database if it doesn't exist
CREATE DATABASE IF NOT EXISTS hbnb_test_db;

-- Create the test user if it doesn't exist
CREATE USER IF NOT EXISTS 'hbnb_test'@'localhost' IDENTIFIED BY 'hbnb_test_pwd';

-- Grant all privileges on the test database to the user
GRANT ALL PRIVILEGES ON hbnb_test_db.* TO 'hbnb_test'@'localhost';

-- Grant SELECT privilege on performance_schema to the user
GRANT SELECT ON performance_schema.* TO 'hbnb_test'@'localhost';

-- Apply the privileges
FLUSH PRIVILEGES;

-- Output statements to confirm actions taken
SELECT 
    'Database hbnb_test_db has been created (not present before)' AS result 
    WHERE NOT EXISTS (SELECT SCHEMA_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME = 'hbnb_test_db');

SELECT 
    'User hbnb_test has been created (not present before)' AS result 
    WHERE NOT EXISTS (SELECT USER FROM mysql.user WHERE USER = 'hbnb_test' AND Host = 'localhost');

-- Verify the grants for the user
SHOW GRANTS FOR 'hbnb_test'@'localhost';

