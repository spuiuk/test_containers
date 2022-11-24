Use krb5-server.yaml to create a krb5-server based on the krb5-server packages available on CentOS on your kubernetes cluster.

The test system is created with the
admin principal:  root/admin
password redhat123

This exposes the following services
kerberos: 88 tcp,udp
kadmin: 749 tcp
on the service name krb5-server.

For containers on the same kubernetes cluster, copy krb5.conf-int to container file. You may need to modify the hostnames in /etc/krb5.conf to reflect the hostname assigned to the service. This should be sufficient for other containers on the kubernetes cluster to authenticate against and use.

The krb5-server containers created here were used to test nfs kerberos authentication from external machines. To access the krb5-server from outside the kubernetes cluster, we need to create NodePort services.

We create the following NodePort services
30088 -> 88 - krb5-ext
30749 -> 749 - kadmin-ext

Use the command
```
kc expose service krb5-server --type=NodePort --name=krb5-ext --port=88
kc expose service krb5-server --type=NodePort --name=kadmin-ext --port=749
```

To configure external clients to access the krb5 server,
1) Add the following entry to /etc/hosts
```
192.168.39.20 krb5-ext.default.svc.cluster.local kadmin-ext.default.svc.cluster.local krb5-server.default.svc.cluster.local
```
This points to the node(192.168.29.20) to access the krb5 service as well as the kadmin service. 192.168.39.20 was the node on my k8s cluster, replace to point to the node on your cluster.
2) Copy over the krb5.conf.ext to /etc/krb5.conf on the client.


How to use:
To administer the server
```
kadmin -p root/admin -w redhat123
```

To list principals, from within the kadmin shell use the command list_principals

To add a new principal use the command add_principal or addprinc
```
kadmin:  add_principal test
No policy specified for test@DEFAULT.SVC.CLUSTER.LOCAL; defaulting to no policy
Enter password for principal "test@DEFAULT.SVC.CLUSTER.LOCAL":
Re-enter password for principal "test@DEFAULT.SVC.CLUSTER.LOCAL":
Principal "test@DEFAULT.SVC.CLUSTER.LOCAL" created.
```

You can now use the kinit command to generate a krb5 ticket.
```
[root@client ~]# kinit test
Password for test@DEFAULT.SVC.CLUSTER.LOCAL:
[root@client ~]# klist
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: test@DEFAULT.SVC.CLUSTER.LOCAL

Valid starting     Expires            Service principal
11/24/22 21:14:12  11/25/22 21:14:12  krbtgt/DEFAULT.SVC.CLUSTER.LOCAL@DEFAULT.SVC.CLUSTER.LOCAL
```
