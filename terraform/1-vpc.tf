resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = var.cluster_name
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = var.cluster_name
    Environment = var.environment
  }
}

resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name        = var.cluster_name
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-1.id
  tags = {
    Name        = var.cluster_name
    Environment = var.environment
  }
  depends_on = [aws_internet_gateway.igw]
}

####################SUBNETS###########################

#Private Subnets AZ=a,b,c
resource "aws_subnet" "private-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1
  availability_zone = "${var.region}a"

  tags = {
    "Name"                            = "${var.region}a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
    Environment                       = var.environment
  }
}

resource "aws_subnet" "private-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2
  availability_zone = "${var.region}b"

  tags = {
    "Name"                                      = "${var.region}b"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Environment                                 = var.environment
  }
}

resource "aws_subnet" "private-3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_3
  availability_zone = "${var.region}c"

  tags = {
    "Name"                                      = "${var.region}c"
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Environment                                 = var.environment
  }
}

#Public Subnets AZ=a,b,c

resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "${var.region}a"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Environment                                 = var.environment
  }
}

resource "aws_subnet" "public-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "${var.region}b"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Environment                                 = var.environment
  }
}

resource "aws_subnet" "public-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_3
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "${var.region}c"
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    Environment                                 = var.environment
  }
}
