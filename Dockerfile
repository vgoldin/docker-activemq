FROM ubuntu

RUN rm /etc/apt/sources.list
RUN echo deb http://archive.ubuntu.com/ubuntu trusty main universe multiverse > /etc/apt/sources.list

RUN apt-get update
RUN apt-get install openjdk-6-jre curl -y

RUN curl http://apache.mirror1.spango.com/activemq/5.10.0/apache-activemq-5.10.0-bin.tar.gz > apache-activemq-5.10.0-bin.tar.gz
RUN tar xzf apache-activemq-5.10.0-bin.tar.gz

EXPOSE 61616 8161

CMD java -Xms1G -Xmx1G -Djava.util.logging.config.file=logging.properties -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote -Djava.io.tmpdir=apache-activemq-5.10.0/tmp -Dactivemq.classpath=apache-activemq-5.10.0/conf -Dactivemq.home=apache-activemq-5.10.0 -Dactivemq.base=apache-activemq-5.10.0 -Dactivemq.conf=apache-activemq-5.10.0/conf -Dactivemq.data=apache-activemq-5.10.0/data -Dhawtio.realm=activemq -Dhawtio.role=admins -Dhawtio.rolePrincipalClasses=org.apache.activemq.jaas.GroupPrincipal -Djava.security.auth.login.config=apache-activemq-5.10.0/conf/login.config -jar apache-activemq-5.10.0/bin/activemq.jar start