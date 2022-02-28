FROM ubuntu
RUN apt-get update && apt-get install wget -y && apt-get install sudo
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
RUN mv cloudflared-linux-arm64 cloudflared
RUN chmod u+x cloudflared

RUN mv ./cloudflared /usr/bin/cloudflared
RUN cloudflared login
RUN cloudflared tunnel delete docker
RUN cloudflared tunnel create docker

RUN mkdir root/.aux
WORKDIR "root/.aux"
RUN cp -a /root/.cloudflared/. /root/.aux
RUN rm cert.pem

ADD config.yml /root/.cloudflared/config.yml
RUN echo * > FILE.txt
RUN echo $(cat FILE.txt) | cut -d'.' -f1 > NAME.txt


RUN sed -i -e "1 i tunnel: $(cat /root/.aux/NAME.txt)" /root/.cloudflared/config.yml
RUN sed -i -e "2 i credentials-file: /root/.cloudflared/$(cat /root/.aux/FILE.txt)" /root/.cloudflared/config.yml

WORKDIR "/"
RUN rm -r root/.aux

RUN cloudflared tunnel route dns -f docker docker

CMD cloudflared tunnel run docker
