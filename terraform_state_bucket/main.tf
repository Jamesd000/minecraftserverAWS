terraform {
    required_version = "0.11.14"

}

provider "aws" {
    version = "~> 1.55"
    region  = "eu-west-2"

}

resource "aws_s3_bucket" "minecraftserverAWS_terraform_state" {
    bucket = "minecraftserver-terraform-state"

#prevent accidental deletion of this s3 bucket
lifecycle {
    prevent_destroy = false

}

#enable versioning so we can see the full revision of our state files 
versioning {
    enabled = true
}
#enable server-side encryption by default

server_side_encryption_configuration {
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-up-and-running-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}
