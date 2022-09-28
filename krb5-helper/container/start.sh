#!/bin/bash

HOSTNAME=`hostname --fqdn`
if ! [ -f /krb5-conf/krb5.conf ]
then
	cp /etc/krb5.conf /krb5-conf/krb5.conf
fi

if ! [i "x$ADD_PRINC" == "x" ]
then
	kadmin -p root/admin -w redhat123 add_principal -randkey $ADD_PRINC
	kadmin -p root/admin -w redhat123 ktadd -k /krb5-conf/krb5.keytab $ADD_PRINC
fi

