GRANT
    SHOW DATABASES,
    ALTER,
    CREATE,
    CREATE VIEW,
    INSERT,
    DELETE,
    UPDATE,
    INDEX,
    SELECT,
    REFERENCES,
    SHOW VIEW,
    TRIGGER,
    DROP
ON *.* TO 'test'@'%' IDENTIFIED BY 'test';

GRANT
    CREATE,
    CREATE ROUTINE,
    CREATE TEMPORARY TABLES,
    EVENT,
    LOCK TABLES
ON db_glpi.* TO 'test'@'%' IDENTIFIED BY 'test';