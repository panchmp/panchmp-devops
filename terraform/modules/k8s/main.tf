#gcloud compute addresses create ingress-nginx-somm-dev --region us-east4
#helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --create-namespace  --set controller.service.loadBalancerIP=34.117.114.10
#helm delete ingress-nginx -n ingress-nginx

resource "google_compute_address" "ingress-nginx" {
  name = "ingress-nginx-${var.project_id}"
  region = var.region
}

resource "google_dns_managed_zone" "latlng-zone" {
  name = "latlng-zone"
  dns_name = "latlng.info."
  description = "latlng.info DNS zone"

  dnssec_config {
    state = "on"
  }
}

resource "google_dns_record_set" "api" {
  name = "api.${google_dns_managed_zone.latlng-zone.dns_name}"
  type = "A"
  ttl = 3600

  managed_zone = google_dns_managed_zone.latlng-zone.name

  rrdatas = [
    google_compute_address.ingress-nginx.address]
}


resource "helm_release" "nginx-ingress" {
  name = "nginx-ingress"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = " ingress-nginx"

  namespace = "ingress-nginx"
  create_namespace = true

  #reset_values = true
  #reuse_values = true

  set {
    name = "controller.service.loadBalancerIP"
    value = google_compute_address.ingress-nginx.address
  }

  set {
    name = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
}

//https://cert-manager.io/docs/installation/kubernetes/#installing-with-helm
resource "helm_release" "cert-manager" {
  name = "cert-managerye"

  repository = "https://charts.jetstack.io"
  chart = "cert-manager"
  version = "v1.1.0"

  namespace = "cert-manager"
  create_namespace = true

  set {
    name = "installCRDs"
    value = true
  }
}
