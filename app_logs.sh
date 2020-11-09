!#/bin/bash

echo Load average:
uptime

echo *************************************************************
echo "Traffic logs for last 2 hours"
for A in $(ls -la | awk '{print $NF}'); do echo $A && cat $A/conf/server.nginx && apm traffic -s$A -l2h; done

echo *************************************************************
echo Top accessing IPs:
for A in $(ls -la | awk '{print $NF}'); do echo $A && cat $A/conf/server.nginx && awk '{print $1,$7}' $A/logs/apache_*.access.log | cut -d? -f1 | sort | uniq -c |sort -nr | head -n 50 | awk -F";" '{print $1}' ; done

echo *************************************************************
echo Process consuming most CPU and memory:
dstat -c --top-cpu -dn --top-mem

echo *************************************************************
echo "list down top 20 most time-consuming requests (descending) ordered by first the time taken and then by the status code"
for A in $(ls -la | awk '{print $NF}'); do echo $A && cat $A/conf/server.nginx && cat $A/logs/php-app.access.log | sort -nbrk 12,12 -k 7,7 |  head -n 20 | cut -d " " -f8 --complement; done 
