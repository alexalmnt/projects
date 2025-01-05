resource "aws_instance" "ec2" {
  ami           = var.ami
  instance_type = var.instancetype
  key_name = "devops"
  tags = {
    Name = "terraformtest"
  }
}

resource "aws_eip" "monteip" {
  domain = "vpc"
  instance = aws_instance.ec2.id
}