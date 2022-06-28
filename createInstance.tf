
data "aws_availability_zones" "available" {}

data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["myami-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "MyFirstInstance" {
  ami               = data
  instance_type     = "t2.micro"
  availability_zone = data.aws_availability_zones.available.names[1]


  tags = {
    Name = "custom_instance"
  }

}
