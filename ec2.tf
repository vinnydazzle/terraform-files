# ec2 instance
resource "aws_instance" "web" {
  ami                    = "ami-01e36b7901e884a10"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ibm-pub-sn.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = "ohio"
  user_data              = file("ecomm.sh")
  tags = {
    Name = "IBM WEB SERVICE"
  }
}
