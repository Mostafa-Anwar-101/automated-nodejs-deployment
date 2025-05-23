terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-mostafa"
    key            = "automated-nodejs-deployment/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }
}
