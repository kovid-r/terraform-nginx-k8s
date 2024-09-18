variable "kubernetes_host" {
  description = "The Kubernetes API server URL"
  type        = string
}

variable "kubernetes_client_certificate" {
  description = "Path to the client certificate for Kubernetes authentication"
  type        = string
}

variable "kubernetes_client_key" {
  description = "Path to the client key for Kubernetes authentication"
  type        = string
}

variable "kubernetes_cluster_ca_certificate" {
  description = "Path to the CA certificate for Kubernetes authentication"
  type        = string
}

variable "namespace" {
  description = "Namespace in which to deploy Nginx"
  type        = string
  default     = "default"
}

variable "nginx_version" {
  description = "Version of Nginx to deploy"
  type        = string
  default     = "latest"
}

variable "replicas" {
  description = "Number of Nginx replicas to deploy"
  type        = number
  default     = 1
}

variable "cpu_limit" {
  description = "CPU limit for the Nginx container"
  type        = string
  default     = "500m"
}

variable "memory_limit" {
  description = "Memory limit for the Nginx container"
  type        = string
  default     = "256Mi"
}

variable "service_type" {
  description = "Kubernetes service type (ClusterIP, NodePort, LoadBalancer)"
  type        = string
  default     = "ClusterIP"
}
