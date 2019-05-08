动态获取linux公网ip，然后curl 使用server 酱接口推送新的公网ip。已经更新使用ip.sb来获取ip

如需获取ipv6地址。请替换为ipv4.ip.sb 为 ipv6.ip.sb

获取SCKEY地址http://sc.ftqq.com/?c=code

添加cron来间隔一小时获取ipv4地址

01 * * * * root run-parts /etc/cron.hourly

全自动部署

wget --no-check-certificate https://raw.githubusercontent.com/yorfir/public_ip/master/get_ip_sample.sh && sh besttrace.sh

cron用法
cron服务的启动关闭
启动：service cron start
停止：service cron stop
重启：service cron restart
查看状态：service cron status
重新载入配置：service cron reload

你也可以将这个服务在系统启动的时候自动启动：
在/etc/rc.d/rc.local这个脚本的末尾加上：
/sbin/service cron start 

cron服务提供crontab命令来设定cron服务的，以下是这个命令的一些参数与说明：
crontab -u //设定某个用户的cron服务，一般root用户在执行这个命令的时候需要此参数
crontab -l //列出某个用户cron服务的详细内容
crontab -r //删除某个用户的cron服务
crontab -e //编辑某个用户的cron服务  
比如说root查看自己的cron设置：crontab -u root -l
再例如，root想删除fred的cron设置：crontab -u fred -r 

每次编辑完某个用户的cron设置后，cron自动在/var/spool/cron下生成一个与此用户同名的文件，此用户的cron信息都记录在这个文件中，这个文件是不可以直接编辑的，只可以用crontab -e 来编辑。cron启动后每过一份钟读一次这个文件，检查是否要执行里面的命令。因此此文件修改后不需要重新启动cron服务。 

全局性配置文件：
# m h dom mon dow user command
用户自身配置文件
# m h  dom mon dow   command

m 分钟　（0-59）
h 小時　（0-23）
dom 日期　（1-31）
mon 月份　（1-12）
dow 星期　（0-6）//0代表星期天 
*代表所有的取值范围内的数字，"/"代表每的意思,"*/5"表示每5个单位，"-"代表从某个数字到某个数字,","分开几个离散的数字。

每天早上6点
0 6 * * * echo "Good morning." >> /tmp/test.txt //注意单纯echo，从屏幕上看不到任何输出，因为cron把任何输出都email到root的信箱了。
每两个小时
0 */2 * * * echo "Have a break now." >> /tmp/test.txt
晚上11点到早上8点之间每两个小时，早上八点
0 23-7/2，8 * * * echo "Have a good dream：）" >> /tmp/test.txt
每个月的4号和每个礼拜的礼拜一到礼拜三的早上11点
0 11 4 * 1-3 command line
1月1日早上4点
0 4 1 1 * command line 



cron 的主配置文件是 /etc/crontab，它包括下面几行：
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
HOME=/

# run-parts
01 * * * * root run-parts /etc/cron.hourly
02 4 * * * root run-parts /etc/cron.daily
22 4 * * 0 root run-parts /etc/cron.weekly
42 4 1 * * root run-parts /etc/cron.monthly

前四行是用来配置 cron 任务运行环境的变量。SHELL 变量的值告诉系统要使用哪个 shell 环境（在这个例子里是 bash shell）；PATH 变量定义用来执行命令的路径。cron 任务的输出被邮寄给 MAILTO 变量定义的用户名。如果 MAILTO 变量被定义为空白字符串（MAILTO=""），电子邮件就不会被寄出。HOME 变量可以用来设置在执行命令或脚本时使用的主目录。

如你在 /etc/crontab 文件中所见，它使用 run-parts 脚本来执行 /etc/cron.hourly、/etc/cron.daily、/etc/cron.weekly 和 /etc/cron.monthly 目录中的脚本，这些脚本被相应地每小时、每日、每周、或每月执行。这些目录中的文件应该是 shell 脚本。

如果某 cron 任务需要根据调度来执行，而不是每小时、每日、每周、或每月地执行，它可以被添加到/etc/cron.d目录中。该目录中的所有文件使用和 /etc/crontab 中一样的语法。

