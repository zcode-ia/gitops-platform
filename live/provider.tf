# Specify the provider
provider "aws" {
  region = "us-west-2"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  access_key = "foo"
  secret_key = "bar"
}
