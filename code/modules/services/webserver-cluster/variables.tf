variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type = string
}

variable "db_remote_state_bucket" {
  description = "The name of the s3 bucket for the database's remote state"
  type = string
}

variable "db_remote_state_key" {
  description = "The path for the database's remote state in s3"
  type = string
}

variable "instance_type" {
  description = "The type of EC2 instances to run (e.g t2.micro)"
  type = string
}

variable "min_size" {
  description = "The minimum number of EC@ Instances in the ASG"
  type = number
}

variable "max_size" {
  description = "The maximum number of EC2 instances in the ASG"
  type = number
}

variable "custom_tags" {
  description = "Custom tags to set on the Instances in the ASG"
  type = map(string)
  default = {}
}

variable "enable_autoscaling" {
  description = "If set to true, enable auto scaling"
  type = bool
}

variable "ami" {
  description = "The AMI to run in the cluster"
  type = string
  default = "ami-0866a3c8686eaeeba"
}

variable "server_text" {
  description = "The text the web server should return"
  type = string
  default = "Hello, World"
}

