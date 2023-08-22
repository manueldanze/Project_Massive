# Kubernetes Documentation

<br>
<br>

---

## Table of contents

---

<br>

- [1. Local Kubernetes Cluster](#1-using-docker-desktops-integration-of-kubernetes-locally)
  - [1.1 Setting up Docker and Kubernetes](#11-setting-up-docker-and-kubernetes)
  - [1.2 Setting up the cluster](#12-setting-up-the-cluster)
  - [1.3 Connecting to the Server](#13-connecting-to-the-server)

<br>

## <!-- 1. Using Docker Desktops integration of Kubernetes locally -->

## 1. Using Docker Desktops integration of Kubernetes locally

---

### 1.1 Setting up Docker and Kubernetes

<br>

1.  Download and install Kubernetes locally (Follow the official Documentation: <a href="https://kubernetes.io/docs/setup/">Installation Instructions</a>)

2.  Download and install Docker Desktop Instructions here: <a href="https://docs.docker.com/desktop/install/windows-install/"> Docker for Windows</a>

3.  Activate Kubernetes support within Docker Desktop in settings -> Kubernetes -> "Enable Kubernetes" -> Apply & Restart

4.  Open a shell (preferably git bash) and switch to the docker kubernetes support

    ```
    $ kubectl config use-context docker-desktop
    Switched to context "docker-desktop".
    ```

5.  To test the command you can List your avalible nodes:

    ```
    $ kubectl get nodes
    NAME            STATUS  ROLES           AGE     VERSION
    docker-desktop  Ready   control-plane   21m     v1.25.4
    ```

kubectl should now point to the docker-desktop environment and use it as its default backend.

### 1.2 Setting up the cluster

<br>

1. First of all we need to build our unreal server image so its avalible for Docker and Kubernetes to deploy.
   <br>
   To do that just run the folloing command in the ProjectMassive Directory:

   ```
   $ docker build -t unreal_server .
   ```

   This will build the image and tag it as "unreal_server" so we can use it later on.

<br>

To set up the Pods and nodes within the Cluster we are using 2 different .yaml files to configure the pods for our specific needs. The _unreal-server-deployment.yaml_ and the _unreal-server-service.yaml_.
<br>
The deployment.yaml file specifies the needs of the unreal server itsself while the service.yaml file is needed to be able to connect to our unreal server within the cluster. It acts as a gateway and as a loadbalancer at the same time.

<br>

2. We need to deploy both the Deployment and the load balancer at the same time. Otherwise the Loadbalancer will not getlocalhost as the external IP address.

   ```
   $ kubectl apply -f unreal-server-deployment.yaml -f unreal-engine-service.yaml
    deployment.apps/unreal-server created
    service/unreal-service created
   ```

   To verify that our pods have been created we can list our pods:

   ```
   $ kubectl get pods -o wide
   NAME                            READY   STATUS    RESTARTS   AGE   IP          NODE             NOMINATED NODE   READINESS GATES
   unreal-server-6cd6745fb-dbh9q   1/1     Running   0          62s   10.1.0.45   docker-desktop   <none>           <none>
   ```

   We should now have a working pod with our unreal server running inside of it.

   To verify that our service has been created we can list our services:

   ```
   $ kubectl get services
   NAME             TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
   kubernetes       ClusterIP      10.96.0.1        <none>        443/TCP          110s
   unreal-service   LoadBalancer   10.107.107.220   localhost     7777:32198/UDP   22s
   ```

   We now have our unreal server running inside the cluster as well as a loadbalancer to be able to access it from the outside.

   The loadbalancer has the external ip "localhost" which we will use to access it from the unreal client.

### 1.3 Connecting to the server

<br>

1.  To be able to monitor our servers activity we can access its logs.
    <br>
    To see the server logs of our previously deployed unreal server we open a new terminal window. And use the _kubectl logs_ command to access the logs of our pod.

    ```
    $ kubectl logs -f <unreal-engine-server-pod-id>
    ```

    Replace the \<unreal-engine-server-pod-id\> with the actual pod id. You can get the pod id by using the _kubectl get pods_ command.

    ```
    $ kubectl get pods
    NAME                            READY   STATUS    RESTARTS   AGE
    unreal-server-6cd6745fb-dbh9q   1/1     Running   0          16m
    ```

    The pod id can be read from the "NAME" column.

    We should now be able to see our server logs.

    <br>

2.  Now open a terminla window in the _ProjectMassivePackaged/Windows_ folder and type in the command:

    ```
    $ ./ProjectMassive.exe 127.0.0.1:7777 -WINDOWED -ResX=800 -ResY=450
    ```

    This will start the unreal client and connect it to our server. The server logs should display that a player joined.

    ```
    [2023.06.05-10.21.17:649][549]LogNet: Join succeeded: <PC>
    ```

Congratulations. You set up an unreal-engine server inside a kubernetes cluster and accessed it from the outside.
