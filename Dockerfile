FROM ubuntu
RUN apt-get update && apt-get install wget -y && apt-get install sudo
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
RUN mv cloudflared-linux-arm64 cloudflared
RUN chmod u+x cloudflared
#ADD cert.pem /root/.cloudflare/cert.pem
RUN mv ./cloudflared /usr/bin/cloudflared
RUN cloudflared login
RUN cloudflared tunnel create docker
RUN touch /root/.cloudflared/config.yml
RUN echo "tunnel: 896325bb-a683-4bf4-9b7b-ba7ab6d06231\
credentials-file: /home/art/.cloudflared/896325bb-a683-4bf4-9b7b-ba7ab6d06231.json\
\
ingress:\
  - hostname: artemio.tk\
    service: http://localhost:8080\
  - hostname: ssh.artemio.tk\
    service: ssh://localhost:22\
  - service: http_status:404"