export JAVA_OPTS="$JAVA_OPTS -Ddbconnection.type=jndi -Dprops.path=/tomcat/properties -Dserver.home=/tomcat -DenableLogger=/tomcat/properties/"
export CATALINA_OPTS="$CATALINA_OPTS -Xms128M -Xmx2048M -XX:MaxPermSize=160M"