#!/bin/bash
 
VERSION=2.22.0
PORT=3900
 
if ! [ -f "wiremock-standalone-$VERSION.jar" ];
then
   curl -O http://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/$VERSION/wiremock-standalone-$VERSION.jar
fi
 
java -jar wiremock-standalone-$VERSION.jar --port $PORT --verbose
