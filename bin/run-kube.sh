#! /bin/bash
source ./bin/env.sh
source ./bin/env-kube.sh

docker login --username "$DOCKER_USERNAME" --password "$DOCKER_PASSWORD"
docker push "$DOCKER_REPO"/"$DOCKER_WEB_IMAGE":latest

mkdir -p ${HOME}/.kube
cp cluster.cfg ${HOME}/.kube/config

kubectl config set clusters.sonya.foo.today.certificate-authority-data "$CERTAUTH"
kubectl config set users.sonya.foo.today.client-certificate-data "$CLIENTDATA"
kubectl config set users.sonya.foo.today.client-key-data "$CLIENTKEY"


kubectl --insecure-skip-tls-verify=true create -f web-claim0-persistentvolumeclaim.json
kubectl --insecure-skip-tls-verify=true create -f web-deployment.json
kubectl --insecure-skip-tls-verify=true create -f web-service.json
