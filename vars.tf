variable "env" {
  type        = string
  default     = "test"
  description = "Test Environment"
}

variable "k8s-ver" {
  default     = "1.28"
  description = "K8s Version"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Prod Region N.Virginia"
}