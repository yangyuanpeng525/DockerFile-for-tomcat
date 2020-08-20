FROM registry.cn-hangzhou.aliyuncs.com/yangyuanpeng/debian:stretch-slim
#设置utf8编码环境
ENV LANG  C.UTF-8
# 添加阿里云镜像源，设置中国时区,安装imagemagick
#RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
#unoconv
RUN        apt-get update \
          && apt-get install -y tzdata imagemagick  procps  \
          && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone \
          && apt-get clean \
          && apt-get autoclean \
          && apt-get autoremove \
          && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/* \
          && mkdir -p /TRS/APP/ImageMagick && ln -s /usr/bin/ /TRS/APP/ImageMagick
# 创建jre安装目录并下载到指定位置
RUN mkdir -p /TRS/APP
ADD ./LibreOffice_5.3.6.1_Linux_x86-64_deb.tar.gz  /TRS/APP
ADD ./jdk1.8.tar.gz /TRS/APP
ADD ./arthas-3.2.0.tar.gz /TRS/APP
#设置环境变量
ENV JAVA_HOME /TRS/APP/jdk1.8
ENV PATH ${PATH}:${JAVA_HOME}/bin
#安装tomcat模块
ENV JAVA_OPTS="-server -Xms4096m -Xmx4096M -Djava,security.egd=file:/dev/.urandom -Dfile.encoding=utf-8 -Xloggc:/TRS/HyCloud/NMUP/logs/gc.log -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=9877"
# 安装采编tomcat9模块
#设置tomcat名称(如NMUP,IGI,IGS)
ENV TOMCAT_NAME=nmup
ENV TOMCAT_VERSION=9.0.31
RUN mkdir /TRS/new-media
RUN cd /TRS/APP/LibreOffice_5.3.6.1_Linux_x86-64_deb && dpkg -i /TRS/APP/LibreOffice_5.3.6.1_Linux_x86-64_deb/DEBS/*.deb  && rm -rf  /TRS/APP/LibreOffice_5.3.6.1_Linux_x86-64_deb
ADD apache-tomcat-9.0.31.tar.gz /TRS/new-media
RUN mv /TRS/new-media/apache-tomcat-9.0.31 /TRS/new-media/nmup && rm -rf  /TRS/new-media/nmup/webapps/* && mkdir -p  /TRS/new-media/nmup/webapps/ROOT && echo "NMUP test" >> /TRS/new-media/nmup/webapps/ROOT/index.html && mkdir -p /TRS/new-media/nmup/WCMData 
EXPOSE 8080 9877
COPY ./run.sh /TRS/new-media/nmup
VOLUME /TRS/new-media/nmup/WCMData
VOLUME /TRS/new-media/nmup/logs
CMD ["/TRS/new-media/nmup/run.sh", "run" ]

#为了减小镜像大小，导入的安装包装完后要在镜像同一层删除，下一层镜像只读上一层镜像的内容，不能删，会导致镜像过大
