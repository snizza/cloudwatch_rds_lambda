#security group
resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic ingress {
    for_each = [443, 80, 22, 3306]
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "prod_sg"
  }
}

#MYSQL sg
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow MYSQL inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "MYSQL from WP"
    security_groups  = [aws_security_group.sg.id]
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "rds_sg"
  }
}
