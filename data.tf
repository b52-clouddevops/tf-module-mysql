# Fetches the information of the remote statefile, here in our case, this will fetch the information of the VPC Statefile
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
        bucket = "b52-terraform-state-bucket"
        key    = "vpc/${var.ENV}/terraform.tfstate"
        region = "us-east-1"
  }
}

# Whenever you have some common fields or anything which is highly used, you can consider that in locals and can call it on your need

locals {
    DOCDB_USER = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_USERNAME"]
    DOCDB_PASS = jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_PASSWORD"]
}

# fetching the metadata of the secret
data "aws_secretsmanager_secret" "secrets" {
  name = "robotshop/secrets"
}

data "aws_secretsmanager_secret_version" "secrets" {
  secret_id = data.aws_secretsmanager_secret.secrets.id
}

output "data" {
  value  =  jsondecode(data.aws_secretsmanager_secret_version.secrets.secret_string)["DOCDB_USERNAME"]
}