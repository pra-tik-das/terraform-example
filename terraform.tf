terraform {
    backend "s3" {
        bucket      = "demo-terraform-tfstate"
        key         = "terraform.tfstate"
        profile     = "tfadmin"
        region      = "us-west-2"
    }
}