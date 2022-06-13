<?php
define ('DB_NAME',          'inceptiondb');
define ('DB_USER',          'cmorel-a');
define ('DB_PASSWORD',      'inception42');
define ('DB_HOST',          'mariadb:3306');

define ('DB_CHARSET',       'utf8');
define ('DB_COLLATE',       'utf8_general_ci');

define('AUTH_KEY',          'M{.976UZN5nG0B3$OjQ23-5R@@_2X2V#M-#Oul&K/rC/vyzW^ {l!Yc5_{aM2j&[');
define('SECURE_AUTH_KEY',   'pbBr0=Y^[Asb/EOGRkswVC~ ]U}*,- OR{J_* ,;KmFu10}/HVB/N`>f++m(]SBj');
define('LOGGED_IN_KEY',     '+v04i@W:>r:!6+*D^Vc7)3or:r1Gc)j)by@NP63gyWG9+`|mb`0A4+b9>u6FX!:Q');
define('NONCE_KEY',         'N#NM#qNRfrYaX|iFeL+9Bc_6.eQQ~HLCy>ViOBlN`%[IjXX%X)h_3CNjCWcEs4iu');
define('AUTH_SALT',         '9+W7u[N3+[r|/ S*`&+IF$@lI+z:gelL:dA1N(Ah|sR~Vh1;vz^5Z0b9H*E;nk|7');
define('SECURE_AUTH_SALT',  'uDXK[;@[^9C-e[R-bC.sy*x-]!|m8tZ|dKr|2]<[fG.+k4)A8AaLlG+scoBdm0:g');
define('LOGGED_IN_SALT',    'K,gl$ad0}bHMfSiPzZsZ`Xx/7Jx+XdU62InW?*N0Ez5]&n||aA5{1aw1ub:uP*?-');
define('NONCE_SALT',        't~z`zDt8u.+>h+Zg8CNr797O y4?p;ul$Mw%k{O3)as`4a/_Gt`{x7HBK}xin#WI');

$table_prefix = 'inception42_';

define ('WP_DEBUG', true);
if ( ! defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}
require_once ABSPATH . 'wp-settings.php';