provider "aws" {
    profile     = "${var.iam_profile}"
    region      = "${var.aws_region}"
}

