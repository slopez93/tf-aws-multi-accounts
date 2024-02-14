
provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = var.aws_assume_role
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "ec2-instance" {
  source = "./modules/aws-ec2-instance"

  ami_id        = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  instance_name = "My new ec2 instance"
}

