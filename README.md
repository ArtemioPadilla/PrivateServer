# PrivateServer



Build:

docker build -t art/cloudflared .


Run:

docker run -it -d --restart unless-stopped --name cloudflared_2 art/cloudflared


Exec:

docker exec -it cloudflared_2 bash