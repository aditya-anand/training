#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-f2b39792
#
# Your subnet ID is:
#
#     subnet-8e99c7ea
#
# Your security group ID is:
#
#     sg-578da130
#
# Your Identity is:
#
#     HashiDays-2017-tf-sheep
#
terraform {
  backend "atlas" {
    name = "adityaanand/training"
  }
}

variable atlas_access_token {}

variable aws_access_key {}

variable aws_secret_key {}

variable region {
  default = "us-west-1"
}

variable num_web {
  default = 2
}

/*
module "example" {
  source = "./example-module"
  command = "echo 'hi there'"
}
*/

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "web" {
  ami           = "ami-f2b39792"
  instance_type = "t2.micro"
  subnet_id     = "subnet-8e99c7ea"

  vpc_security_group_ids = ["sg-578da130"]

  tags {
    Identity = "HashiDays-2017-tf-sheep"
    Name     = "Web ${count.index + 1} of 2"
  }

  count = "${var.numweb}"
}

output "map" {
  value = {
    DNS = ["${aws_instance.web.*.public_dns}"]
    IP  = ["${aws_instance.web.*.public_ip}"]
  }
}

output "ips" {
  value = [
    "${aws_instance.web.*.public_ip}",
  ]
}

# output "cmd" { value = "${module.example.command}" }

