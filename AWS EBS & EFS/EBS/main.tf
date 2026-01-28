provider "aws" {
  region = var.region
}

resource "aws_instance" "ebs_ec2" {
  ami           = "ami-0532be01f26a3de55" # Amazon Linux 2 (us-east-1)
  instance_type = "t3.micro"

  tags = {
    Name = "terraform-ebs-ec2"
  }
}

resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = aws_instance.ebs_ec2.availability_zone
  size              = 8
  type              = "gp3"

  tags = {
    Name = "terraform-ebs-volume"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.ebs_ec2.id
}
