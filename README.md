# PrivateServer



Build:

docker build -t art/cloudflared .


Run:

docker run -it -d --name cloudflared_2 art/cloudflared


Exec:

docker exec -it cloudflared_2 bash