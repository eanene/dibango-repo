terraform {
    cloud {
        hostname = "app.terraform.io"
        organization = "flashinfong"
        workspace {
            name = "dibango-repo"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}


module "dibangox_ro_users" {
    source = "../modules/iam_user_ro_dev"
    IAM-ro-users = ["dibans@gmail.com", "emadu@yahoo.com"]
    iam_group_name = "RO_Group_Dev"
    region = "us-east-1"
    force_destroy = "true"
    dynamic_policy = "AmazonEC2ReadOnlyAccess"
    tags = {
        Environment = "Dev"
        Owner = "dibanox"
    }
    
}