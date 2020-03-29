terraform {
    required_version = "0.11.14"

    backend "s3" {
        encrypt = "true"
        key = "state/s3-bucket-build.tfstate"
    }
}

provider "aws" {
    version = "~> 1.55"
    region  = "eu-west-2"
}


resource "aws_s3_bucket" "minecraft-build" {
    bucket = "minecraftserver-build-bucket"
}