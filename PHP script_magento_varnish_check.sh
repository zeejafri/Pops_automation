function varnish_magn_chk() {
#!/bin/bash


varnish_status=`php bin/magento config:show | grep -a "caching" | cut -d " " -f 3`
access_list=`php bin/magento config:show | grep -a access_list`
backend_host=`php bin/magento config:show | grep -a backend_host`
echo
echo
echo "*********************varnish status check*********************"
echo
if [[ $varnish_status -eq 2 ]]
then echo 'Caching Application is selected as varnish'
else echo 'Magneto built in cache is selected, varnish is not working'

fi

echo
echo "####################################"

echo These are backend host URLs
echo $backend_host
echo
echo "####################################"
echo
echo These are access_list URLs
echo $access_list
echo
echo "###################################"


num=`php bin/magento config:show | grep -a "backend_port" | cut -d " " -f 3`
if [[ $num -eq 8081 ]]
then # if/then branch
         echo 'varnish port is correct'
echo $num
 else # else branch
 echo $num
           echo 'varnish port is not correct it should be 8081'
   fi

   echo
   
   }
