FROM docker.io/library/ubuntu:18.04
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install openjdk-8-jdk wget
RUN mkdir /usr/local/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz /tmp/apache-tomcat-9.0.85.tar.gz
RUN cd /tmp && tar xvfz apache-tomcat-9.0.85.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.85/* /usr/local/tomcat/
ADD */.war /usr/local/tomcat/webapps
EXPOSE 8081
CMD /usr/local/tomcat/bin/catalina.sh run
FROM docker.io/library/ubuntu:18.04

# Update and install dependencies
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install openjdk-8-jdk wget

# Create Tomcat directory
RUN mkdir /usr/local/tomcat

# Download and extract Apache Tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz /tmp/
RUN tar xvfz /tmp/apache-tomcat-9.0.85.tar.gz -C /usr/local/tomcat --strip-components=1

# Clean up unnecessary files
RUN rm -rf /tmp/apache-tomcat-9.0.85.tar.gz /usr/local/tomcat/webapps/*

# Add Jenkins integration script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Add your WAR file to the webapps directory
ADD *.war /usr/local/tomcat/webapps/

# Expose Tomcat port
EXPOSE 8081

# Set entry point to start Tomcat and integrate with Jenkins
ENTRYPOINT ["/entrypoint.sh"]

