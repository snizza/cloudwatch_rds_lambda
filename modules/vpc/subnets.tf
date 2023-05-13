#public subnet
resource "aws_subnet" "sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "public_wp_subnet"
  }
}

#private subnet
resource "aws_subnet" "rds_sub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_rds_subnet"
  }
}

# private subnet2
resource "aws_subnet" "rds_sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private_rds_subnet2"
  }
}
