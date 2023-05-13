#RDS instance
resource "aws_db_instance" "rds" {
  identifier           = var.rds_identifier
  allocated_storage    = var.storage
  db_name              = var.database_name
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = var.database_user
  password             = var.database_password
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.sub_group.name
  vpc_security_group_ids = [var.rds_sg]
  storage_type         = "gp2"
  skip_final_snapshot  = true
  tags = {
    Name = var.database_name
  }          
}

#RDS subnet group
resource "aws_db_subnet_group" "sub_group" {
  name       = "rds_sub_group"
  subnet_ids = var.rds_subs

  tags = {
    Name = "${var.database_name}-group"
  }
}

