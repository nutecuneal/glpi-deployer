/**
 * Create a new user.
 */
CREATE USER IF NOT EXISTS `$USERNAME`@`$HOST` IDENTIFIED BY '$PASSOWRD';

/**
 * Set "roles". Readonly
 */
GRANT
    SELECT
ON $DB_NAME.* TO `$USERNAME`@`$HOST` IDENTIFIED BY '$PASSOWRD';