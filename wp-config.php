<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'lormanportdb' );

/** Database username */
define( 'DB_USER', 'root' );

/** Database password */
define( 'DB_PASSWORD', '' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'Wdi6qqihLgI/6i=DP*b3y{K{Mu?tbleppn6u91g4&d-7!k`L5Eh/oV[)7IDG(`jk' );
define( 'SECURE_AUTH_KEY',  '_,nh8htcGV CZ( x*RT8aV:45<_rw-jobr|*|1-_]aH2yacEp73Tu5?;D?RqYN%G' );
define( 'LOGGED_IN_KEY',    'sm~4?RiI9F=5ZB`?9U?bO>xBu0R~I(x4E&&sfH0Rz~D4lBJI%sp5|FZGnhqS]uZc' );
define( 'NONCE_KEY',        'k^eC7!T3Hd#LrdM/mysSi?8[^|*0i(F12OnY)3:]XdC!>u#OTq;nw@(Cb/a(2[cv' );
define( 'AUTH_SALT',        ',K=Ui>0w7/ttJ,<8l,B@e/Bvcr7g%Mxjk){n%p;@19vjKZ37Fdvq&p=F!)k(NEEt' );
define( 'SECURE_AUTH_SALT', 't{2_yg&`G~CpsSm{(lgvkd=>V@J<3<iy7@s#Ff$6t6yK>[2R.$x.6g)o`Wty|&at' );
define( 'LOGGED_IN_SALT',   'jeIy!WZG^8QuHvBLoeW_4;?v)*dUQ+v|1m3n3~$>~M=xA*ONuCwY5zV-@!iJZ`m}' );
define( 'NONCE_SALT',       'dHsAUCrcV16~f(b#q.#*xfyv+t4m[9S8@J[h36W|7%TrSwnRt&Jj>3m)(P#:)6,l' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
