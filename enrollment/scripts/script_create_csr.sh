RED='\e[31m'
GREEN='\e[32m'
NC='\e[0m'

abort() {
    echo -e "${RED}ERROR${NC}: $1" >&2
    exit 1
}

[ -z "${GATEWAY_DOMAIN}" ] && abort "GATEWAY_DOMAIN is not set, cannot generate CSR"

# Build dynamic CSR subject from ENV
build_subject() {
    local subj="/CN=${GATEWAY_DOMAIN}"                              # Gateway Name
    [ -n "${GATEWAY_OU}" ] && subj="${subj}/OU=${GATEWAY_OU}"       # Gateway ID
    [ -n "${GATEWAY_O}"  ] && subj="${subj}/O=${GATEWAY_O}"         # Organization
    [ -n "${GATEWAY_L}"  ] && subj="${subj}/L=${GATEWAY_L}"         # Country

    echo "${subj}"
}

SUBJECT=$(build_subject)

# Generate key and CSR
cd /app/tmp || abort "Cannot access /app/tmp"

echo -e "${GREEN}INFO${NC}: Creating key and CSR for gateway domain: ${GATEWAY_DOMAIN}"
echo -e "${GREEN}INFO${NC}: Subject: ${SUBJECT}"

openssl req \
    -keyout client.key \
    -subj   "${SUBJECT}" \
    -nodes \
    -new -newkey rsa:3072 \
    -outform der -out - \
    | base64 > client.csr.b64 \
    || abort "Cannot create key and CSR"

mv client.key ../key/client.key || abort "Cannot move client.key to key folder"

echo -e "${GREEN}INFO${NC}: Done."