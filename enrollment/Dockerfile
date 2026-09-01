FROM alpine:3.22

RUN apk add --no-cache \
    bash \
    curl \
    wget \
    openssl \
    coreutils \
    openjdk17-jre

WORKDIR /app

COPY entrypoint.sh                      /app/entrypoint.sh
COPY ./scripts/script_send_csr.sh                 /app/script_send_csr.sh
COPY ./scripts/script_create_csr.sh               /app/script_create_csr.sh
COPY ./scripts/script_store_ca_truststore.sh      /app/script_store_ca_truststore.sh
COPY ./scripts/script_store_client_keystore.sh    /app/script_store_client_keystore.sh

RUN mkdir archives
RUN mkdir key
RUN mkdir tmp

RUN chmod +x /app/entrypoint.sh
RUN chmod +x /app/script_send_csr.sh
RUN chmod +x /app/script_create_csr.sh
RUN chmod +x /app/script_store_ca_truststore.sh
RUN chmod +x /app/script_store_client_keystore.sh

ENTRYPOINT ["/app/entrypoint.sh"]
CMD []