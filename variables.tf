variable "location" {
  type        = string
  description = "Location of the resource group."
  default     = "westeurope"
}

variable "rgname" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
  default     = "rgst"
}

variable "stname" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
  default     = "stname"
}

variable "origin_url" {
  type        = string
  description = "URL of cdn endpoint"
  default     = "mysite.iicloudy.io"
}

#variable "client_id" {
#  type = string
#}

#variable "client_secret" {
#  type = string
#}

#variable "subscription_id" {
#  type = string
#}

#variable "tenant_id" {
#  type = string
#}