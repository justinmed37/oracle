
# This module is being developed in conjunction with the new
#     devops features being developed
# The idea here is to use terraform to generate a map of all the
#     resources being created that will be published in object store
# That map will then simplify the process of finding / selecting the
#     correct ocids of the resources we need to target for devops

module "common" {
  source = "../shared_modules/common/network"
}

output "data" {
  value = module.common
}