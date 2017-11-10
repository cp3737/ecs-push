#! /bin/bash
source ./bin/env.sh
source ./bin/env-kube.sh
docker-compose run web python manage.py test
