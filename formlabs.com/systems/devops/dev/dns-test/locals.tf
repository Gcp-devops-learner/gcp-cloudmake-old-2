locals {
  name       = "private-dns-cloud"
  project_id = "formlabs-377008"
  region     = "us-central1"
  fqdn       = "prash.cloud."

  records = {
    "rec1" = {
      name    = "formlab-test"
      type    = "A"
      rrdatas = ["10.0.1.2"]
      ttl     = 60
    }
  }

  cnamerecords = {
    "rec1" = {
      type_1    = "CNAME"
      rrdatas_1 = ["rds-magento2-production-formlabs-cloud-encrypted.cchlcddjm6zo.us-east-1.rds.amazonaws.com.prash.cloud."]
      ttl_1     = 300
    }
  }
}