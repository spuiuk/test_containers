Extends on the nfs-ganesha container from https://github.com/ugoviti/izdock-nfs-ganesha

Extended to add the Kerberos configuration for the NFS server and change debug level.

This is meant to be used with the krb5-server and the krb4-helper init containers.

This ends up creating the following NodePort
30049 -> to the nfs server

On the test client which would be a virtual machine(to use the kernel nfs client) we need to do the following
1) Follow instructions for krb5-server setup on the client to setup the kdc.conf

2) Add the ip address of the node and (which is accessible to the client) to /etc/hosts. It is important that this is the only hostname(or the first) hostname returned on lookup of the ip address of the nfs server.
ex: 
192.168.39.88 nfs-ganesha
$ host 192.168.39.88
88.39.168.192.in-addr.arpa domain name pointer nfs-ganesha.
Note: to avoid problems, try and use different nodes for nfs-ganesha and for the krb5 server

3) Create principal for the test machine and write it to the keytab
kadmin -p root/admin -w redhat123 addprinc -randkey nfs/$HOSTNAME
kadmin -p root/admin -w redhat123 ktadd nfs/$HOSTNAME

4) Setup debugging for rpc.gssd and enable the service
$ cat /etc/sysconfig/nfs
SECURE_NFS="yes"
RPCGSSDARGS="-vvv"
RPCSVCGSSDARGS="-vvv"

systemctl enable nfs-client
systemctl start nfs-client.target

5) Mount the share in the following manner
mount -v -t nfs -o sec=krb5,vers=4.1,port=30049 nfs-ganesha:/exports /mnt

