#!/bin/bash
ip_old=ip_old.txt
ip_now=ip_now.txt

## init ip.old

while [ ! -f $ip_old ]; do
curl ipv4.ip.sb  > $ip_old
done
## get ip now

curl ipv4.ip.sb > $ip_now

/usr/bin/diff $ip_now $ip_old

if [ $? != 0 ];then
cat $ip_now > $ip_old
echo "IP has changed,new ip is$(cat $ip_now) !!!" | curl "https://sc.ftqq.com/SCU3648T93bd7105aedd45e3a9f70497a714dee2581c95d7e4c41.send?text=$(cat $ip_now)"
fi
