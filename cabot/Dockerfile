# Cabot Dockerfile
#
# https://github.com/shoonoise/cabot-docker
#
# VERSION 1.1

FROM     ubuntu:14.04.1

# Prepare
RUN apt-get update
RUN apt-get install -y build-essential nodejs libpq-dev python-dev npm git curl libldap2-dev libsasl2-dev iputils-ping

RUN curl -OL https://raw.github.com/pypa/pip/master/contrib/get-pip.py
RUN python get-pip.py

# Deploy cabot
RUN git clone https://github.com/arachnys/cabot.git /cabot
ADD fixture.json /cabot/
ADD run.sh /cabot/
ADD gunicorn.conf /cabot/gunicorn.conf

# Install dependencies
RUN pip install -e /cabot/
RUN find /usr/lib/python2.7/dist-packages -iname "*hipchat*"
RUN pip uninstall -y cabot-alert-hipchat

RUN git clone https://github.com/krunal-manik/cabot-alert-hipchat /cabot/cabot-alert-hipchat
RUN pip install -e /cabot/cabot-alert-hipchat/


RUN npm install --no-color -g coffee-script less@1.3 --registry http://registry.npmjs.org/

# Set env var
ENV PATH $PATH:/cabot/:/cabot-alert-hipchat/
ENV PYTHONPATH $PYTHONPATH:/cabot/:/cabot-alert-hipchat/


# Cabot settings
ENV DJANGO_SETTINGS_MODULE cabot.settings
ENV LOG_FILE /var/log/cabot
ENV PORT 5000
ENV DEBUG t

ENV DJANGO_SECRET_KEY 2FL6ORhHwr5eX34pP9mMugnIOd3jzVuT45f7w430Mt5PnEwbcJgma0q8zUXNZ68A

RUN ["ln","-s","/usr/bin/nodejs","/usr/bin/node"]

WORKDIR /cabot/
CMD . /cabot/run.sh
