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
