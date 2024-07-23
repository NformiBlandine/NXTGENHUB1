

variable "vpc_cidr" {
  type        = string
  description = "Mandatory vpc network cidr address for kojitechs vpc"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable dns support for kojitechs vpc"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable dns hostname for kojitechs vpc"
  default     = true
}

variable "public_subnet_cidr" {
  type        = list(any)
  description = "Mandatory List of public subnet cidr"
  default     = []
}

variable "private_subnet_cidr" {
  type        = list(any)
  description = "Mandatory List of private subnet cidr"
  default     = []
}

variable "database_subnet_cidr" {
  type        = list(any)
  description = "Mandatory List of database subnet cidr"
  default     = []
}

variable "name" {
  type        = string
  description = "Name to be used on all resources as identifier"
  default     = ""
}

variable "tags" {
  type        = map(any)
  description = "Name to be used on all resources as identifier"
  default     = {}
}

variable "vpc_tags" {
  type        = map(any)
  description = "Name to be used on all resources as identifier"
  default     = {}
}

variable "igw_tags" {
  type        = map(any)
  description = "Name to be used on all resources as identifier"
  default     = {}
}

variable "public_subnet_tags" {
  type        = map(any)
  description = "Name to be used to identify public subnets"
  default     = {}
}

variable "private_subnet_tags" {
  type        = map(any)
  description = "Name to be used to identify private subnets"
  default     = {}
}

variable "database_subnet_tags" {
  type        = map(any)
  description = "Name to be used to identify database subnets"
  default     = {}
}

variable "public_route_table_tags" {
  type        = map(any)
  description = "Name to be used to identify public route table"
  default     = {}
}

variable "default_route_table_tags" {
  type        = map(any)
  description = "Name to be used to identify default route table"
  default     = {}
}

variable "nat_gateway_tags" {
  type        = map(any)
  description = "Name to be used to identify nat gateway "
  default     = {}
}

variable "azs" {
  type        = list(any)
  description = "Availability zone to be used on for your subnets"
  default     = []
}
