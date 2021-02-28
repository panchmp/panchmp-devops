# location-devops

## Prerequisites

* install kubectl [how-to](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* install gcloud [how-to](https://cloud.google.com/sdk/docs/quickstart/)
* install terraform [how-to](https://learn.hashicorp.com/tutorials/terraform/install-cli/)

## Deployment

### Setup cluster (1 region, 1 zone)

1. Check project info
   [Google Cloud Console](https://console.cloud.google.com/home/dashboard?project=location-306206)

2. Login to cluster [link](https://www.terraform.io/docs/providers/google/provider_reference.html)

```
gcloud auth login
gcloud auth application-default login
```

3. Set project & enable API [link](https://cloud.google.com/endpoints/docs/openapi/enable-api#gcloud)

```
gcloud projects list
```

```
gcloud auth application-default set-quota-project location-306206
gcloud config set project location-306206 #modify id needed
```

```
gcloud services list --available
gcloud services enable container.googleapis.com
gcloud services enable servicenetworking.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable containerregistry.googleapis.com
gcloud services enable logging.googleapis.com
gcloud services enable monitoring.googleapis.com
gcloud services enable dns.googleapis.com
```   

4. Create google cloud storage bucket
    * dev: terraform-location-306206

5. Run terraform to initialize GKE dev cluster with
    * node pool for preemptible nodes (n1-standard-1") with autoscale 1 to 3
    * node pool for regular nodes (n1-standard-1) with autoscale 0 to 3
    * setup ingress controller
    * TODO: setup argoCD

```
cd terraform/{dev,prod}
terraform init
terraform plan
terraform apply
```

6. Create kubectl credentials

```
gcloud container clusters get-credentials --region us-east1-b
gcloud container clusters get-credentials location-306206-gke --region us-east1-b #modify id needed
```

## Deploy applications

Please create kubectl credentials before deploy any app

### deploy bla-bla  aplication


## Resources

* [GKE tutorials](https://cloud.google.com/kubernetes-engine/docs/tutorials)
* [Using GKE with Terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/using_gke_with_terraform)
* https://github.com/epiphone/gke-terraform-example
* [Terraform best practices](https://www.terraform-best-practices.com/)
* [Simple GKE Cost Optimization with Preemptible Nodes](https://www.arctiq.ca/our-blog/2019/9/5/simple-gke-cost-optimization-with-pre-emptible-nodes/)
* https://github.com/gruntwork-io/terraform-google-sql/tree/v0.2.0
* https://charlieegan3.com/posts/2018-08-15-cheap-gke-cluster-zero-loadbalancers/
* https://github.com/epiphone/gke-terraform-example
* https://medium.com/swlh/extending-gke-with-externaldns-d02c09157793
* https://stackoverflow.com/questions/41033771/how-setup-gcp-cloudsql-by-terraform
* https://medium.com/@carsanlop86/provision-and-configure-a-kubernetes-cluster-in-minutes-70dbefea202c
* https://cloud.google.com/kubernetes-engine/docs/tutorials/hello-app