Container creates a krb5-server based on the krb5-server packages available in CentOS.

The test system is created with the admin principal  root/admin and password redhat123

The following NodePorts are created to help access the krb5 server
30088 -> krb5 server
30749 -> kadmin server

The instructions below describe how to setup a test client(a vm) to access the krb5 server exposed with Nodeport.

1) Add entry to /etc/hosts
192.168.39.20 krb5-ext.default.svc.cluster.local kadmin-ext.default.svc.cluster.local krb5-server.default.svc.cluster.local
This points to the node to access the krb5 service as well as the kadmin service.

2) Copy over the krb5.conf.ext to /etc/krb5.conf on the client.

3) Ensure you can access the kadmin server using the command
kadmin -p root/admin -w redhat123
