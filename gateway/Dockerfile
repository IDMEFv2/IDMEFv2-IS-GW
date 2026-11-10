FROM ubuntu:jammy

RUN apt-get update -qq && \
    apt-get install -y wget curl bash 

COPY ./is-gateway/s4sgateway /s4sgateway
COPY ./is-gateway/application.properties /application.properties

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]