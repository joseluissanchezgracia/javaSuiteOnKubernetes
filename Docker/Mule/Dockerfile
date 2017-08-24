FROM ubuntu:16.04
MAINTAINER David Carrascal <dcarrass@everis.com>

RUN echo ## BUILDING IMAGE.......... ##

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y wget && \
       apt-get install -y software-properties-common && \
       apt-get install -y python-software-properties
  
#Instalar java version "1.7.0_80"
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  
RUN add-apt-repository -y ppa:webupd8team/java  
RUN apt-get -y update 
RUN apt-get install -y oracle-java7-installer

ENV JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre

RUN echo ##JAVA INSTALADO ##

RUN echo ## BUILDING.......... ##

RUN cd /opt && wget https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.4.0/mule-standalone-3.4.0.tar.gz

RUN cd /opt && tar xvzf mule-standalone-3.4.0.tar.gz && rm mule-standalone-3.4.0.tar.gz && ln -s /opt/mule-standalone-3.4.0 /opt/mule

RUN rm /opt/mule/lib/opt/spring-web-3.2.1.RELEASE.jar

###################################
#### VARIABLES DE ENTORNO INTEROPERABILITY ##

#General
ENV MULE_HOME /opt/mule

#Proxy
ENV proxy_host			localhost
ENV proxy_port       	63082
ENV proxy_port_ssl      63083

# CAS
ENV cas_protocol		http
ENV cas_host            localhost
ENV cas_port        	8080
ENV cas_context			/cas

# WS and ActiveMQ
ENV ws_host				localhost
ENV ws_port				6001
ENV mqbroker_host		localhost
ENV mqbroker_port		61616
ENV mqserv_host			localhost
ENV mqserv_port			63080

# Apps
ENV application_host					localhost
ENV application_port					8080
ENV application_host_his				localhost
ENV application_port_his				8080
ENV application_host_empi				localhost
ENV application_port_empi				8080
ENV application_host_clinicalShare      localhost
ENV application_port_clinicalShare      8080

##############################

# Define mount points.
VOLUME ["/opt/mule/logs", "/opt/mule/apps", "/opt/mule/domains"]

# Define working directory.
WORKDIR /opt/mule

#Copy jars. As requested in manual de instalación (pag. 22)
COPY libs/activemq-all-5.7.0.jar  /opt/mule/lib/user/
COPY libs/hessian-4.0.7.jar  /opt/mule/lib/user/

COPY libs/ehAccord-int-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehActivityLog-int-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehAnalitics-int-1.0.0-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehClinicalShare-int-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehCOS-int-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehCS-int-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehEMPI-int-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehHIS-int-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehReferral-int-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehSalesforce-int-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/
COPY libs/ehMultitenant-support-4.3-cloud-SNAPSHOT.jar  /opt/mule/lib/user/

COPY libs/spring-web-4.3.6.RELEASE.jar  /opt/mule/lib/opt/

#copy properties
COPY ehcos-interoperability-app.properties  /opt/mule/conf

#copy Interoperability ZIP file
COPY ehcos-interoperability.zip /opt/mule/apps

# Default http port
EXPOSE 63080

CMD [ "/opt/mule/bin/mule" ]