FROM ubuntu
RUN apt-get update && apt-get install wget -y && apt-get install sudo
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
RUN mv cloudflared-linux-arm64 cloudflared
RUN chmod u+x cloudflared

ADD cert.pem /root/.cloudflare/cert.pem

RUN mv ./cloudflared /usr/bin/cloudflared
RUN cloudflared login
RUN cloudflared tunnel delete docker
RUN cloudflared tunnel create docker

RUN mkdir root/.aux
WORKDIR "root/.aux"
RUN cp -a /root/.cloudflared/. /root/.aux
RUN rm cert.pem

ADD config.yml /root/.cloudflared/config.yml
RUN FILE="$(echo *)"
RUN echo *
RUN NAME="$(echo $FILE | cut -d'.' -f1)"
RUN sed -i -e "1 i tunnel: $NAME" /root/.cloudflared/config.yml
RUN sed -i -e "2 i credentials-file: /root/.cloudflared/$FILE" /root/.cloudflared/config.yml
RUN cat root/.cloudflared/config.yml
RUN cloudflared tunnel route dns -f docker docker

CMD cloudflared tunnel run docker
