## Setup CI/CD Pipleine For Java based Web Application 

## Refer below user data script for Application Deployment 

```sh
#!/bin/bash
systemctl stop tomcat
aws s3 cp s3://crud-demo-build/CrudDemoWithMySql-0.0.1-SNAPSHOT.war ./
rm -rf /tmp/artifacts
mkdir /tmp/artifacts
mv CrudDemoWithMySql-0.0.1-SNAPSHOT.war CrudDemoWithMySql.war
cp CrudDemoWithMySql.war /tmp/artifacts
cp /tmp/artifacts/CrudDemoWithMySql.war /usr/share/tomcat/webapps
sudo systemctl start tomcat
```

## Important Link 
Kindly refer below code:

- [CICD Pipeline Code] - https://github.com/CodvaTech-Labs/java_crud_demo/blob/main/devops/cicd.yml
- [Ansible Playbook] - https://github.com/CodvaTech-Labs/java_crud_demo/blob/main/devops/

