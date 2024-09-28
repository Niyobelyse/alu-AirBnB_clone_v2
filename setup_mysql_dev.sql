-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS hbnb_dev_db;

-- Check if the database was created
SELECT 
    IF(EXISTS(SELECT SCHEMA_NAME FROM information_schema.SCHEMATA WHERE SCHEMA_NAME = 'hbnb_dev_db'), 
    'Database hbnb_dev_db has been created (present before)', 
    'Database hbnb_dev_db has been created (not present before)') AS result;

-- Create the user if it doesn't exist
CREATE USER IF NOT EXISTS 'hbnb_dev'@'localhost' IDENTIFIED BY 'hbnb_dev_pwd';

-- Check if the user was created
SELECT 
    IF(EXISTS(SELECT USER FROM mysql.user WHERE USER = 'hbnb_dev' AND Host = 'localhost'), 
    'User hbnb_dev has been created (present before)', 
    'User hbnb_dev has been created (not present before)') AS result;

-- Grant all privileges on the database to the user
GRANT ALL PRIVILEGES ON hbnb_dev_db.* TO 'hbnb_dev'@'localhost';

-- Grant SELECT privilege on performance_schema to the user
GRANT SELECT ON performance_schema.* TO 'hbnb_dev'@'localhost';

-- Apply the privileges
FLUSH PRIVILEGES;

-- Check user permissions
SHOW GRANTS FOR 'hbnb_dev'@'localhost';

-- Verify SELECT privilege on performance_schema
SELECT 
    IF(EXISTS(SELECT * FROM information_schema.TABLE_PRIVILEGES WHERE GRANTEE = "'hbnb_dev'@'localhost'" AND TABLE_SCHEMA = 'performance_schema' AND PRIVILEGE_TYPE = 'SELECT'), 
    'User hbnb_dev has SELECT privilege on performance_schema', 
    'User hbnb_dev doesn’t have SELECT privilege on performance_schema') AS result;

-- Check permissions on a fake database
SELECT 
    IF(EXISTS(SELECT * FROM information_schema.TABLE_PRIVILEGES WHERE GRANTEE = "'hbnb_dev'@'localhost'" AND TABLE_SCHEMA = 'hbnb_dev_db_fake'), 
    'User hbnb_dev has permissions on hbnb_dev_db_fake', 
    'User hbnb_dev doesn’t have permissions on hbnb_dev_db_fake') AS result;

