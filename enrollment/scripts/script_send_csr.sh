#!/usr/bin/env bash

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
NC='\e[0m'

abort() {
    echo -e "${RED}ERROR${NC}: $1" >&2
    exit 1
}

PKI_DOMAIN="${PKI_DOMAIN:-pki.safe4soc.cosypoc.fr}"
ENROLL_ENDPOINT="${ENROLL_ENDPOINT:-/.well-known/est/simpleenroll}"
CACERTS_ENDPOINT="${CACERTS_ENDPOINT:-/.well-known/est/cacerts}"

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

curl -k -v \
    ${CURL_OPTS} \
    --data-binary "@/app/tmp/client.csr.b64" \
    "${ENROLL_URL}" \
    || abort "Cannot send CSR"

echo -e "${GREEN}INFO${NC}: Done."