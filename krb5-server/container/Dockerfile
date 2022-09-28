#Version: 0.0.1
FROM quay.io/centos/centos:stream8
ENV	REFRESHED_AT 2022-09-13-1

RUN	dnf update -y
RUN	dnf install -y krb5-server
RUN	mkdir /krb5-conf
RUN	rm /etc/krb5.conf; ln -s /krb5-conf/krb5.conf /etc/krb5.conf
COPY	start.sh /start.sh
RUN	chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]
