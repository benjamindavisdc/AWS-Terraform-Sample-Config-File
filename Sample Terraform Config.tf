terraform {

#We are working with AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

#This is the VPC we are using
data "aws_vpc" "main" {
    id = "vpc-05b8e4f163f79d5b9"
}

#Don't forget your security group!
resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My server security group"
  vpc_id      = data.aws_vpc.main.id


#SSH on port 22 will let us log in remotely
  ingress = [
    {
        description      = "SSH"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["70.121.74.96/32"]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self = false
    },

    {
        description      = "HTTP"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids  = []
        security_groups  = []
        self = false
    }]

  egress {
    description      = "outgoing traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self = false
  }

  tags = {
    Name = "allow_tls"
  }
}

#Key pair to provide credentials
resource "aws_key_pair" "deployer" {
    key_name = "deployer-key"
    public_key = "*Key*"
}

data "template_file" "user_data" {
    template = file("./userdata.yaml")
  
}

#The instance we will maintain
resource "aws_instance" "ben_server" {
  ami           = "ami-05fa00d4c63e32376"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "BenServerInstance"
  }
}

#Text output of the IP address of the new server
output "public_ip" {
    value = aws_instance.ben_server.public_ip
  
}