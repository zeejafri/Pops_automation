#!/bin/bash


varnish_status=`php bin/magento config:show | grep -a "system/full_page_cache/caching_application" | cut -d " " -f 3`
access_list=`php bin/magento config:show | grep -a "system/full_page_cache/varnish/access_list"`
backend_host=`php bin/magento config:show | grep -a "system/full_page_cache/varnish/backend_host"`
echo
echo
tput setaf 2; echo "*********************varnish status check*********************"
echo
if [[ $varnish_status -eq 2 ]]
then  echo "Caching Application is selected as varnish"
else  echo "Magneto built in cache is selected, varnish is not working. To enable varnish go to the Magento admin > stores > configuration 
> advanced > Full page caching"

fi

echo
echo "####################################"

echo These are backend host URLs 
echo $backend_host
echo
echo "Backend Hosts: Varnish has a concept of “backend” or “origin” servers. A backend server is the server providing the content Varnish will accelerate." 
echo "More reading: https://varnish-cache.org/docs/trunk/users-guide/vcl-backends.html" 
echo
echo "####################################"
echo
echo These are access_list URLs
echo $access_list
echo
echo Access_list is the  IP or Host allowed to purge the Varnish Cache read more here: https://varnish-cache.org/docs/3.0/tutorial/purging.html
echo
echo "###################################"


num=`php bin/magento config:show | grep -a "system/full_page_cache/varnish/backend_port" | cut -d " " -f 3`
if [[ $num -eq 8081 ]]
then # if/then branch
         echo 'backend port is correct'
echo 'selected bcakend port:' 
echo $num
 else # else branch
 echo 'selected backend port:' 
 echo $num
           echo 'varnish port is not correct it should be 8081 - Backend Port is the port of the Apache server, as varnish uses the concept of backend servers whose content it accelerates'
   fi

   echo
