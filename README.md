# Zero-downtime deployment
Typically we need at least two environments: one for your team's internal testing ("Staging") and one that real users can access("production"). Ideally, the two environments are nearly identical, though you might run slightly fewer/smaller servers in staging to save money.

## The infrastructure
![Infrastructure](images/infrastructure.png)
![Infrastructure](images/infrastructure.png)

### Problem
How do you add this production environment without having to copy and
paste all of the code from staging? For example, how do you avoid having
to copy and paste all the code in stage/services/webserver-cluster into
prod/services/webserver-cluster and all the code in stage/data-stores/mysql
into prod/data-stores/mysql?

## Solution (Modules)
With Terraform, you can put your code inside of a Terraform module and
reuse that module in multiple places throughout your code. Instead of
having the same code copied and pasted in the staging and production
environments, you’ll be able to have both environments reuse code from the
same module.
