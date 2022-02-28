# OS
FROM ubuntu 
RUN apt-get update && apt-get install wget -y && apt-get install sudo

# Cloudflare install
RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
RUN mv cloudflared-linux-arm64 cloudflared
RUN chmod u+x cloudflared
RUN mv ./cloudflared /usr/bin/cloudflared

# Initialize Cloudflare
RUN cloudflared login 
RUN cloudflared tunnel create docker


# Save certificate info
RUN mkdir root/.aux
WORKDIR "root/.aux"
RUN cp -a /root/.cloudflared/. /root/.aux
RUN rm cert.pem
ADD config.yml /root/.cloudflared/config.yml
RUN echo * > FILE.txt
RUN echo $(cat FILE.txt) | cut -d'.' -f1 > NAME.txt

# Initilize tunnel setup with config file
ADD config.yml /root/.cloudflared/config.yml

# Setup according to certificate information
RUN sed -i -e "1 i tunnel: $(cat /root/.aux/NAME.txt)" /root/.cloudflared/config.yml
RUN sed -i -e "2 i credentials-file: /root/.cloudflared/$(cat /root/.aux/FILE.txt)" /root/.cloudflared/config.yml

# Delete aux files in config
WORKDIR "/"
RUN rm -r root/.aux

# Start DNS though CNAME docker.DOMAIN.XX
RUN cloudflared tunnel route dns -f docker docker

# Run tunnel as the container main process
CMD cloudflared tunnel run docker
