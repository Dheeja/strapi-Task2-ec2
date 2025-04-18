provider "aws" {
  region = "us-east-1" # or your preferred region
}

resource "aws_instance" "strapi" {
  ami                    = "ami-084568db4383264d4" # Ubuntu 22.04 LTS
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  user_data = file("${path.module}/scripts/install-strapi.sh")

  tags = {
    Name = "Strapi-task2"
  }
}

resource "aws_security_group" "strapi_sg" {
  name        = "strapi_sg"
  description = "Allow port 22 and 1337"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
