Update
Step 1: Setup App Node(tomcat) (EC2 Instance)
Update

#!/bin/bash
yum install -y git
amazon-linux-extras install tomcat8.5
systemctl start tomcat


Step 02 : Application Deployment on Tomcat 

#!/bin/bash
systemctl stop tomcat
url=https://devops2022.jfrog.io/artifactory/default-maven-local/CrudDemoWithMySql/CrudDemoWithMySql/0.0.1-SNAPSHOT/CrudDemoWithMySql-0.0.1-SNAPSHOT.war
wget --user=ctldevopsnov2021@gmail.com --password=Devops@2022 -q -N $url
rm -rf /tmp/artifacts
mkdir /tmp/artifacts
mv CrudDemoWithMySql-0.0.1-SNAPSHOT.war CrudDemoWithMySql.war
cp CrudDemoWithMySql.war /tmp/artifacts
cp /tmp/artifacts/CrudDemoWithMySql.war /usr/share/tomcat/webapps
sudo systemctl start tomcat
