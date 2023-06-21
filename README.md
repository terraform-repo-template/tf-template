# tf-template

A template for terraform repository.

Example based on AWS. 

## Directory structure

For AWS, I use

`env/${aws_account_name}/${region}/${environment_name_if_required}`

For GCP, most environments are housed in project, this

`env/${project_name}`


TODOs:
- docker: env-terraform-aws