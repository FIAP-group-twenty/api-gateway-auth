###################### AWS ######################
variable "aws_region" {
  type    = string
  default = "us-east-1"
}

###################### CUSTOMER ######################
variable "customer_path" {
  type        = string
  description = "Path base para o recurso de customer"
  default     = "customers"
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
variable "payment_path" {
  type        = string
  description = "Path base para o recurso de payment"
  default     = "payment"
}

variable "webhook_path" {
  type        = string
  description = "Path base para o recurso de webhook do payment"
  default     = "webhook"
}

variable "payment_get_path" {
  type        = string
  description = "Path para buscar status de pagamento utilizando ID de um pedido"
  default     = "{orderId}"
}

###################### PRODUCT ######################
variable "product_path" {
  type        = string
  description = "Path base para o recurso de product"
  default     = "products"
}

variable "product_get_path" {
  type        = string
  description = "Path para buscar produto filtrando por categoria"
  default     = "products/{category}"
}

variable "product_put_or_delete_path" {
  type        = string
  description = "Path para recurso product, utilizando ID"
  default     = "{id}"
}