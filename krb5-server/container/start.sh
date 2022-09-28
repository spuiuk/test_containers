#!/bin/bash

if ! [ -f /var/kerberos/krb5kdc/principal ]
then
	/usr/sbin/kdb5_util create -s -P redhat123
	/usr/sbin/kadmin.local -q "add_principal -pw redhat123 root/admin"
fi

cp /krb5-conf/kadm5.acl /var/kerberos/krb5kdc/
cp /krb5-conf/kdc.conf /var/kerberos/krb5kdc/
/usr/sbin/kadmind
exec /usr/sbin/krb5kdc -n -P /var/run/krb5kdc.pid
