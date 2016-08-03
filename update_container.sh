#! /bin/sh

if [[ -z "$1" ]]; then
  echo "Must specify a password as the first argument"
  exit 1
fi

git clone git@github.com:dymurray/DockerWhale.git
cd DockerWhale
sed -i s/"version\ 2"/"$(date)"/g Dockerfile
docker build -t docker-whale .
image=$(docker images | grep docker-whale | tr -s ' ' | cut -d' ' -f 3)
docker tag $image dymurray/fusor:latest
docker login --username=dymurray --email=dymurray@redhat.com --password=$1
docker push dymurray/fusor
cd ..
rm -rf DockerWhale
