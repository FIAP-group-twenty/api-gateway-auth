###################### AWS ######################
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

###################### CUSTOMER ######################
variable "customer_path" {
  type        = string
  description = "Path base para o recurso de customer"
  default     = "customer"
}

variable "customer_get_path" {
  type        = string
  description = "Path para GET no recurso customer, utilizando cpf"
  default     = "{cpf}"
}

###################### ORDER ######################
variable "order_path" {
  type        = string
  description = "Path base para o recurso de order"
  default     = "order"
}

variable "order_update_path" {
  type        = string
  description = "Path para update no recurso order, utilizando ID"
  default     = "{id}"
}

###################### PAYMENT ######################
