terraform {
  backend "s3" {
    bucket    = "generic_bu_tfstate"
    key       = "tf.tfstate"
    region    = "us-ashburn-1"
    endpoints = { s3 = "https://idbjyurhyjpo.compat.objectstorage.us-ashburn-1.oraclecloud.com" }
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    # see this: https://github.com/hashicorp/terraform/issues/34053
    skip_s3_checksum = true # wow, this needs to be better documented by oracle
    use_path_style   = true
  }
}