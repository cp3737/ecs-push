source ./bin/env-kube.sh

docker login --username "$DOCKER_USERNAME" --password "$DOCKER_PASSWORD"
docker push "$DOCKER_REPO"/"$DOCKER_WEB_IMAGE":latest

mkdir ${HOME}/.kube
cp cluster.cfg ${HOME}/.kube/config

kubectl config set clusters.sonya.foo.today.certificate-authority-data "$certificate-authority-data"
kubectl config set users.sonya.foo.today.client-certificate-data "$client-certificate-data"
kubectl config set users.sonya.foo.today.client-key-data "$client-key-data"


kubectl create -f web-claim0-persistentvolumeclaim.json
kubectl create -f web-deployment.json
kubectl create -f web-service.json
