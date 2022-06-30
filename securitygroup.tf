data "aws_ip_ranges" "us_east_ip_range" {
  regions  = ["us-east-1", "us-east-2"]
  services = ["ec2"]
}

resource "aws_security_group" "sg-custom_us_east" {
  name = "custom_us_east"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.us_east_ip_range.cidr_blocks, 0, 50)

    provisioner "local-exec" {
      command = "echo ${cidr_blocks} >> my_secgroup_ips.txt"
    }

  }

  tags = {
    CreateDate = data.aws_ip_ranges.us_east_ip_range.create_date
    SyncToken  = data.aws_ip_ranges.us_east_ip_range.sync_token
  }
}
