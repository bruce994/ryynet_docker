path="/home2/Guest/hg.zz.ylwlb.com"
chmod 777 "$path"
cd "$path"
chmod 777 infoconfig.php
chmod 777 mysqlconf.php
find . -name "Home" | xargs chmod 777
find . -name "Member" | xargs chmod 777
find . -name "WxPay" | xargs chmod -R 777
find . -name "Lanren" | xargs chmod 777
find . -name "Runtime" | xargs chmod -R 777
find . -name "upload" | xargs chmod -R 777
find . -name 'Runtime' | xargs rm -rf
