terraform {
  required_providers {
    volcengine = {
      source = "volcengine/volcengine"
    }
  }
}

provider "volcengine" {
  region = "cn-beijing"
}

locals {
  name = "test-terraform-vke-plugin-230605"
  subnet_ids = ["subnet-rrzl63rmmv40v0x58imkoba"]
}

resource "volcengine_vke_cluster" "this" {
  name                      = local.name
  description               = "created by terraform"
  delete_protection_enabled = true

  cluster_config {
    subnet_ids                       = local.subnet_ids
    api_server_public_access_enabled = true
    api_server_public_access_config {
      public_access_network_config {
        billing_type = "PostPaidByBandwidth"
        bandwidth    = 1
      }
    }
    resource_public_access_default_enabled = true
  }

  pods_config {
    pod_network_mode = "VpcCniShared"
    vpc_cni_config {
      subnet_ids = local.subnet_ids
    }
  }
  services_config {
    service_cidrsv4 = ["10.42.80.0/20"]
  }

  tags {
    key   = "Project"
    value = "Cloud-Platform"
  }

  logging_config {
    log_setups {
      enabled  = false
      log_ttl  = 30
      log_type = "Audit"
    }
  }
}