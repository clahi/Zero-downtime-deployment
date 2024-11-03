# output "first_arn" {
#   value = module.user[0].user_arn
#   description = "The ARN for the first user"
# }

# output "all_arns" {
#   value = module.user[*].user_arn
#   description = "The ARNs for all users"
# }

output "all_arns" {
  value = values(module.user)[*].user_arn
}
