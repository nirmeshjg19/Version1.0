terraform {
  backend "s3" {
    
    bucket     = "practise-terraform"
    key        = "stage02/terraform.tfstate"
    
  }
}