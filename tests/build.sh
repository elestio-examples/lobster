rm -f Dockerfile
rm -f docker-compose.yml
rm -f docker-entrypoint.sh
mv Dockerfile.new Dockerfile
mv docker-compose-new.yml docker-compose.yml
mv docker-entrypoint-new.sh docker-entrypoint.sh
docker buildx build . --output type=docker,name=elestio4test/lobster:latest | docker load