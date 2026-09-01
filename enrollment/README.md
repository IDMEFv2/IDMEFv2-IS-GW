# Onboarding Container Infos

This docker container has the following purposes:
- Check a given endpoint for CA certificates and store them as truststore.p12
- Create local public and private key pair
- Create a corresponding certificate signing request (csr)
- Send it to the configurable endpoint (OpenXPKI needs to approve either manually or automatically)
- Store the key material as {domain}.keystore.p12

## Docker build instructions
```bash
docker build -t safe4soc-enrollment .
```
Run in command line
```bash
docker run --rm \
-v $(pwd)/data:/data \
safe4soc-enrollment
```

Build the docker enrollment container.
```bash
docker build -t safe4soc-enrollment .
```

Launch automatic enrollment and gateway-sender afterward.
```bash
docker compose -f docker-compose-enrollment.yaml up gateway-sender safe4soc-enrollment    
```

Expected output:
```bash
docker compose -f docker-compose-enrollment.yaml up gateway-sender safe4soc-enrollment                                          ─╯
Attaching to gateway-sender-1, safe4soc-enrollment-1
safe4soc-enrollment-1  | Checking if p12 truststore with CA info can be found.
safe4soc-enrollment-1  | Truststore p12-archive missing.
safe4soc-enrollment-1  | Attempting retrieval from pki.safe4soc.cosypoc.fr
safe4soc-enrollment-1  | Storing CA Certs from: pki.safe4soc.cosypoc.fr
Container safe4soc-gateway-safe4soc-enrollment-1 Waiting
safe4soc-enrollment-1  | Printing received certs:
safe4soc-enrollment-1  | subject=CN=SAFE4SOC Issuing CA 20260617
safe4soc-enrollment-1  | issuer=C=FR, O=SAFE4SOC, OU=PKI, CN=SAFE4SOC Root CA 20260617
safe4soc-enrollment-1  | -----BEGIN CERTIFICATE-----
safe4soc-enrollment-1  | MIICHTCCAaSgAwIBAgIUHJlb2q0oBpsinqE/lJ/aD0QPXSUwCgYIKoZIzj0EAwIw
safe4soc-enrollment-1  | UjELMAkGA1UEBhMCRlIxETAPBgNVBAoTCFNBRkU0U09DMQwwCgYDVQQLEwNQS0kx
safe4soc-enrollment-1  | IjAgBgNVBAMTGVNBRkU0U09DIFJvb3QgQ0EgMjAyNjA2MTcwHhcNMjYwNjE3MTcw
safe4soc-enrollment-1  | NjQ5WhcNMzYwNjEzMTcwNjQ5WjAnMSUwIwYDVQQDDBxTQUZFNFNPQyBJc3N1aW5n
safe4soc-enrollment-1  | IENBIDIwMjYwNjE3MHYwEAYHKoZIzj0CAQYFK4EEACIDYgAE4hPJIgaNFhX57Nmg
safe4soc-enrollment-1  | 44K2xRf1la1Mxoxyr5JYOPEvMGkAZ1qv+V0AEC32aZ1Akj0D9NXw8oSv/vdpm9eG
safe4soc-enrollment-1  | cyqlZsgsHR8IDxjvyo69vzDl91T2suhw01E79REBsmuglafNo2YwZDAdBgNVHQ4E
safe4soc-enrollment-1  | FgQUbAhobWP0C1W0qswXhnQWQU2cBf4wHwYDVR0jBBgwFoAUBMniZyIZywrUPdy7
safe4soc-enrollment-1  | uHlN3E80MP8wEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAQYwCgYI
safe4soc-enrollment-1  | KoZIzj0EAwIDZwAwZAIweQX91R47EJvHcPGa1aJJzCgBvIta7+i4xeQTxDi13dLF
safe4soc-enrollment-1  | 1Ns1eDj73oTmTSIRBx+SAjBICoN7pEGY+dpQ8i4WiJ8LBEI3u4DxdOykndlNBvXU
safe4soc-enrollment-1  | RFRUUkbIwXrd6z4wSlW1l2o=
safe4soc-enrollment-1  | -----END CERTIFICATE-----
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | subject=C=FR, O=SAFE4SOC, OU=PKI, CN=SAFE4SOC Root CA 20260617
safe4soc-enrollment-1  | issuer=C=FR, O=SAFE4SOC, OU=PKI, CN=SAFE4SOC Root CA 20260617
safe4soc-enrollment-1  | -----BEGIN CERTIFICATE-----
safe4soc-enrollment-1  | MIICRTCCAcygAwIBAgIUWx0L67B7yhIWDuCzSgeDXCEXCHYwCgYIKoZIzj0EAwIw
safe4soc-enrollment-1  | UjELMAkGA1UEBhMCRlIxETAPBgNVBAoTCFNBRkU0U09DMQwwCgYDVQQLEwNQS0kx
safe4soc-enrollment-1  | IjAgBgNVBAMTGVNBRkU0U09DIFJvb3QgQ0EgMjAyNjA2MTcwHhcNMjYwNjE3MTcw
safe4soc-enrollment-1  | NjQ5WhcNMzYwNjE0MTcwNjQ5WjBSMQswCQYDVQQGEwJGUjERMA8GA1UEChMIU0FG
safe4soc-enrollment-1  | RTRTT0MxDDAKBgNVBAsTA1BLSTEiMCAGA1UEAxMZU0FGRTRTT0MgUm9vdCBDQSAy
safe4soc-enrollment-1  | MDI2MDYxNzB2MBAGByqGSM49AgEGBSuBBAAiA2IABI//UZBz0Gyhq6GTr+a4kmJc
safe4soc-enrollment-1  | nv75lQGcc4bCxh+2bTZMSd6K5IA+0LUKyQ7Ahn51w0ohw+Dpg51lVH5hc4IWYd/V
safe4soc-enrollment-1  | E+qn2yQEWnYO/ptiKcF1MPnb0rcES0J3kn14f87KYqNjMGEwHQYDVR0OBBYEFATJ
safe4soc-enrollment-1  | 4mciGcsK1D3cu7h5TdxPNDD/MB8GA1UdIwQYMBaAFATJ4mciGcsK1D3cu7h5TdxP
safe4soc-enrollment-1  | NDD/MA8GA1UdEwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgEGMAoGCCqGSM49BAMC
safe4soc-enrollment-1  | A2cAMGQCMDSM5VDYbgMqqxwiO03mV+GeFLiEJvmE27dJOZea9sq887CmPN4SOxfU
safe4soc-enrollment-1  | BhyVJrFJ9gIwW8eXns5UrAeOq4gdSt1xWAQeWQXan0nmX5GuzY3/rCfQpe427Vsz
safe4soc-enrollment-1  | kep3GbhmUR7+
safe4soc-enrollment-1  | -----END CERTIFICATE-----
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | Splitting received certs:
safe4soc-enrollment-1  | Inspecting Truststore
safe4soc-enrollment-1  | subject=CN=SAFE4SOC Issuing CA 20260617
safe4soc-enrollment-1  | issuer=C=FR, O=SAFE4SOC, OU=PKI, CN=SAFE4SOC Root CA 20260617
safe4soc-enrollment-1  | subject=C=FR, O=SAFE4SOC, OU=PKI, CN=SAFE4SOC Root CA 20260617
safe4soc-enrollment-1  | issuer=C=FR, O=SAFE4SOC, OU=PKI, CN=SAFE4SOC Root CA 20260617
safe4soc-enrollment-1  | Making p12 archive
safe4soc-enrollment-1  | Certificate was added to keystore
safe4soc-enrollment-1  | Certificate was added to keystore
safe4soc-enrollment-1  | Keystore type: PKCS12
safe4soc-enrollment-1  | Keystore provider: SUN
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | Your keystore contains 2 entries
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | Alias name: issuing-ca
safe4soc-enrollment-1  | Creation date: Jun 23, 2026
safe4soc-enrollment-1  | Entry type: trustedCertEntry
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | Owner: CN=SAFE4SOC Issuing CA 20260617
safe4soc-enrollment-1  | Issuer: CN=SAFE4SOC Root CA 20260617, OU=PKI, O=SAFE4SOC, C=FR
safe4soc-enrollment-1  | Serial number: 1c995bdaad28069b229ea13f949fda0f440f5d25
safe4soc-enrollment-1  | Valid from: Wed Jun 17 17:06:49 GMT 2026 until: Fri Jun 13 17:06:49 GMT 2036
safe4soc-enrollment-1  | Certificate fingerprints:
safe4soc-enrollment-1  |         SHA1: 52:96:C2:A6:F1:C1:7D:EC:41:21:5E:06:2B:96:A9:5E:15:6F:37:CB
safe4soc-enrollment-1  |         SHA256: ED:5A:F3:A0:52:54:5D:E3:FA:01:03:2D:F2:53:A0:5C:AC:D9:D1:01:E9:82:B9:98:71:A7:72:C1:70:92:B8:9C
safe4soc-enrollment-1  | Signature algorithm name: SHA256withECDSA
safe4soc-enrollment-1  | Subject Public Key Algorithm: 384-bit EC (secp384r1) key
safe4soc-enrollment-1  | Version: 3
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | Extensions:
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | #1: ObjectId: 2.5.29.35 Criticality=false
safe4soc-enrollment-1  | AuthorityKeyIdentifier [
safe4soc-enrollment-1  | KeyIdentifier [
safe4soc-enrollment-1  | 0000: 04 C9 E2 67 22 19 CB 0A   D4 3D DC BB B8 79 4D DC  ...g"....=...yM.
safe4soc-enrollment-1  | 0010: 4F 34 30 FF                                        O40.
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | #2: ObjectId: 2.5.29.19 Criticality=true
safe4soc-enrollment-1  | BasicConstraints:[
safe4soc-enrollment-1  |   CA:true
safe4soc-enrollment-1  |   PathLen:0
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | #3: ObjectId: 2.5.29.15 Criticality=true
safe4soc-enrollment-1  | KeyUsage [
safe4soc-enrollment-1  |   Key_CertSign
safe4soc-enrollment-1  |   Crl_Sign
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | #4: ObjectId: 2.5.29.14 Criticality=false
safe4soc-enrollment-1  | SubjectKeyIdentifier [
safe4soc-enrollment-1  | KeyIdentifier [
safe4soc-enrollment-1  | 0000: 6C 08 68 6D 63 F4 0B 55   B4 AA CC 17 86 74 16 41  l.hmc..U.....t.A
safe4soc-enrollment-1  | 0010: 4D 9C 05 FE                                        M...
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  |
safe4soc-enrollment-1  |
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | *******************************************
safe4soc-enrollment-1  | *******************************************
safe4soc-enrollment-1  |
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | Alias name: root-ca
safe4soc-enrollment-1  | Creation date: Jun 23, 2026
safe4soc-enrollment-1  | Entry type: trustedCertEntry
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | Owner: CN=SAFE4SOC Root CA 20260617, OU=PKI, O=SAFE4SOC, C=FR
safe4soc-enrollment-1  | Issuer: CN=SAFE4SOC Root CA 20260617, OU=PKI, O=SAFE4SOC, C=FR
safe4soc-enrollment-1  | Serial number: 5b1d0bebb07bca12160ee0b34a07835c21170876
safe4soc-enrollment-1  | Valid from: Wed Jun 17 17:06:49 GMT 2026 until: Sat Jun 14 17:06:49 GMT 2036
safe4soc-enrollment-1  | Certificate fingerprints:
safe4soc-enrollment-1  |         SHA1: 0A:9E:66:18:C4:DD:2E:EE:AA:89:6C:FE:1F:F5:2A:43:65:75:CC:8E
safe4soc-enrollment-1  |         SHA256: E9:D2:53:E1:EA:A4:B9:8D:74:CF:78:60:8A:34:3C:E7:51:45:B3:DF:0F:D9:71:68:B9:17:E8:66:1C:E8:E9:AB
safe4soc-enrollment-1  | Signature algorithm name: SHA256withECDSA
safe4soc-enrollment-1  | Subject Public Key Algorithm: 384-bit EC (secp384r1) key
safe4soc-enrollment-1  | Version: 3
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | Extensions:
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | #1: ObjectId: 2.5.29.35 Criticality=false
safe4soc-enrollment-1  | AuthorityKeyIdentifier [
safe4soc-enrollment-1  | KeyIdentifier [
safe4soc-enrollment-1  | 0000: 04 C9 E2 67 22 19 CB 0A   D4 3D DC BB B8 79 4D DC  ...g"....=...yM.
safe4soc-enrollment-1  | 0010: 4F 34 30 FF                                        O40.
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | #2: ObjectId: 2.5.29.19 Criticality=true
safe4soc-enrollment-1  | BasicConstraints:[
safe4soc-enrollment-1  |   CA:true
safe4soc-enrollment-1  |   PathLen: no limit
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | #3: ObjectId: 2.5.29.15 Criticality=true
safe4soc-enrollment-1  | KeyUsage [
safe4soc-enrollment-1  |   Key_CertSign
safe4soc-enrollment-1  |   Crl_Sign
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | #4: ObjectId: 2.5.29.14 Criticality=false
safe4soc-enrollment-1  | SubjectKeyIdentifier [
safe4soc-enrollment-1  | KeyIdentifier [
safe4soc-enrollment-1  | 0000: 04 C9 E2 67 22 19 CB 0A   D4 3D DC BB B8 79 4D DC  ...g"....=...yM.
safe4soc-enrollment-1  | 0010: 4F 34 30 FF                                        O40.
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  | ]
safe4soc-enrollment-1  |
safe4soc-enrollment-1  |
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | *******************************************
safe4soc-enrollment-1  | *******************************************
safe4soc-enrollment-1  |
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | End of script reached!
safe4soc-enrollment-1  | Checking if p12 keystore with certificate can be found.
safe4soc-enrollment-1  | Keystore p12-archive missing!
safe4soc-enrollment-1  | Checking if client.key was created
safe4soc-enrollment-1  | Key material not found!
safe4soc-enrollment-1  | Creating new key and CSR.
safe4soc-enrollment-1  | Creating key and csr for gateway domain: gateway-sender
safe4soc-enrollment-1  | ..+...+...+....+...+...............++++++++++++++++++++++++++++++++++++++++++*...+..+.......+..++++++++++++++++++++++++++++++++++++++++++*.......+...................+...+...........+..........+.....+....+++++
safe4soc-enrollment-1  | ..+....+............+......+.....+.......+...+...+..+....+...+......+......++++++++++++++++++++++++++++++++++++++++++*.+..........+...+..+...+......+.+.........+........+.+..+.......++++++++++++++++++++++++++++++++++++++++++*.........+...........+............+.........+...+.+...............+.....+....+..+...+.............+............+...+..............+......+....+...+...+...+..+.............+.....+..........+.........+...........+......+...............+.+.........+...+..+..........+......+..............+.....................+...+.+........+..........+.................+.+...+..+.............+......+......+..+......+..........+...............+...........+......+..............................+.......+.....+.+.........+...+.....+..........+........+.+..................+..+.+..+..........+......+..............+............+....+.....+.+...+.....+...+.......+......+......+........+.........................+..+................+.........+...+.....+.+.....+.........+...............+......+.......+.....+.........+.............+......+............+..+...+......................+.................+..........+.........+.....+.+...+..+...+...+...+......+....+.........+...+..............+....+..+....+......+..+.+...........................+..+.......+..............+.+......+...+..........................+......+..........+...+...........+.........+..........+..+...+.......+.....+....+......+...+...........+.............+......+.........+...+.........+...+...+.........+...........+...+.+.....+..........+.....+.+.....+............+.+...............+.....+................+...+.................+...+......+....+..................+........+....+......+..............+...+...+.+..............+.+...+...+..................+.....+.+...+.................+.............+.....+..........+....................+.+..+..........+.........+......+...+.........+...+..............+.........+......+...+..........+.....+.......+........+...........................+....+.........+..+.........+.......+...+..+...................+...+........+...+.+...+.....+...+..........+........+.........+.+..+.......+..+.+........+.+...........+...+..........+..............................+......+..............................+......+..+...+.......+..+....+.........+..+.............+..+....+..............+..........+......+...............+......+.....+.........+....+..+...................+..............+...+...+.+........+.+......+.....+.+.........+......+...+..+...+.+...........+..................+.......+...+.................+..........+...+.....+.........+.+.....+.+.....+.............+..+...+...+...+....+...........+............+.......+......+..+.......+...+........+....+..+....+......+......+.........+........+.......+.........................................+.......+...........+.....................+...+.+..+....+...+...+.....+............................+......+...+..+...+.+..+...+.+...................................+....+.....+......+.+..+...+...+.+.....+.............+.....................+.................+....+........+.+.....+.......+........+.+.....+...+......+......+...............+...+...+....+...+.....+.+..+..........+..............................+..............+...+...+...+......+....+...............................................+....+....................+.+........................+...+...+...+.........+............+...........+++++
safe4soc-enrollment-1  | -----
safe4soc-enrollment-1  | End of script reached!
safe4soc-enrollment-1  | Sending CSR to pki.safe4soc.cosypoc.fr
safe4soc-enrollment-1  |   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
safe4soc-enrollment-1  |                                  Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0* Host pki.safe4soc.cosypoc.fr:443 was resolved.
safe4soc-enrollment-1  | * IPv6: (none)
safe4soc-enrollment-1  | * IPv4: 84.240.132.96
safe4soc-enrollment-1  | *   Trying 84.240.132.96:443...
safe4soc-enrollment-1  | * ALPN: curl offers h2,http/1.1
safe4soc-enrollment-1  | } [5 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (OUT), TLS handshake, Client hello (1):
safe4soc-enrollment-1  | } [1569 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (IN), TLS handshake, Server hello (2):
safe4soc-enrollment-1  | { [1210 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (IN), TLS change cipher, Change cipher spec (1):
safe4soc-enrollment-1  | { [1 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (IN), TLS handshake, Encrypted Extensions (8):
safe4soc-enrollment-1  | { [19 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (IN), TLS handshake, Certificate (11):
safe4soc-enrollment-1  | { [4091 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (IN), TLS handshake, CERT verify (15):
safe4soc-enrollment-1  | { [264 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (IN), TLS handshake, Finished (20):
safe4soc-enrollment-1  | { [52 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (OUT), TLS change cipher, Change cipher spec (1):
safe4soc-enrollment-1  | } [1 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (OUT), TLS handshake, Finished (20):
safe4soc-enrollment-1  | } [52 bytes data]
safe4soc-enrollment-1  | * SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384 / X25519MLKEM768 / RSASSA-PSS
safe4soc-enrollment-1  | * ALPN: server accepted h2
safe4soc-enrollment-1  | * Server certificate:
safe4soc-enrollment-1  | *  subject: CN=pki.safe4soc.cosypoc.fr
safe4soc-enrollment-1  | *  start date: Jun 17 13:45:28 2026 GMT
safe4soc-enrollment-1  | *  expire date: Sep 15 13:45:27 2026 GMT
safe4soc-enrollment-1  | *  issuer: C=US; O=Let's Encrypt; CN=YR2
safe4soc-enrollment-1  | *  SSL certificate verify result: unable to get local issuer certificate (20), continuing anyway.
safe4soc-enrollment-1  | *   Certificate level 0: Public key type RSA (2048/112 Bits/secBits), signed using sha256WithRSAEncryption
safe4soc-enrollment-1  | *   Certificate level 1: Public key type RSA (2048/112 Bits/secBits), signed using sha256WithRSAEncryption
safe4soc-enrollment-1  | *   Certificate level 2: Public key type RSA (4096/152 Bits/secBits), signed using sha256WithRSAEncryption
safe4soc-enrollment-1  | * Connected to pki.safe4soc.cosypoc.fr (84.240.132.96) port 443
safe4soc-enrollment-1  | * using HTTP/2
safe4soc-enrollment-1  | * [HTTP/2] [1] OPENED stream for https://pki.safe4soc.cosypoc.fr/.well-known/est/simpleenroll
safe4soc-enrollment-1  | * [HTTP/2] [1] [:method: POST]
safe4soc-enrollment-1  | * [HTTP/2] [1] [:scheme: https]
safe4soc-enrollment-1  | * [HTTP/2] [1] [:authority: pki.safe4soc.cosypoc.fr]
safe4soc-enrollment-1  | * [HTTP/2] [1] [:path: /.well-known/est/simpleenroll]
safe4soc-enrollment-1  | * [HTTP/2] [1] [user-agent: curl/8.14.1]
safe4soc-enrollment-1  | * [HTTP/2] [1] [accept: */*]
safe4soc-enrollment-1  | * [HTTP/2] [1] [content-type: application/pkcs10]
safe4soc-enrollment-1  | * [HTTP/2] [1] [content-length: 1156]
safe4soc-enrollment-1  | } [5 bytes data]
safe4soc-enrollment-1  | > POST /.well-known/est/simpleenroll HTTP/2
safe4soc-enrollment-1  | > Host: pki.safe4soc.cosypoc.fr
safe4soc-enrollment-1  | > User-Agent: curl/8.14.1
safe4soc-enrollment-1  | > Accept: */*
safe4soc-enrollment-1  | > Content-Type: application/pkcs10
safe4soc-enrollment-1  | > Content-Length: 1156
safe4soc-enrollment-1  | >
safe4soc-enrollment-1  | } [1156 bytes data]
safe4soc-enrollment-1  | * upload completely sent off: 1156 bytes
safe4soc-enrollment-1  | { [5 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
safe4soc-enrollment-1  | { [57 bytes data]
safe4soc-enrollment-1  | * TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
safe4soc-enrollment-1  | { [57 bytes data]
safe4soc-enrollment-1  | Request Pending - Retry Later (d567fb14e2e263f16032f7bca7e30705f0805f8c)
100  1156    0     0  100  1156      0    945  0:00:01  0:00:01 --:--:--   945< HTTP/2 202
safe4soc-enrollment-1  | < date: Tue, 23 Jun 2026 02:26:17 GMT
safe4soc-enrollment-1  | < content-type: application/pkcs7-mime; smime-type=certs-only
safe4soc-enrollment-1  | < content-length: 73
safe4soc-enrollment-1  | < retry-after: 300
safe4soc-enrollment-1  | < x-openxpki-error: =?UTF-8?B?UmVxdWVzdCB3YXMgbm90IGFwcHJvdmVk?=
safe4soc-enrollment-1  | < x-openxpki-transaction-id: d567fb14e2e263f16032f7bca7e30705f0805f8c
safe4soc-enrollment-1  | < x-openxpki-workflow-id: 6399
safe4soc-enrollment-1  | < strict-transport-security: max-age=31536000; includeSubDomains
safe4soc-enrollment-1  | <
safe4soc-enrollment-1  | { [73 bytes data]
100  1229  100    73  100  1156     37    588  0:00:01  0:00:01 --:--:--   626
safe4soc-enrollment-1  | * Connection #0 to host pki.safe4soc.cosypoc.fr left intact
safe4soc-enrollment-1  | End of script reached!
safe4soc-enrollment-1  | CSR was registered at CA, waiting for approval from CA!
safe4soc-enrollment-1  | Attempting to store p12 keystore with certificate
safe4soc-enrollment-1  | Running 10 times
safe4soc-enrollment-1  | Iteration 1
safe4soc-enrollment-1  | Storing client keystore from: pki.safe4soc.cosypoc.fr
safe4soc-enrollment-1  | Received the following reply from CA
safe4soc-enrollment-1  | Request Pending - Retry Later (d567fb14e2e263f16032f7bca7e30705f0805f8c)
safe4soc-enrollment-1  | Still waiting for CA approval!
safe4soc-enrollment-1  | Iteration 2
safe4soc-enrollment-1  | Storing client keystore from: pki.safe4soc.cosypoc.fr
safe4soc-enrollment-1  | Received the following reply from CA
safe4soc-enrollment-1  | Request Pending - Retry Later (d567fb14e2e263f16032f7bca7e30705f0805f8c)
safe4soc-enrollment-1  | Still waiting for CA approval!
safe4soc-enrollment-1  | Iteration 3
safe4soc-enrollment-1  | Storing client keystore from: pki.safe4soc.cosypoc.fr
safe4soc-enrollment-1  | Received the following reply from CA
safe4soc-enrollment-1  | MIIFIgYJKoZIhvcNAQcCoIIFEzCCBQ8CAQExADALBgkqhkiG9w0BBwGgggT3MIIE8zCCBHmgAwIBAgIKCf+Ykq8sGwL//DAKBggqhkjOPQQDAjAnMSUwIwYDVQQDDBxTQUZFNFNPQyBJc3N1aW5nIENBIDIwMjYwNjE3MB4XDTI2MDYyMzAyMjczMFoXDTI3MDYyMzAyMjczMFowYzESMBAGCgmSJomT8ixkARkWAmV1MRgwFgYKCZImiZPyLGQBGRYIU0FGRTRTT0MxGjAYBgoJkiaJk/IsZAEZFgpPTkJPQVJESU5HMRcwFQYDVQQDDA5nYXRld2F5LXNlbmRlcjCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoCggGBAJ9B/9xF/4FIlC5h/14XRJRLEU8QBFumUn2yGxBWG4BtFeO75OzjNKOAgIYm4NJ6t3cL+3h8O9D8ohoZLjxoCyQHSYj0VdGOkprCc+gfYBElngN/6gTR/njVXkD4K6VkXpZdNnzlkla4lRBvaKeZIqY9QU3psKWRfAjmKga41Fy7fGDa1BOBcwvywUBP0c7B+C/FKOGt8+SjUY9VdvQicK6FW17deinX64aJWRk6MzmvLvV1WeYK6GubDSKTLr0v0ZrUFDEji48GeYXsc4fUZZTRxh3mK4zM9KHsIZty6kwLvjn9oMwdiZsFZw3wOiMutEAJGOlHTeqOnGKsUwfeY/prWfVoLMaiLZv+n/gBHHQe/ASpeHRomlTZwQ0ROq1seyOdBdjUrPRoU3+OAEIo5EWrX5VTSFaEQYhOkL65RAS3uoYRbzrfGm5529UXgBoEKKP16w4uViFkdNFYCQIJ3KzvwEXjSrPsLuz8KA4rs5T9WHgZZeFY/Z3F8BAXBYdRowIDAQABo4ICBDCCAgAwgYIGCCsGAQUFBwEBBHYwdDBMBggrBgEFBQcwAoZAaHR0cDovL3BraS5leGFtcGxlLmNvbS9kb3dubG9hZC9TQUZFNFNPQ19Jc3N1aW5nX0NBXzIwMjYwNjE3LmNlcjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZXhhbXBsZS5jb20vMB8GA1UdIwQYMBaAFGwIaG1j9AtVtKrMF4Z0FkFNnAX+MAwGA1UdEwEB/wQCMAAwUQYDVR0fBEowSDBGoESgQoZAaHR0cDovL3BraS5leGFtcGxlLmNvbS9kb3dubG9hZC9TQUZFNFNPQ19Jc3N1aW5nX0NBXzIwMjYwNjE3LmNybDAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwEwDgYDVR0PAQH/BAQDAgWgMIGoBgNVHSAEgaAwgZ0wgZoGAyoDBDCBkjArBggrBgEFBQcCARYfaHR0cDovL3BraS5leGFtcGxlLmNvbS9jcHMuaHRtbDArBggrBgEFBQcCARYfaHR0cDovL3BraS5leGFtcGxlLmNvbS9jcHMuaHRtbDA2BggrBgEFBQcCAjAqGihUaGlzIGlzIGEgY29tbWVudCBmb3IgcG9saWN5IG9pZCAxLjIuMy40MB0GA1UdDgQWBBQ9kpLerZCxDlDxdn87h5REfNKwsDAKBggqhkjOPQQDAgNoADBlAjAeqJXeZzVDHOMBRVyuTa4svJoos9zn+EB8ogk+Fm2FBC1bQMCv+G4JSoU5ZChfht0CMQCnAEEmxfjt6PH3ZZa3xaJPvrFY6YRQPr6CZLXbngAMAvyxdCZT0TRpBIUhtnaYGPAxAA==Decoding b64
safe4soc-enrollment-1  | Transforming p7b to pem
safe4soc-enrollment-1  | subject=DC=eu, DC=SAFE4SOC, DC=ONBOARDING, CN=gateway-sender
safe4soc-enrollment-1  | issuer=CN=SAFE4SOC Issuing CA 20260617
safe4soc-enrollment-1  | -----BEGIN CERTIFICATE-----
safe4soc-enrollment-1  | MIIE8zCCBHmgAwIBAgIKCf+Ykq8sGwL//DAKBggqhkjOPQQDAjAnMSUwIwYDVQQD
safe4soc-enrollment-1  | DBxTQUZFNFNPQyBJc3N1aW5nIENBIDIwMjYwNjE3MB4XDTI2MDYyMzAyMjczMFoX
safe4soc-enrollment-1  | DTI3MDYyMzAyMjczMFowYzESMBAGCgmSJomT8ixkARkWAmV1MRgwFgYKCZImiZPy
safe4soc-enrollment-1  | LGQBGRYIU0FGRTRTT0MxGjAYBgoJkiaJk/IsZAEZFgpPTkJPQVJESU5HMRcwFQYD
safe4soc-enrollment-1  | VQQDDA5nYXRld2F5LXNlbmRlcjCCAaIwDQYJKoZIhvcNAQEBBQADggGPADCCAYoC
safe4soc-enrollment-1  | ggGBAJ9B/9xF/4FIlC5h/14XRJRLEU8QBFumUn2yGxBWG4BtFeO75OzjNKOAgIYm
safe4soc-enrollment-1  | 4NJ6t3cL+3h8O9D8ohoZLjxoCyQHSYj0VdGOkprCc+gfYBElngN/6gTR/njVXkD4
safe4soc-enrollment-1  | K6VkXpZdNnzlkla4lRBvaKeZIqY9QU3psKWRfAjmKga41Fy7fGDa1BOBcwvywUBP
safe4soc-enrollment-1  | 0c7B+C/FKOGt8+SjUY9VdvQicK6FW17deinX64aJWRk6MzmvLvV1WeYK6GubDSKT
safe4soc-enrollment-1  | Lr0v0ZrUFDEji48GeYXsc4fUZZTRxh3mK4zM9KHsIZty6kwLvjn9oMwdiZsFZw3w
safe4soc-enrollment-1  | OiMutEAJGOlHTeqOnGKsUwfeY/prWfVoLMaiLZv+n/gBHHQe/ASpeHRomlTZwQ0R
safe4soc-enrollment-1  | Oq1seyOdBdjUrPRoU3+OAEIo5EWrX5VTSFaEQYhOkL65RAS3uoYRbzrfGm5529UX
safe4soc-enrollment-1  | gBoEKKP16w4uViFkdNFYCQIJ3KzvwEXjSrPsLuz8KA4rs5T9WHgZZeFY/Z3F8BAX
safe4soc-enrollment-1  | BYdRowIDAQABo4ICBDCCAgAwgYIGCCsGAQUFBwEBBHYwdDBMBggrBgEFBQcwAoZA
safe4soc-enrollment-1  | aHR0cDovL3BraS5leGFtcGxlLmNvbS9kb3dubG9hZC9TQUZFNFNPQ19Jc3N1aW5n
safe4soc-enrollment-1  | X0NBXzIwMjYwNjE3LmNlcjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZXhhbXBs
safe4soc-enrollment-1  | ZS5jb20vMB8GA1UdIwQYMBaAFGwIaG1j9AtVtKrMF4Z0FkFNnAX+MAwGA1UdEwEB
safe4soc-enrollment-1  | /wQCMAAwUQYDVR0fBEowSDBGoESgQoZAaHR0cDovL3BraS5leGFtcGxlLmNvbS9k
safe4soc-enrollment-1  | b3dubG9hZC9TQUZFNFNPQ19Jc3N1aW5nX0NBXzIwMjYwNjE3LmNybDAdBgNVHSUE
safe4soc-enrollment-1  | FjAUBggrBgEFBQcDAgYIKwYBBQUHAwEwDgYDVR0PAQH/BAQDAgWgMIGoBgNVHSAE
safe4soc-enrollment-1  | gaAwgZ0wgZoGAyoDBDCBkjArBggrBgEFBQcCARYfaHR0cDovL3BraS5leGFtcGxl
safe4soc-enrollment-1  | LmNvbS9jcHMuaHRtbDArBggrBgEFBQcCARYfaHR0cDovL3BraS5leGFtcGxlLmNv
safe4soc-enrollment-1  | bS9jcHMuaHRtbDA2BggrBgEFBQcCAjAqGihUaGlzIGlzIGEgY29tbWVudCBmb3Ig
safe4soc-enrollment-1  | cG9saWN5IG9pZCAxLjIuMy40MB0GA1UdDgQWBBQ9kpLerZCxDlDxdn87h5REfNKw
safe4soc-enrollment-1  | sDAKBggqhkjOPQQDAgNoADBlAjAeqJXeZzVDHOMBRVyuTa4svJoos9zn+EB8ogk+
safe4soc-enrollment-1  | Fm2FBC1bQMCv+G4JSoU5ZChfht0CMQCnAEEmxfjt6PH3ZZa3xaJPvrFY6YRQPr6C
safe4soc-enrollment-1  | ZLXbngAMAvyxdCZT0TRpBIUhtnaYGPA=
safe4soc-enrollment-1  | -----END CERTIFICATE-----
safe4soc-enrollment-1  |
safe4soc-enrollment-1  | Creating p12 archive
safe4soc-enrollment-1  | Storing p12 archive at archives/keystore.p12
safe4soc-enrollment-1  | Enrollment ready!
safe4soc-enrollment-1  | End of script reached!
safe4soc-enrollment-1  | Enrollment finished!
safe4soc-enrollment-1 exited with code 0
Container safe4soc-gateway-safe4soc-enrollment-1 Exited
gateway-sender-1       |
gateway-sender-1       |   .   ____          _            __ _ _
gateway-sender-1       |  /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
gateway-sender-1       | ( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
gateway-sender-1       |  \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
gateway-sender-1       |   '  |____| .__|_| |_|_| |_\__, | / / / /
gateway-sender-1       |  =========|_|==============|___/=/_/_/_/
gateway-sender-1       |
gateway-sender-1       |  :: Spring Boot ::                (v3.3.5)
gateway-sender-1       |
gateway-sender-1       | 2026-06-23T02:23:37.355Z  INFO 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Application         : Starting AOT-processed Application using Java 17.0.5 with PID 1 (/s4sgateway started by root in /)
gateway-sender-1       | 2026-06-23T02:23:37.355Z DEBUG 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Application         : Running with Spring Boot v3.3.5, Spring v6.1.14
gateway-sender-1       | 2026-06-23T02:23:37.355Z  INFO 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Application         : No active profile set, falling back to 1 default profile: "default"
gateway-sender-1       | 2026-06-23T02:23:37.463Z  INFO 1 --- [s4s-gateway] [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port 10080 (https)
gateway-sender-1       | 2026-06-23T02:23:37.468Z  WARN 1 --- [s4s-gateway] [           main] org.apache.tomcat.util.net.SSLUtilBase   : The JSSE TLS 1.3 implementation does not support post handshake authentication (PHA) and is therefore incompatible with optional certificate authentication
gateway-sender-1       | 2026-06-23T02:23:37.557Z  INFO 1 --- [s4s-gateway] [           main] o.a.t.util.net.NioEndpoint.certificate   : Connector [https-jsse-nio-10080], TLS virtual host [_default_], certificate type [UNDEFINED] configured from keystore [/root/.keystore] using alias [1] with trust store [null]
gateway-sender-1       | 2026-06-23T02:23:37.559Z  INFO 1 --- [s4s-gateway] [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
gateway-sender-1       | 2026-06-23T02:23:37.560Z  INFO 1 --- [s4s-gateway] [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/10.1.31]
gateway-sender-1       | 2026-06-23T02:23:37.576Z  INFO 1 --- [s4s-gateway] [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
gateway-sender-1       | 2026-06-23T02:23:37.576Z  INFO 1 --- [s4s-gateway] [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 221 ms
gateway-sender-1       | 2026-06-23T02:23:37.644Z  INFO 1 --- [s4s-gateway] [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port 10080 (https) with context path '/'
gateway-sender-1       | 2026-06-23T02:23:37.646Z  INFO 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Application         : Started Application in 0.329 seconds (process running for 0.345)
gateway-sender-1       | 2026-06-23T02:23:37.647Z  INFO 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Controller          : Loading Information Sharing Agreement and Filter settings ...
gateway-sender-1       | 2026-06-23T02:23:37.648Z  INFO 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Controller          : Loaded this ISA:{"data_usage_policies":{"use_until":"2024-12-12","use_after":"2024-09-12","share_further":"false"},"data_sender_SIEM_version":"Version 0.1","intended_use":"alert_gathering","IDMEFv2_attributes":{"attributes_to_anonymize":[],"attributes_to_neglect":[],"attributes_to_pseudonemize":[],"attributes_to_transmit":[]},"sending_mode":"","encryption_requirements":[],"authentication_requirements":[],"enrichmentConfig":{"CreateTime":"","StartTime":""},"data_sender_SIEM_brand":"Example Company A","connection_requirements":[],"filterConfig":{"CreateTime":"","Cause":"","StartTime":""},"provider_reason":"compliance"}
gateway-sender-1       | 2026-06-23T02:23:37.649Z  INFO 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Controller          : Checking given configuration for role=SENDER ...
gateway-sender-1       | 2026-06-23T02:23:37.649Z  INFO 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Controller          : Config gatewaySD=gateway-sender:10080
gateway-sender-1       | 2026-06-23T02:23:37.649Z  INFO 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Controller          : Config gatewayRC=gateway-receiver:10081
gateway-sender-1       | 2026-06-23T02:23:37.649Z  INFO 1 --- [s4s-gateway] [           main] d.f.aisec.s4sgateway.Controller          : Config relevantHeaders=[content-type, accept, user-Agent, accept-Encoding, safe4soc-receiver-hostname, safe4soc-receiver-port]
```
