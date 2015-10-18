#!/bin/bash

export DATABASE_URL="postgres://docker:docker@db:5432/docker"
export CELERY_BROKER_URL="redis://celery_broker:6394/1"
export SES_HOST="smtp_server"
export SES_PORT="25"
export GRAPHITE_API=http://grafana-graphite:8000/

python manage.py collectstatic --noinput &&\
python manage.py compress --force &&\
python manage.py syncdb --noinput && \
python manage.py migrate && \
python manage.py loaddata fixture.json

gunicorn cabot.wsgi:application --config gunicorn.conf --log-level info --log-file /var/log/gunicorn &\
celery worker -B -A cabot --loglevel=INFO --concurrency=3 -Ofair