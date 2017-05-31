FROM centos
RUN yum -y update
RUN yum install java
RUN http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.zip
RUN yum install -y wildfly
ADD mkdir -p /opt/wildfly
RUN cd /opt/
RUN firewall-cmd --zone=public --add-port=8080/tcp --permanent
RUN firewall-cmd --zone=public --add-port=9990/tcp --permanent
RUN firewall-cmd --reload
RUN useradd -s /usr/sbin/nologin wildfly
RUN ./add-user.sh 
RUN cd /etc/init.d
RUN ln -s /opt/wildfly/bin/init.d/wildfly-init-redhat.sh wildfly
RUN cd /etc/default
RUN service wildfly start
RUN chkconfig wildfly on
