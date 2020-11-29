<?php
$f = fopen( 'php://stdin', 'r' );

$sum_all = 0;
$sum_odd = 0;
while( $line = fgets( $f ) ) {
  $num = (int)$line;
  $sum_all += $num;
  $sum_odd += $num % 2 === 1 ? $num : 0;
}
fclose( $f );

echo $sum_all . PHP_EOL;
echo $sum_odd . PHP_EOL;
?>
