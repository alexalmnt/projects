resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "pub1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pubsub1cidr
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "publicsubnet1"
  }
}

resource "aws_subnet" "priv1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.privsub1cidr
  availability_zone = "us-east-1b"

  tags = {
    Name = "privatesubnet1"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "internetgatewayA"
  }
}
resource "aws_eip" "nat" {
 domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.pub1.id
  tags = {
    Name = " nat-gateway"
  }
}

resource "aws_route_table" "public1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route"
  }
}

resource "aws_route_table" "priv1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "private-route"
  }
}
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.pub1.id
  route_table_id = aws_route_table.public1.id
}
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.priv1.id
  route_table_id = aws_route_table.priv1.id
}