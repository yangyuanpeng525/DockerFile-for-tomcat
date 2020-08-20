#!/bin/bash
nohup /usr/bin/libreoffice -headless -accept="socket,host=0.0.0.0,port=2002;urp;" -nofirststartwizard & 
/TRS/new-media/nmup/bin/startup.sh 
tail -f /TRS/new-media/nmup/logs/catalina.out
