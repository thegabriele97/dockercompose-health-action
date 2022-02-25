FROM ubuntu:latest

LABEL "com.github.actions.name"="Wait docker-compose healthy"
LABEL "com.github.actions.description"="Very simple and small action to wait until all the services (given by docker-compose ps) are Up and Healthy!"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="red"

LABEL version="0.1.0"
LABEL repository="https://github.com/thegabriele97/dockercompose-health-action"
LABEL maintainer="La Greca Salvatore Gabriele @thegabriele97 <gabriele.lagreca@gmail.com>"

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python3
RUN apt-get install -y pip
RUN apt-get install -y curl
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

ADD entrypoint.sh /entrypoint.sh
COPY . /

ENTRYPOINT ["/entrypoint.sh"]
