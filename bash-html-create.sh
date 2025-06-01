#!/bin/bash

echo \<\!DOCTYPE html\> > landing.html
echo \<html\> >> landing.html
echo \<head\> >> landing.html
echo \<title\>web server\<\/title\> >> landing.html
echo \</head\> >> landing.html
echo \<body\> >> landing.html
echo \<h1\>This is a web server\:\<\/h1\>" >> landing.html
echo \<h1\>
curl ifconfig.me >> landing.html
echo \<\/h1\>
echo "\<\/body\>" >> landing.html
echo "\<\/\html\>" >> landing.html
