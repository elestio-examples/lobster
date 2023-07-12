#set env vars
set -o allexport; source .env; set +o allexport;

mkdir -p ./db-data
chmod 777 ./db-data

chmod +x ./docker-entrypoint.sh

