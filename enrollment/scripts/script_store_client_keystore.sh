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
KEY_STORE_PASSWORD="${KEY_STORE_PASSWORD:-password}"

[ -z "${PKI_DOMAIN}" ] && abort "PKI_DOMAIN is not set, cannot send CSR"

ENROLL_ENDPOINT="${ENROLL_ENDPOINT#/}" # Normalize: strip leading slash to avoid double //
ENROLL_URL="https://${PKI_DOMAIN}/${ENROLL_ENDPOINT}"
echo -e "${BLUE}INFO${NC}: Enrolment endpoint: ${ENROLL_URL}"

# Build optional curl headers from ENV
build_curl_opts() {
    local opts=()
    opts+=(-H "Content-Type: application/pkcs10")
    [ -n "${ENROL_TOKEN}" ] && opts+=(-H "Authorization: Bearer ${ENROL_TOKEN}")
    echo "${opts[@]}"
}

# Send CSR to EST endpoint
echo -e "${BLUE}INFO${NC}: Sending CSR to ${ENROLL_URL}"

CURL_OPTS=$(build_curl_opts)

cd /app/tmp || abort "cant access folder /app/tmp"

curl -k -s\
  ${CURL_OPTS} \
  --data-binary @client.csr.b64 \
  $ENROLL_URL \
  > client.cert.p7b.b64 || abort "Cannot retreive CERT"
ls
echo -e "${GREEN}Received the following reply from CA${NC}"
cat client.cert.p7b.b64 || abort

grep -qF "Request Pending - Retry Later" client.cert.p7b.b64 \
  && { echo -e "${YELLOW}Still waiting for CA approval!${NC}" ; exit 1; }

echo "Decoding b64"
base64 -d client.cert.p7b.b64 > client.cert.p7b || abort "cant b64 decode"

echo "Transforming p7b to pem"
openssl pkcs7 -inform DER \
  -in client.cert.p7b \
  -print_certs \
  -out client.cert.pem || abort

cat client.cert.pem || abort

echo "Creating p12 archive"
openssl pkcs12 -export \
  -inkey ../key/client.key \
  -in client.cert.pem \
  -out client.p12 \
  -name 1 \
  -passout pass:"${KEY_STORE_PASSWORD}" || abort

echo "Storing p12 archive at archives/keystore.p12"
mv client.p12 /ssl-store/keystore.p12 || abort

echo "Enrollment ready!"
echo "End of script reached!"
exit 0