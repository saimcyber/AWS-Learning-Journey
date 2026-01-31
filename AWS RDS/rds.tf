# DB Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "phase5-rds-subnet-group"
  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}

# RDS Instance (Lab 1 + Lab 2)
resource "aws_db_instance" "mysql" {
  identifier              = "database-phase5"
  engine                  = "mysql"
  instance_class          = "db.t4g.micro"
  allocated_storage       = 20

  username                = var.db_username
  password                = var.db_password

  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  backup_retention_period = 1   # FREE TIER MAX
  publicly_accessible     = false
  skip_final_snapshot     = true

  tags = {
    Name = "phase5-mysql-db"
  }
}
