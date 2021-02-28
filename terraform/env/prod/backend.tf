terraform {
  backend "gcs" {
    bucket = "location-terraform"
    prefix = "dev"
  }
}
