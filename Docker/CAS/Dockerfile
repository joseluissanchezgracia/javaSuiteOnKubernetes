FROM ubuntu:16.04
MAINTAINER David Carrascal <dcarrass@everis.com>


RUN echo ## BUILD.......... ##

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y wget && \
	apt-get install -y software-properties-common && \
	apt-get install -y python-software-properties
	
RUN wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.70/bin/apache-tomcat-7.0.70.tar.gz
RUN tar xvzf apache-tomcat-7.0.70.tar.gz
RUN mv apache-tomcat-7.0.70 tomcat

  
#Instalar java version "1.7.0_80"
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  
RUN add-apt-repository -y ppa:webupd8team/java  
RUN apt-get -y update 
RUN apt-get install -y oracle-java7-installer

ENV JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre


RUN echo ##JAVA INSTALADO ##


# Copio el fichero de usuarios
COPY tomcat-users.xml         	/tomcat/conf/tomcat-users.xml
COPY setenv.sh                	/tomcat/bin
COPY cas.war					/tomcat/webapps/
COPY cas.properties  		/tomcat/properties/
COPY log4j2.xml  			/tomcat/properties/


RUN echo ##VARIABLES DE ENTORNO:##
#ETCD connection
ENV ETCD_SERVER_URL			http://40.69.65.71:2379
ENV MULTITENANCY_ENABLED	false
ENV ETCD_SERVER_TENANTSPATH	tenants

#default BBDD
ENV JDBC_DRIVERCLASSNAME    com.microsoft.sqlserver.jdbc.SQLServerDriver
ENV JDBC_URL                jdbc:sqlserver://ehcoscloudsql.database.windows.net:1433;database=hospital1
ENV JDBC_USER               azure_user@ehcoscloudsql
ENV JDBC_PASS               ehCOS2014
ENV JDBC_VALIDATIONQUERY	select 1
ENV PERSISTENCE_DIALECT		org.hibernate.dialect.SQLServerDialect

RUN env

EXPOSE 8080
CMD ["/tomcat/bin/catalina.sh", "run"]
