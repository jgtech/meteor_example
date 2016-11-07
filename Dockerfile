FROM node:6.9.1

RUN curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh

ENV APP_HOME /app
RUN mkdir $APP_HOME

ENV APP_TMP /tmp

WORKDIR $APP_TMP

ADD . $APP_TMP

ENV NODE_ENV production
ENV NPM_CONFIG_LOGLEVEL warn

RUN meteor build --unsafe-perm --architecture=os.linux.x86_64 build
RUN tar -xf build/tmp.tar.gz --strip-components=1 -C $APP_HOME

WORKDIR $APP_HOME
RUN cd programs/server && npm install