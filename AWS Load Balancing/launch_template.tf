resource "aws_launch_template" "web_lt" {
  name_prefix   = "phase3-lab3-"
  image_id      = "ami-019715e0d74f695be" # Ubuntu ap-south-1
  instance_type = "t3.micro"
  key_name      = "first-key-pair"

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "phase3-lab3-asg-instance"
    }
  }
}
