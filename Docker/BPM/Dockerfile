
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


RUN echo ## BUILDING BPM.......... ##

##############################################
#### VARIABLES DE ENTORNO                   ##
#Vbles BBDD
#POSTGRESQL ##########################################################################################
#Comment if jndi is not used
#ENV PERSISTENCE_DATABASE       POSTGRESQL
#ENV JDBC_DRIVERCLASSNAME       org.postgresql.Driver
#ENV JDBC_URL                   jdbc:postgresql://192.168.50.82:5432/ehcos
#ENV JDBC_USERNAME              postgres
#ENV JDBC_PASSWORD              postgres
#ENV PERSISTENCE_DIALECT        org.hibernate.dialect.PostgreSQLDialect
#ORACLE     ##########################################################################################
#ENV PERSISTENCE_DATABASE         ORACLE
#ENV PERSISTENCE_DIALECT          org.hibernate.dialect.Oracle10gDialect
#ENV JDBC_DRIVERCLASSNAME         jdbc_driverClassName=oracle.jdbc.driver.OracleDriver
#ENV JDBC_URL                     jdbc:oracle:thin:@localhost:1521/xe
#ENV JDBC_USERNAME                jdbc.username=jbpm
#ENV JDBC_PASSWORD                jbpm
#ENV DBCONNECTION_TYPE            jdbc
#ENV JDBC_PORTNUMBER              5432
#ENV JDBC_DATABASENAME            local
#ENV JDBC_SERVERNAME              localhost
##############################################
#ENV JDBC_URL                 jdbc:sqlserver://ehcoscloudsql.database.windows.net:1433;database=hospital1
#ENV JDBC_USERNAME            azure_user@ehcoscloudsql

ENV PERSISTENCE_DATABASE     SQL_SERVER
ENV PERSISTENCE_DIALECT      com.everis.ehcos.framework.database.azure.AzureSQLDialect

ENV JDBC_DRIVERCLASSNAME     com.microsoft.sqlserver.jdbc.SQLServerDriver
ENV JDBC_USERNAME            JBPM
ENV JDBC_PASSWORD            ehCOS2014
ENV JDBC_PORTNUMBER          1433
ENV JDBC_DATABASENAME        dev
ENV JDBC_SERVERNAME          ehcosazuredb.database.windows.net
ENV JDBC_VALIDATION_QUERY	 select 1

ENV JNDI_NAME                java:comp/env/jdbc/ehCOSDatasourceBPM

#Multitenancy
ENV MULTITENANCY_ENABLED         false
ENV ETCD_SERVER_URL              http://40.69.65.71:2379
ENV ETCD_SERVER_TENANTSPATH      tenants

#Rutas de los diferentes componentes
ENV BPM_PATH_CEX                 http://localhost:7001/ehCS-ui/ws
ENV BPM_PATH_HIS                 http://localhost:7001/ehHIS-ui/ws
ENV BPM_PATH_CLINIC              http://localhost:7001/ehCS-ui/ws
ENV BPM_PATH_ACCORD              http://localhost:7001/ehAccord-ui/ws
ENV BPM_PATH_SOCIALWORK          http://localhost:7001/ehCS-ui/ws

ENV PROPS_PATH                   /tomcat/properties/
ENV SERVER_HOME                  /tomcat


COPY ehcs-workflow-server-jbpm.war  /tomcat/webapps/

#Copiar los ficheros de properties
COPY bpm.properties /tomcat/properties/
COPY bpm.versions.properties /tomcat/properties/
COPY bpm-log4j.xml /tomcat/properties/

#Copiar las librerias al tomcat
COPY ./jndi-dependencies/*.jar /tomcat/lib/

##############################
# Copio ficheros customizados
COPY tomcat-users.xml      /tomcat/conf/tomcat-users.xml
COPY server.xml            /tomcat/conf/server.xml
COPY context.xml           /tomcat/conf/context.xml
COPY setenv.sh             /tomcat/bin/setenv.sh

COPY sqljdbc4-4.0.jar      /tomcat/lib


# Elimino el fichero del tomcat
RUN  rm /apache-tomcat-7.0.70.tar.gz

RUN echo ##VARIABLES DE ENTORNO:##
RUN env

EXPOSE 8080
CMD ["/tomcat/bin/catalina.sh", "run"]
