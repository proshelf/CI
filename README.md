# CI for RPI 

This repo contains the Dockerfile that is used for our Continious Integration.

# Content
The Dockerfile preconfigures the following packages:
  - Java 8
  - Jenkins
  - Nodejs
  - Python
  - PIP
  - AWS CLI
  
 # Usage
 docker run 
	-p 8080:8080
	-v ~/jenkins_home:/var/jenkins_home
	--name jenkins_ci
	-d user/repo:tag

* -v is used to map the jenkins home to a directory outside the container so that the jenkins configuration and jobs will survive the redeployment of the container.