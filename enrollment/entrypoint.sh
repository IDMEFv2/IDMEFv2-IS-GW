#!/usr/bin/env bash

set -e
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
GRAY='\e[90m'
NC='\e[0m'  # No Color

abort() {
    echo -e "${RED}ERROR${NC}: $1" >&2
    exit 1
}

if [ -f "/ssl-store/truststore.p12" ]; then
    echo -e "${GREEN}Truststore found!${NC} Not creating new ones."
else
    echo -e "${YELLOW}Truststore p12-archive missing.${NC}"
    bash ./script_store_ca_truststore.sh || abort "script_store_ca_truststore.sh"
fi

if [ -f "/ssl-store/keystore.p12" ]; then
    echo -e "${GREEN}Keystore found!${NC} Not creating new ones."
else
    echo -e "${YELLOW}Keystore p12-archive missing!${NC}"
    if [ -f "/app/key/client.key" ]; then
        echo -e "${GREEN}Key material found!${NC} Not creating new ones."
    else
        echo -e "${YELLOW}Key material not found!${NC}"
        echo "Creating new key and CSR."
        bash ./script_create_csr.sh || abort "script_create_csr.sh"
        bash ./script_send_csr.sh || abort "script_send_csr.sh"
        echo -e "${GREEN}CSR was registered at CA, waiting for approval from CA!${NC}"
    fi

    echo "Attempting to store p12 keystore with certificate"
    # default value if not set
    REPEATS=${REPEATS:-1}
    echo "Running $REPEATS times with each $SECONDS seconds"
    for ((i=1; i<=REPEATS; i++)); do
      echo "Iteration $i"
      bash ./script_store_client_keystore.sh $PKI_DOMAIN \
        && { echo -e "${GREEN}Enrollment finished!${NC}" ; exit 0; }
      sleep ${SECONDS}
    done
    echo -e "${YELLOW}Enrollment not finished! - Giving up for now!${NC}"
    exit 1
fi

