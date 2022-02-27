# PrivateServer



Build:

docker build -t art/cloudflared .


Run:

docker run -it -d --restart unless-stopped --name cloudflared arm/cloudflared


Exec:

docker exec -it cloudflared bash