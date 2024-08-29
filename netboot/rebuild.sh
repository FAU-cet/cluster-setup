docker compose pull
docker compose up --build -d --remove-orphans
docker image prune -f
