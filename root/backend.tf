terraform {
  backend "s3" {
    bucket         = "sammielas-terraform-remote-state"
    key            = "backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }
}