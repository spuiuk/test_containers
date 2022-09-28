FROM izdock/nfs-ganesha

RUN apt update
RUN apt install -y krb5-user --assume-yes

RUN rm -f /etc/krb5.conf /etc/krb5.keytab
RUN ln -s /krb5-conf/krb5.conf /etc/krb5.conf
RUN ln -s /krb5-conf/krb5.keytab /etc/krb5.keytab

COPY entrypoint-hooks.sh /entrypoint-hooks.sh
RUN chmod +x /entrypoint-hooks.sh
