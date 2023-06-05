resource "volcengine_vpc" "foo" {
  vpc_name = "tf-test-2"
  cidr_block = "172.16.0.0/16"
}

resource "volcengine_subnet" "foo1" {
  subnet_name = "subnet-test-1"
  cidr_block = "172.16.1.0/24"
  zone_id = "cn-beijing-a"
  vpc_id = volcengine_vpc.foo.id
}

resource "volcengine_security_group" "foo1" {
  depends_on = [volcengine_subnet.foo1]
  vpc_id = volcengine_vpc.foo.id
}

# https://github.com/volcengine/terraform-provider-volcengine/blob/master/example/ecsInstance/main.tf
resource "volcengine_ecs_instance" "default" {
  image_id = "image-aagd56zrw2jtdro3bnrl"
  instance_type = "ecs.g2i.large"
  instance_name = "xym-tf-test-2"
  description = "xym-tf-test-desc-1"
  password = "93f0cb0614Aab12"
  instance_charge_type = "PostPaid"
  system_volume_type = "LOCAL_SSD"  # FIXME: bug here.
  system_volume_size = 60
  subnet_id = volcengine_subnet.foo1.id
  security_group_ids = [volcengine_security_group.foo1.id]
  deployment_set_id = ""
  ipv6_address_count = 1
  #  secondary_network_interfaces {
  #    subnet_id = volcengine_subnet.foo1.id
  #    security_group_ids = [volcengine_security_group.foo1.id]
  #  }
}