FROM centos:7
MAINTAINER pony

WORKDIR /opt

#refer to https://doris.apache.org/installing/compilation.html to compile the required version 
ADD ./incubator-doris-DORIS-0.14.0-release.tar.gz ./jdk1.8.tar.gz /opt/

ENV DORIS_HOME /opt/output
ENV FE_LOG ${DORIS_HOME}/fe/log
ENV FE_META ${DORIS_HOME}/fe/doris-meta
ENV FE_TMP ${DORIS_HOME}/fe/temp_dir

ENV BE_LOG ${DORIS_HOME}/be/log
ENV BE_DATA ${DORIS_HOME}/be/data

ENV JAVA_HOME /opt/jdk1.8.0_271
ENV PATH $PATH:$JAVA_HOME/bin

# todo invalid
#RUN mkdir -p /data/output/fe/doris-meta && \
#    mkdir -p /data/doris_storage && \
#    sed -i "s@^storage_root_path.*@storage_root_path = /data/doris_storage@g" /data/output/be/conf/be.conf && \
#    sed -i "s|^[[:space:]]*\$LIMIT \$JAVA \$JAVA_OPTS org.apache.doris.PaloFe.*|    exec \$LIMIT \$JAVA \$JAVA_OPTS org.apache.doris.PaloFe \${HELPER} \"\$@\"|g" /data/output/fe/bin/start_fe.sh && \
#    sed -i "s|^[[:space:]]*\$LIMIT \${DORIS_HOME}/lib/palo_be.*|    exec \$LIMIT \${DORIS_HOME}/lib/palo_be \"\$@\"|g" /data/output/be/bin/start_be.sh

# set the time zone
RUN rm -f /etc/localtime; ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install mysql client
RUN yum install -y mariadb.x86_64 mariadb-libs.x86_64 && yum clean all

COPY ./startup.sh /opt/startup.sh

RUN yum -y install iproute && yum clean all

VOLUME [ "${FE_LOG}","${FE_META}","${FE_TMP}","${BE_LOG}","${BE_DATA}" ]

#EXPOSE 8030 8040
EXPOSE 8030 8040 9060 9050 8060 9020 9030 9010 8000

ENTRYPOINT ["/bin/bash","-x","startup.sh"]

#CMD ["be/fe"]
