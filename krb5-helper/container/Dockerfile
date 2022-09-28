#Version: 0.0.1
FROM quay.io/centos/centos:stream8
ENV	REFRESHED_AT 2022-09-13-1

RUN	dnf update -y
RUN	dnf install -y hostname krb5-workstation
COPY	krb5.conf /etc/krb5.conf
COPY	start.sh /start.sh
RUN	chmod +x /start.sh
ENTRYPOINT [ "/start.sh" ]
