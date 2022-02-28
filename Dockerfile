FROM ubuntu
RUN apt-get update && apt-get install wget -y && apt-get install sudo
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
RUN mv cloudflared-linux-arm64 cloudflared
RUN chmod u+x cloudflared
#ADD cert.pem /root/.cloudflare/cert.pem
RUN mv ./cloudflared /usr/bin/cloudflared
RUN cloudflared login
RUN cloudflared tunnel delete docker
RUN cloudflared tunnel create docker
RUN touch /root/.cloudflared/config.yml
ADD config.yml /root/.cloudflared/config.yml
RUN cloudflared tunnel route dns -f docker docker
CMD cloudflared tunnel run docker
