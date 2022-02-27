# PrivateServer



Build:

docker build -t art/cloudflared .


Run:

docker run -it -d -p 8080:80 --restart unless-stopped --name cloudflared arm/cloudflared


Exec:

docker exec -it cloudflared bash