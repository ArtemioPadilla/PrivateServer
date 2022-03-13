# PrivateServer

## Setup

- Ensamblar RPI
- Descargar RPI Imager
- FLashear RPI e Iniciar
- Activar SSH (Secure Shell)  Configureacion  Interfaces -SSH
- Configurar IP fija
    www.makeuseof.com/raspberry-pi-set-static-ip
- acceder a la IP del RPI
    ssh pi@192.168.0.19 
- Instalar Docker
    https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script
- Hacer cuenta de CloudFlare
https://dash.cloudflare.com/sign-up
- Conseguir dominio gratis
    https://my.freenom.com/
- Conectar CloudFlare y dominio


## Run and compilation 
### To build from Dockerfile

To Build:

          docker build -t cloudflared .


To Run:

          docker run -it -d --name cloudflared cloudflared


To Exec:

          docker exec -it cloudflared bash


### To Run Docker Compose

          docker-compose up --build


## Containers:

### cloudflared

_Hostname:_ cloudflared

_Purpose:_ To be the link betweet the internet and the server

_Configutarion:_ The ingress rules for CNAMES and ports is in the `config.yml`



### nginx-container

_Hostname:_ web

_Purpose:_ To host a website on port 80

_Mount:_ ?

### SSH Host

_Hostname:_ __???__

_Purpose:_ To host SSH connections to the host machine and to other capable containers.


## Networks

### Stable Network
          subnet: 172.20.0.0/16
          ip_range: 172.28.5.0/24
          gateway: 172.20.128.1

Served IPs:
  - 172.20.128.1: Host Machine
  - 172.20.128.2: cloudflared
  - 172.20.128.3: web
  - 172.20.128.4: ?

## Mounts

 - web: ?
