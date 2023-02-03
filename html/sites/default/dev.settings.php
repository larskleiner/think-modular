<?php

# Cache settings
// Disable the render cache.
$settings['cache']['bins']['render'] = 'cache.backend.null';
// Disable caching for migrations.
$settings['cache']['bins']['discovery_migration'] = 'cache.backend.memory';
// Disable Internal Page Cache.
$settings['cache']['bins']['page'] = 'cache.backend.null';
// Disable Dynamic Page Cache.
$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';

$config['system.performance']['css']['preprocess'] = FALSE;
$config['system.performance']['js']['preprocess'] = FALSE;

$config['system.logging']['error_level'] = 'verbose';
