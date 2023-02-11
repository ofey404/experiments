terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

resource "aws_instance" "app_server" {
  # If you use a region other than us-west-2, you will also need to change your ami
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ami
  # 
  # Details of public image ami-830c94e3, from EC2 Management console:
  # https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#ImageDetails:imageId=ami-830c94e3

  # Chaged to ami-08d70e59c07c61a3a
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  subnet_id = "subnet-00bca75f854832825"
  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
