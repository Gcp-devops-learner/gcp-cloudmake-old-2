variable "description" {
  type        = string
  description = "An optional description of this resource"
  default     = ""
}

variable "project_id" {
  type        = string
  description = "The ID of a project to host this VPC"
}

variable "network_name" {
  type        = string
  description = "The name of the network being created"
}

variable "mtu" {
  type        = number
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460')"
  default     = 0
}

variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  description = "Secondary ranges that will be used in some of the subnets"
  default     = {}
}

variable "firewall_rules" {
  type        = any
  description = "List of firewall rules"
  default     = []
}

variable "shared_vpc_host" {
  type        = bool
  description = "Makes this project a Shared VPC host"
  default     = false
}

variable "enable_internet_gateway_routes" {
  type        = bool
  description = "Add IGW route to the VPC"
  default     = true
}

variable "routes" {
  type        = list(map(string))
  description = "List of routes being created in this VPC"
  default     = []
}
