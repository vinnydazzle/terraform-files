#provider
provider "aws" {
  region     = "us-east-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

#Resources - EBS volume
resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-east-2c"
  size              = 50

  tags = {
    Name = "ADDITIONAL VOL"
  }
}
