
# This module is being developed in conjunction with the new
#     devops features being developed
# The idea here is to use terraform to generate a map of all the
#     resources being created that will be published in object store
# That map will then simplify the process of finding / selecting the
#     correct ocids of the resources we need to target for devops

module "common_data" {
  source = "../shared_modules/common"
}

module "network" {
  source = "../shared_modules/common/network"
}

module "containers" {
  source = "../shared_modules/common/containers"
}

module "auto_dbs" {
  source = "../shared_modules/common/databases"
}

output "data" {
  value = {
    common_data = module.common_data.data
    network     = module.network.data
    containers  = module.containers.data
    auto_dbs    = module.auto_dbs.data
  }
}

terraform {
  required_version = ">= 1.7.4"
  required_providers {
    oci = {
      version = "5.35.0"
      source  = "oracle/oci"
    }
  }
}