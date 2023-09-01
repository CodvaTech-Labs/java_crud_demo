## Setup CI/CD Pipleine For Java based Web Application 

**Install Maven On Jenkins Machine**

```sh
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
mvn --version
```

***Fork and clone below Java Project Repository***
- [Java Web Demo App](https://github.com/CodvaTech-Labs/java_crud_demo)

**Create Build for Java based App using below Maven Command**

```sh
mvn clean — Delete the previously compiled java files and 
resources(Files inside the target folder will be deleted)

mvn compile — Compile the source java classes. If you need to compile the test classes 
of the maven project, you can use the “compiler:testCompile” command.

mvn package — Wrap the source code into a file format which 
we can share or distribute (eg:war, jar). Simply converts in to an executable java program.

mvn install — Install the package or the wrapped compiled 
code(jar or war file)in our local repository. So we can use it for our other projects as well.

mvn test — Run tests using an unit test framework and you 
can see the output in console.

mvn deploy — Install or copy the final package to a remote 
repository. So other developers also can use it.

mvn dependency:tree
This command generates the dependency tree of the Maven project

mvn dependency:analyze
This command analyzes the maven project to identify the unused declared and used undeclared dependencies:

Validate Path - /home/ec2-user/test/java_crud_demo/CrudDemoWithMySql/target

Upload Artifacts to S3 Bucket (Create Bucket in AWS S3 to Store Artifacts)
aws s3 cp /home/ec2-user/maven_demo/java_crud_demo/CrudDemoWithMySql/target/CrudDemoWithMySql-0.0.1-SNAPSHOT.war s3://crud-demo-build/

```

**CI - Setup Job in Jenkins**
- [CI Pipeline Code] - https://github.com/CodvaTech-Labs/java_crud_demo/blob/main/devops/ci-job.yml

## Refer below user data script for Automated Application Deployment 

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


