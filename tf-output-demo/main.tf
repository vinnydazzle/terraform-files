#provider
provider "aws" {
  region     = "us-east-2"
}

#Resources - EBS volume
resource "aws_ebs_volume" "ebs" {
  availability_zone = "us-east-2c"
  size              = 50

  tags = {
    Name = "ADDITIONAL VOL"
  }
}
