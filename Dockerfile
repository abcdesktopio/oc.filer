FROM node:20

# default branch
ARG BRANCH=3.3
ENV BRANCH=$BRANCH

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libnss-extrausers \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# copy nsswitch.conf
COPY etc/nsswitch.conf /etc/nsswitch.conf

# copy file-service repo to /composer/node
RUN mkdir -p /composer/node/file-service && \
    git clone -b $BRANCH https://github.com/abcdesktopio/file-service.git /composer/node/file-service

# Add nodejs file-service and dep
WORKDIR /composer/node/file-service
RUN npm install --save-prod 

# create default log pid directory
RUN mkdir -p /var/log/desktop /var/run/desktop /composer/run

# set build date
RUN date > /etc/build.date

COPY docker-entrypoint.sh /docker-entrypoint.sh
WORKDIR /
CMD /docker-entrypoint.sh



