terraform {
  backend "s3" {
    bucket = "teetoo-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}