#!/bin/bash
sudo yum install python3 -y
sudo yum install python3-pip -y
sudo python3 -m pip install simple_http_server -y
sudo yum install git -y
git clone https://github.com/tkerbe2/tkdev-terraform-web-app
cd tkdev-terraform-web-app
sudo chmod 700 bash-html-create.sh
./bash-html-create.sh
sudo python3 -m http.server 80 >> output.html