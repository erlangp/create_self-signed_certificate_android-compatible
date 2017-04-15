:: ----------------------------
:: Create Self-Signed Certificate (Android compatible)
::
:: ErlangParasu 2017-04-15
:: ----------------------------
:: Tags:
::
:: server, self-signed, certificate, android, openssl, key, crt, v3_ca, csr, pem, der, x509, windows
:: ----------------------------
:: Ref:
::
:: self-signed certificate install claims success, but android acts as if cert isn't there
:: https://android.stackexchange.com/questions/61540/self-signed-certificate-install-claims-success-but-android-acts-as-if-cert-isn/70123#70123
::
:: Convert .pem to .crt and .key
:: https://stackoverflow.com/questions/13732826/convert-pem-to-crt-and-key/14484363#14484363
::
:: DER vs. CRT vs. CER vs. PEM Certificates and How To Convert Them
:: https://support.ssl.com/Knowledgebase/Article/View/19/0/der-vs-crt-vs-cer-vs-pem-certificates-and-how-to-convert-them
:: ----------------------------

:: Start...

:: 1
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout server.key -out server.crt -reqexts v3_req -extensions v3_ca

:: 2
openssl req -new -sha256 -key server.key -out server.csr

:: ~

:: 3
openssl genrsa -out rootCA.key 4096

:: 4
openssl req -x509 -new -nodes -key rootCA.key -days 3650 -out rootCA.pem

:: 5
openssl x509 -outform der -in rootCA.pem -out rootCA.crt

:: ~

:: 6
openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.signed.crt -days 3649

:: 7
openssl x509 -in server.signed.crt -outform der -out server.der.signed.crt

:: Finish.
