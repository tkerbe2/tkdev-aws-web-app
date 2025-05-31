#!/bin/bash

# These echo commands will create a basic website in HTML with a unique public IP
# This will help us identify the success of the load balancing

# I use escape characters in the echo command to print basic HTML code line-by-line
echo \<\!DOCTYPE html\> > landing.html
echo \<html\> >> landing.html
echo \<head\> >> landing.html
echo \<title\>web server\<\/title\> >> landing.html
echo \<\/head\> >> landing.html
echo \<body\> >> landing.html
echo \<h1\>This is a web server\:\<\/h1\> >> landing.html
echo \<h1\>
# This curl command uses a website dedicated to showing servers their public IPs and returns a simple value
curl ifconfig.me >> landing.html
echo \<\/h1\>
echo \<\/body\> >> landing.html
echo \<\/\html\> >> landing.html

