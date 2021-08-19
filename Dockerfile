FROM loway/queuemetrics:19.10.21-137

MAINTAINER Adam Heathcote<aheathcote@linux.com>

ENV TZ=Australia/Hobart
ENV MEM=128
ENV DBNAME=demoqm
ENV DBPASS=demopass
ENV DBUSER=demouser
ENV DBHOST=demohost
RUN yum install vim -y

COPY init /data/init
COPY firstboot /ww/usr/firstboot
RUN chmod +x /ww/usr/firstboot
RUN chmod +x /data/init
COPY tpf.properties /data/qm/tpf.properties
COPY configuration.properties /data/qm/configuration.properties 

WORKDIR /data

ENTRYPOINT /data/init "$TZ" && /ww/run
