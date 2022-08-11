variable "region" {
  description = "Please Enter AWS Region to deploy SRV"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "Enter instance type"
  type        = string
  default     = "t2.micro"
}

variable "allow_ports" {
  description = "List of Ports to open for server "
  type        = list(any)
  default     = ["80", "443", "22", "8080"]
}


variable "enable_detailed_monitoring" {
  # type = bool просит ввести значение, проверяетт соответствее введенных данных
  type    = bool
  default = "false"
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(any)
  default = {
    Owner       = "Oleksandr Nehreiev"
    Project     = "EDU"
    CostCenter  = "12345"
    Environment = "development"
  }
}
