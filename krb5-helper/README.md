The container is expected to run as an init container which creates a principal for the host based on an environmental variable passed(ADD_PRINC).

Please look at the nfs-ganesha container yaml to understand how this container is used. The container used the admin principal & password created for the container krb5-server.
