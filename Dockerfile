# Pull base image
FROM resin/rpi-raspbian:jessie

# Update package manager cache
RUN sudo apt-get update 
RUN sudo apt-get install -y wget git

# Install OpenJDK 8 runtime without X11 support
RUN sudo apt-get install -y oracle-java8-jdk

# install NodeJS
RUN sudo apt-get install -y nodejs npm

# install AWS CLI
RUN sudo apt-get install -y python-pip
RUN sudo pip install --upgrade --user awscli

# Setup env
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000

# Jenkins is ran with user `jenkins`, uid = 1000
# If you bind mount a volume from host/volume from a data container,
# ensure you use same uid
RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins

# Jenkins home directoy is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home

RUN chown -R jenkins "$JENKINS_HOME"

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

RUN mkdir -p /opt/jenkins && \
        cd /opt/jenkins && \
        wget --no-check-certificate https://updates.jenkins-ci.org/latest/jenkins.war

CMD java -jar /opt/jenkins/jenkins.war --prefix=$PREFIX
