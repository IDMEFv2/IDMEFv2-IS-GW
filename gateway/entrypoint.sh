#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

STORE_DIR="${STORE_DIR:-/store}"
KEYSTORE="${STORE_DIR}/keystore.p12"
TRUSTSTORE="${STORE_DIR}/truststore.p12"
KEY_PASS="${SSL_KEY_STORE_PASSWORD:-password}"
TRUST_PASS="${SSL_TRUST_STORE_PASSWORD:-password}"

abort() {
    echo "${RED}ERROR${NC}: $1" >&2
    exit 1
}

# ── Wait loop ──────────────────────────────────────────────────────────────────
MAX_RETRIES="${STORE_WAIT_RETRIES:-30}"
INTERVAL="${STORE_WAIT_INTERVAL:-5}"

echo "${YELLOW}INFO${NC}: Waiting for keystore and truststore in ${STORE_DIR}..."

i=0
while [ "$i" -lt "$MAX_RETRIES" ]; do
    if [ -f "${KEYSTORE}" ] && [ -f "${TRUSTSTORE}" ]; then
        echo "${GREEN}INFO${NC}: Store files found."
        break
    fi
    echo "${YELLOW}INFO${NC}: Attempt $((i+1))/${MAX_RETRIES} — stores not ready, retrying in ${INTERVAL}s..."
    sleep "${INTERVAL}"
    i=$((i+1))
done

[ -f "${KEYSTORE}" ]   || abort "keystore.p12 not found in ${STORE_DIR} after ${MAX_RETRIES} retries"
[ -f "${TRUSTSTORE}" ] || abort "truststore.p12 not found in ${STORE_DIR} after ${MAX_RETRIES} retries"

# ── Validate keystore is a readable PKCS12 ─────────────────────────────────────
echo "${YELLOW}INFO${NC}: Validating keystore..."
openssl pkcs12 -in "${KEYSTORE}" \
    -passin pass:"${KEY_PASS}" \
    -nokeys -noout 2>/dev/null \
    || abort "keystore.p12 is invalid or password is wrong"
echo "${GREEN}INFO${NC}: keystore.p12 OK"

# ── Validate truststore is a readable PKCS12 ──────────────────────────────────
echo "${YELLOW}INFO${NC}: Validating truststore..."
openssl pkcs12 -in "${TRUSTSTORE}" \
    -passin pass:"${TRUST_PASS}" \
    -nokeys -noout 2>/dev/null \
    || abort "truststore.p12 is invalid or password is wrong"
echo "${GREEN}INFO${NC}: truststore.p12 OK"

# ── Start gateway ──────────────────────────────────────────────────────────────
echo "${GREEN}INFO${NC}: All checks passed — starting gateway..."
exec /s4sgateway --spring.config.location=/application.properties