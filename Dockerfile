FROM ubuntu:latest

LABEL "com.github.actions.name"="Wait docker-compose healthy"
LABEL "com.github.actions.description"="Very simple and small action to wait until all the services (given by docker-compose ps) are Up and Healthy!"
LABEL "com.github.actions.icon"="activity"
LABEL "com.github.actions.color"="red"

LABEL version="0.1.0"
LABEL repository="https://github.com/thegabriele97/dockercompose-health-action"
LABEL maintainer="La Greca Salvatore Gabriele @thegabriele97 <gabriele.lagreca@gmail.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
