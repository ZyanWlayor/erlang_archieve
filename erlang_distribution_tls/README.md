# Using TLS for Erlang Distribution

*The following command runs in the bash/git environment*

*before run command,you should modify  file path in**
*.conf*

*under Erlang/OTP 24 [erts-12.1.5]*

>https://stackoverflow.com/questions/21297139/how-do-you-sign-a-certificate-signing-request-with-your-certification-authority/21340898#21340898
## Generate a self-signed signing certificate(for CA usage) at ca/

`cd ca/`

`openssl req -x509 -config openssl-ca.cnf -newkey rsa:4096 -sha256 -nodes -out cacert.pem -outform PEM`

You can dump the certificate with the following.

`openssl x509 -in cacert.pem -text -noout`

And test its purpose with the following

`openssl x509 -purpose -in cacert.pem -inform PEM`

touch index.txt and serial.txt:

`touch index.txt`

`echo '01' > serial.txt`

## Generate a certificate request at [name]_cert/
`cd [name]`

`openssl req -config openssl_[name].cnf -newkey rsa:2048 -sha256 -nodes -out servercert.csr -outform PEM`

## Generate a signed certificate

`cd [name]`

`openssl ca -config openssl-ca.cnf -policy signing_policy -extensions signing_req -out servercert.pem -infiles servercert.csr`

## Prepare erlang environment 
>https://www.erlang.org/doc/apps/ssl/ssl_distribution.html#building-boot-scripts-including-the-ssl-application

and ,compile ssl_verify module to skip hostname_check fail by:

`erl -make`

## Test TLS connect

`cd .`

`werl +pc unicode -name flagger -boot start_ssl -proto_dist inet_tls -ssl_dist_optfile ./flagger.conf`

`werl +pc unicode -name seaman -boot start_ssl -proto_dist inet_tls -ssl_dist_optfile ./seaman.conf`

the  on flagger's prompt:

`net_adm:ping('seaman@flagship.lan').`

`nodes().`

***

*.cnf contains important setting for ssl verfication,about Common name and alternate_names sections