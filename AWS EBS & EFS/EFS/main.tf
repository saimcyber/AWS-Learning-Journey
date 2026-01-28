provider "aws" {
  region = var.region
}

# -----------------------------
# Security Group for EFS (NFS)
# -----------------------------
resource "aws_security_group" "efs_sg" {
  name        = "efs-nfs-sg"
  description = "Allow NFS access to EFS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "efs-nfs-sg"
  }
}

# -----------------------------
# EFS File System
# -----------------------------
resource "aws_efs_file_system" "efs" {
  encrypted = true

  tags = {
    Name = "terraform-efs"
  }
}

# -----------------------------
# EFS Mount Targets
# -----------------------------
resource "aws_efs_mount_target" "efs_mount_targets" {
  for_each = toset(var.subnet_ids)

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs_sg.id]
}
