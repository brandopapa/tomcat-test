FROM java:8u111-jre
################################
# 2018/11/15
#
MAINTAINER brando@cht.com.tw
################################
RUN apt-get update; apt-get install -y wget; cd /; \
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz; \
tar zxvf apache-tomcat-8.5.35.tar.gz

ARG UNAME=tomcat 
ARG UID=2000 
ARG GID=2000

RUN mkdir -m 711 /usr/local/$UNAME; mv /apache-tomcat-8.5.35/* /usr/local/$UNAME; rm -d /apache-tomcat-8.5.35; \
groupadd -g $UID $UNAME && useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME; \
chown -R $UNAME:$UNAME /usr/local/$UNAME/*; \
cd /usr/local/$UNAME; \
chmod -R 777 logs work webapps conf temp

WORKDIR /usr/local/$UNAME

ENV CATALINA_HOME=/usr/local/$UNAME

EXPOSE 8080/tcp

USER $UNAME
CMD ["bin/catalina.sh", "run"]
################################
