## Setup CI/CD Pipleine For Java based Web Application 

**Install Maven On Jenkins Machine**

```sh
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
mvn --version
```
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


## CD using Ansible and Jenkins 

## Update ec2 inventory details in ansible host file 
Path - /etc/ansible/hosts

```sh
[dev]
172.31.32.134

[prod]
172.31.45.140
```

## Create new ansible playbook for dev and prod deployment 

Path : /etc/ansible/playbook

**Deployment Playbook for Dev Environment**
```sh
- hosts: dev
  become: true
  become_user: root
  gather_facts: false
  tasks:
    - name: Transfer executable script
      copy: src=deployment.sh dest=/tmp/ mode=0777
    - name: Execute the script
      command: sh /tmp/deployment.sh
```

**Deployment Playbook for Prod Environment**
```sh
- hosts: prod
  become: true
  become_user: root
  gather_facts: false
  tasks:
    - name: Transfer executable script
      copy: src=deployment.sh dest=/tmp/ mode=0777
    - name: Execute the script
      command: sh /tmp/deployment.sh
```

**Deployment Shell Script** 

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

**Setup CI/CD Pipeline in Jenkins**
- [CI/CD Piepeline Code](https://github.com/CodvaTech-Labs/java_crud_demo/blob/main/devops/cicd.yml)


