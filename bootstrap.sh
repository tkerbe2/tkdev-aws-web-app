#!/bin/bash
yum install python3 -y
yum install python3-pip -y
python3 -m pip install simple_http_server -y
yum install git -y
git clone https://github.com/tkerbe2/tkdev-terraform-web-app
cd tkdev-terraform-web-app
chmod 700 bash-html-create.sh
./bash-html-create.sh
python3 -m http.server 80 >> output.html