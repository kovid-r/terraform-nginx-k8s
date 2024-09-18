# Terraform module for deploying nginx on Kubernetes

Ensure you have Docker Engine and Minikube running on your local machine. Here's an example of a `<custom_name.tf>` file that you can use to deploy two Kubernetes clusters with one nginx deployment and service each:

```text
module "nginx_cluster_one" {
  source = "/path/to/nginx-module/"
  kubernetes_host                   = "http://127.0.0.1:57560/" # replace with your minikube dashboard address
  kubernetes_client_certificate     = "/path/to/.minikube/profiles/minikube/client.crt"
  kubernetes_client_key             = "/path/to/.minikube/profiles/minikube/client.key"
  kubernetes_cluster_ca_certificate = "/path/to/.minikube/ca.crt"
  namespace                         = "nginx-cluster-one-ns"
  nginx_version                     = "1.21.1"
  replicas                          = 2
  cpu_limit                         = "250m"
  memory_limit                      = "128Mi"
  service_type                      = "ClusterIP"
}

module "nginx_cluster_two" {
  source = "/path/to/nginx-module/"
  kubernetes_host                   = "http://127.0.0.1:57560/" # replace with your minikube dashboard address
  kubernetes_client_certificate     = "/path/to/.minikube/profiles/minikube/client.crt"
  kubernetes_client_key             = "/path/to/.minikube/profiles/minikube/client.key"
  kubernetes_cluster_ca_certificate = "/path/to/.minikube/ca.crt"
  namespace                         = "nginx-cluster-two-ns"
  nginx_version                     = "1.21.1"
  replicas                          = 3
  cpu_limit                         = "250m"
  memory_limit                      = "128Mi"
  service_type                      = "ClusterIP"
}
```

Run the following commands:

```shell
terraform init
terraform plan
terraform apply -auto-approve
```

Once the deployment is finished, check the status using the following `kubectl` commands:

For `nginx-cluster-one-ns`,

```➜ kubectl get all -n nginx-cluster-one-ns
NAME                                   READY   STATUS    RESTARTS   AGE
pod/nginx-deployment-d55b49455-2sqwg   1/1     Running   0          33s
pod/nginx-deployment-d55b49455-n87wf   1/1     Running   0          33s
pod/nginx-deployment-d55b49455-ww6l8   1/1     Running   0          25s
pod/nginx-deployment-d55b49455-zlntp   1/1     Running   0          26s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/nginx-service   ClusterIP   10.109.36.68   <none>        80/TCP    141m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deployment   4/4     4            4           141m

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-7d85df7dbc   0         0         0       141m
replicaset.apps/nginx-deployment-d55b49455    4         4         4       128m
```

For `nginx-cluster-two-ns`,

```
➜ kubectl get all -n nginx-cluster-two-ns
NAME                                   READY   STATUS    RESTARTS   AGE
pod/nginx-deployment-d55b49455-7jtgt   1/1     Running   0          9m14s
pod/nginx-deployment-d55b49455-cg6ng   1/1     Running   0          9m7s
pod/nginx-deployment-d55b49455-dnlmm   1/1     Running   0          9m5s
pod/nginx-deployment-d55b49455-h2wh6   1/1     Running   0          9m14s
pod/nginx-deployment-d55b49455-lsc9q   1/1     Running   0          9m14s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/nginx-service   ClusterIP   10.105.218.43   <none>        80/TCP    149m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deployment   5/5     5            5           149m

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-7d85df7dbc   0         0         0       149m
replicaset.apps/nginx-deployment-d55b49455    5         5         5       137m
```
