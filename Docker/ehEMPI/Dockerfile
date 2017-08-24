FROM ubuntu:16.04
MAINTAINER David Carrascal <dcarrass@everis.com>

RUN echo ## BUILDING IMAGE.......... ##

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y wget && \
       apt-get install -y software-properties-common && \
       apt-get install -y python-software-properties
       
RUN wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.70/bin/apache-tomcat-7.0.70.tar.gz
RUN tar xvzf apache-tomcat-7.0.70.tar.gz
RUN mv apache-tomcat-7.0.70 tomcat

RUN echo ## TOMCAT INSTALLED.......... ##
  
#Instalar java version "1.7.0_80"
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  
RUN add-apt-repository -y ppa:webupd8team/java  
RUN apt-get -y update 
RUN apt-get install -y oracle-java7-installer

ENV JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre

RUN echo ##JAVA INSTALADO ##

RUN echo ## BUILDING.......... ##

###################################
#### VARIABLES DE ENTORNO EHEMPI ##
ENV JNDI_NAME                  java:comp/env/jdbc/ehCOSDatasourceCS
ENV JDBC_DRIVERCLASSNAME       com.microsoft.sqlserver.jdbc.SQLServerDriver
ENV JDBC_URL                   jdbc:sqlserver://ehcoscloudsql.database.windows.net:1433;database=hospital1
ENV JDBC_USER                  azure_user@ehcoscloudsql
ENV JDBC_PASS                  ehCOS2014
ENV PERSISTENCE_DIALECT        org.hibernate.dialect.SQLServerDialect
ENV JDBC_DATABASE              SQL_SERVER
ENV JDBC_VALIDATIONQUERY       Select 1

ENV CAS_IP_ADDRESS             192.168.99.100:8080
ENV CAS_NOPUBLIC_IP_ADDRESS    192.168.99.100:8080
#IP de vuelta a la aplicacion
ENV ENV_IP_ADDRESS             192.168.99.100:8090
ENV HTTP_TYPE                  http
ENV REMOTING_ADDRESS           192.168.99.100:63080
ENV SERVER_WEBAPPS_PATH        /opt/ehcos/tomcat7u/webapps

#Multitenancy 
ENV MULTITENANCY_ENABLED         false
ENV ETCD_SERVER_URL              http://40.69.65.71:2379
ENV ETCD_SERVER_TENANTSPATH      tenants

##############################

# Copio ficheros customizados
COPY tomcat-users.xml      /tomcat/conf/tomcat-users.xml
COPY ehEMPIProject.properties  /tomcat/properties/
COPY ehEMPI-log4j.xml          /tomcat/properties/

COPY server.xml          /tomcat/conf/
COPY context.xml          /tomcat/conf/
COPY setenv.sh            /tomcat/bin/

COPY sqljdbc4-4.0.jar      /tomcat/lib

COPY ehEMPI-ui.war  /tomcat/webapps

#borro la imagen de tomcat
RUN rm /apache-tomcat-7.0.70.tar.gz

RUN echo ##VARIABLES DE ENTORNO:##
RUN env

EXPOSE 8080
CMD ["/tomcat/bin/catalina.sh", "run"]
#CMD ["/bin/bash"]
