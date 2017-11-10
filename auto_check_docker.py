#!/usr/bin/env python
#-*- coding: UTF-8 -*-
import sys
import string
import time
#print sys.version
import re
import os,shutil,platform,datetime
import calendar
import urllib
starttime = datetime.datetime.now()

ng  = "nginx.conf"
web = 1
if os.path.isfile(ng):
    f = open(ng, 'r')
    content = f.read()
    #myre = re.compile(r"server_name\s+([^;]+);[((?fastcgi_pass)\s\S)+]+fastcgi_pass\s+([^:]+):")
    myre = re.compile(r"server_name\s+([^;]+);")
    domain = myre.findall(content)

    myre = re.compile(r"fastcgi_pass\s+([^:]+):")
    docker = myre.findall(content)

    log = "monitor_web.log"

    i = 0
    for url in domain :
        if url == 'localhost' :
            continue
        goUrl = "curl -I -m 10 -o /dev/null -s -w %{http_code} "+url
        code = os.popen(goUrl).read()
        if code == '000' :
            web = 0
            os.popen("docker restart "+docker[i]+" >> " + log )
            os.popen('echo '+url+' >> '+log)
            os.popen('echo '+code+' >> '+log)
            os.popen('echo `date \'+%Y-%m-%d %H:%M:%S\'` >> '+log)
            os.popen('echo ----------------------------- >> '+log)
        print url + '-' + docker[i] + '-' +  code
        i = i + 1

if web == 0:
        os.popen("docker restart web ")

endtime = datetime.datetime.now()
print str((endtime - starttime).seconds) + ' sencond' #执行时间
