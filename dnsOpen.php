<?php

//Run the bash script

exec('bash /home/metallicstream/bin/dnslo.sh', $output);


echo "All even numbers within 1-20 are:<br />";


//Print the ourput using loop

foreach($output as $value)

{


        echo $value."  ";

}

?>

Output:

