#################################################################
# NETWORKING PARENT MODULE
################################################################


locals {
  vpc_id = aws_vpc.this.id
}

# local.az
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr # 
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = local.vpc_id

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.igw_tags,
  )
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnet_cidr)

  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnet_cidr[count.index] # 20
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.public_subnet_tags,
  )
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidr)

  vpc_id            = local.vpc_id
  cidr_block        = var.private_subnet_cidr[count.index] # 20
  availability_zone = element(var.azs, count.index)

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.private_subnet_tags,
  )
}

resource "aws_subnet" "database_subnet" {
  count = length(var.database_subnet_cidr)

  vpc_id            = local.vpc_id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = element(var.azs, count.index)

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.database_subnet_tags,
  )
}

################################################################################
# CREATING PUBLIC ROUTE TABLES ASSOCIATED WITH PUBLIC SUBNET?
################################################################################

resource "aws_route_table" "public_route_table" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.public_route_table_tags,
  )
}

################################################################################
# CREATING PUBLIC ROUTE TABLES ASSOCIATION
################################################################################
resource "aws_route_table_association" "rt_association" {
  count = length(var.public_subnet_cidr)

  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}

################################################################################
# CREATING DEFAULT ROUTE TABLES 
################################################################################

resource "aws_default_route_table" "this" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.default_route_table_tags,
  )
}

################################################################################
# CREATING NAT GATEWAY
################################################################################

resource "aws_nat_gateway" "this" {
  depends_on = [aws_internet_gateway.gw]

  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.nat_gateway_tags,
  )
}

################################################################################
# CREATING A AN  ELASTICIP
################################################################################ 

resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.gw]
  vpc        = true
}
