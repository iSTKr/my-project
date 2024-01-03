<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

require 'Predis/Autoloader.php';

Predis\Autoloader::register();

if (isset($_GET['cmd']) === true) {
  header('Content-Type: application/json');
  $host = 'redis-leader';
  if (getenv('GET_HOSTS_FROM') == 'env') {
    $host = getenv('REDIS_SLAVE_SERVICE_HOST');
  }
  $client = new Predis\Client([
    'scheme' => 'tcp',
    'host'   => $host,
    'port'   => 6379,
  ]);
  $value = $client->get($_GET['key']);
  print('{"data": "' . $value . '"}');

} else {
  phpinfo();
} ?>
