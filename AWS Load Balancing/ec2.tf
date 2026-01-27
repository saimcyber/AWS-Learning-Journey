resource "aws_instance" "web" {
  ami           = "ami-019715e0d74f695be" # Ubuntu (ap-south-1)
  instance_type = "t3.micro"
  key_name      = "first-key-pair"

vpc_security_group_ids = [
  aws_security_group.ec2_sg.id
]


  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "phase3-lab1-ec2"
  }
}
