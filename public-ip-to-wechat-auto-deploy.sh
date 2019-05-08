yum install -y wget
wget --no-check-certificate -P /etc/cron.hourly https://raw.githubusercontent.com/yorfir/public_ip/master/get_ip_sample.sh
echo -e "/sbin/service cron start" >> /etc/rc.d/rc.local
echo -e "01 * * * * root run-parts /etc/cron.hourly" >> /etc/crontab
systemctl restart crond.service
echo "安装成功,请注意查收微信消息"
