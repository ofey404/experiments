terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "PLACEHOLDER-bucket"
    key    = "test-cloudflare.tfstate"  # change this to your desired state file name
    endpoints = {
      s3 = "PLACEHOLDER-endpoint"
    }
    region = "us-east-1"

    access_key                  = "PLACEHOLDER-access-key"
    secret_key                  = "PLACEHOLDER-secret-key"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
  }
}
