#!/bin/bash
systemctl stop tomcat
aws s3 cp s3://crud-demo-build/CrudDemoWithMySql-0.0.1-SNAPSHOT.war ./
rm -rf /tmp/artifacts
mkdir /tmp/artifacts
mv CrudDemoWithMySql-0.0.1-SNAPSHOT.war CrudDemoWithMySql.war
cp CrudDemoWithMySql.war /tmp/artifacts
cp /tmp/artifacts/CrudDemoWithMySql.war /usr/share/tomcat/webapps
sudo systemctl start tomcat
