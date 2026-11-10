#!/usr/bin/env bash

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
NC='\e[0m'  # No Color

abort() {
    echo -e "${RED}ERROR${NC}: $1" >&2
    exit 1
}

PKI_DOMAIN="${PKI_DOMAIN:-pki.safe4soc.cosypoc.fr}"
ENROLL_ENDPOINT="${ENROLL_ENDPOINT:-/.well-known/est/simpleenroll}"
CACERTS_ENDPOINT="${CACERTS_ENDPOINT:-/.well-known/est/cacerts}"
TRUST_STORE_PASSWORD="${TRUST_STORE_PASSWORD:-password}"

[ -z "${PKI_DOMAIN}" ] && abort "PKI_DOMAIN is not set, cannot send CSR"

CACERTS_ENDPOINT="${CACERTS_ENDPOINT#/}" # Normalize: strip leading slash to avoid double //
CA_ENDPOINT="https://${PKI_DOMAIN}/${CACERTS_ENDPOINT}"
echo -e "${BLUE}INFO${NC}: CA endpoint: ${CA_ENDPOINT}"

echo "Storing CA Certs from: $PKI_DOMAIN"
cd /app/tmp || abort "cant access folder /app/tmp"
curl -k -s "$CA_ENDPOINT" > ca-chain.pem.pkcs7.b64 || abort "cant curl"
cat ca-chain.pem.pkcs7.b64  | openssl base64 -d -A > ca-chain.pem.pkcs7 || abort "cant transform"
cat ca-chain.pem.pkcs7 | openssl pkcs7 -inform DER -print_certs > ca-chain.pem || abort "cant transform"

echo "Printing received certs:"
cat ca-chain.pem || abort
echo "Splitting received certs:"
csplit -s -z -f ca- ca-chain.pem '/-----BEGIN CERTIFICATE-----/' '{*}' || abort "cant split certificates"

# Inspect truststore
echo "Inspecting Truststore"
openssl x509 -in ca-01 -noout -subject -issuer || abort
openssl x509 -in ca-02 -noout -subject -issuer || abort

STORE_PASS=${STORE_PASS:-password}

echo "Making p12 archive"
keytool -importcert \
  -alias issuing-ca \
  -file ca-01 \
  -keystore truststore.p12 \
  -storetype PKCS12 \
  -storepass "$TRUST_STORE_PASSWORD" \
  -noprompt || abort

keytool -importcert \
  -alias root-ca \
  -file ca-02 \
  -keystore truststore.p12 \
  -storetype PKCS12 \
  -storepass "$TRUST_STORE_PASSWORD" \
  -noprompt || abort

#Verify Truststore
keytool -list \
  -v \
  -keystore truststore.p12 \
  -storetype PKCS12 \
  -storepass "$TRUST_STORE_PASSWORD" || abort

mv truststore.p12 /ssl-store/truststore.p12 || abort

echo "End of script reached!"
