resource "aws_instance" "ec2" {
  ami                    = "ami-0c02fb55956c7d316" # Amazon Linux 2023
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "phase5-ec2"
  }
}
