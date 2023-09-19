variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "West US 3"
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "subscription_id" {
  description = "The subscription id in which all resources in this example should be created."
}

variable "az_clientID" {
  description = "The admin username for the instance."
  sensitive   = true
}

variable "az_secret" {
  description = "The admin username for the instance."
  sensitive   = true
}

variable "az_tenant" {
  description = "The admin username for the instance."
}

variable "tfc_agent_token" {
  description = "Terraform Cloud agent token. (mark as sensitive) (TFC Organization Settings >> Agents)"
}
