FROM ubuntu
VOLUME /opt
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt install -y tzdata \
  && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
  && echo ${TZ} > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata \
  && apt install curl -y \
  && apt install ffmpeg -y \
  && apt install -y python3-pip \
  && apt-get install -y git \
  && apt-get install -y zip \
  && pip install quickjs \
  && apt-get install -y locales \
  && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
  # Remove obsolete files:
  && apt-get autoremove --purge -y \
    unzip \
  && apt-get clean \
  && rm -rf \
    /tmp/* \
    /usr/share/doc/* \
    /var/cache/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

ENV LANG en_US.utf8
ENV TZ=Asia/Shanghai

#COPY requirements.txt /opt/
#RUN cd /opt \
#    && pip3 install -r requirements.txt
#USER webdriver
RUN pip3 install git+https://github.com/ForgQi/bilibiliupload.git

#COPY common /opt/common
#COPY engine /opt/engine
#COPY Bilibili.py /opt/
#RUN chmod 755 /opt/Bilibili.py
COPY ["config(demo).yaml", "/opt/config.yaml"]

WORKDIR /opt
#ENTRYPOINT ["./Bilibili.py"]
ENTRYPOINT ["biliup"]

#EXPOSE 9515/tcp
