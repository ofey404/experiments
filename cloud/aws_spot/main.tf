terraform {
  required_version = ">= 1.4.5"
  required_providers {
    aws = "~> 5.0"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_spot_fleet_request" "dev_spot_request" {
  iam_fleet_role = "arn:aws:iam::062982397332:role/CoderEC2DevSpotFleetRole"
  allocation_strategy = "diversified"
  target_capacity = 1

  fleet_type = "maintain"
  on_demand_target_capacity = 0
  instance_interruption_behaviour = "terminate"

  terminate_instances_with_expiration = true
  wait_for_fulfillment = true


  # similar with aws_instance
  launch_specification {
    instance_type = var.dev_instance_type
    ami = data.aws_ami.amzn_linux2.id
    spot_price = var.dev_spot_price
    iam_instance_profile = aws_iam_instance_profile.dev_ec2_profile.name
    vpc_security_group_ids = [aws_security_group.dev_machine_firewall.id]

    user_data = <<EOF
#!/bin/sh

curl -L -s ${var.dev_user_data_url} | bash
EOF
  }
}