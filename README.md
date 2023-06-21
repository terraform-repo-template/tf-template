# tf-template

- [tf-template](#tf-template)
  - [Principles](#principles)
    - [Source of Truth](#source-of-truth)
    - [Isolation](#isolation)
    - [Code Independent](#code-independent)
    - [No mixing of declarative and procedural code](#no-mixing-of-declarative-and-procedural-code)
  - [Directory structure](#directory-structure)



I use Terraform for Infrastructure-as-Code (IaC). I use some common-sense principles and guidelines derived from my practices over the years. This repository is a template of a a typical terraform environment.

## Principles

### Source of Truth

The reason of IaC is to have infrastructure created represented in code so that we can view it in code and create or recreate if so required.

With source control tools such as git, we can track changes we make to an environment.

With tool such as terraform, we can detect deviation between code and target environment. i.e. changes in either the code or target environment can be detected.

### Isolation

An IaC developer should feel safe when changes he make is isolated to the environment he is working on, and not impact other environments or resources. 

For example, changing `eks-dev` terraform environment does not impact `eks-prod` etrraform environment.

For example, adding user `joe` to group `developer` does not kick out another user `harry` from the group.

### Code Independent

As much as possible, I try to keep each terraform environment code independent.

For example, I avoid reference another environment output through statefile. Generally I can reference a resource through terraform's `data` element.

### No mixing of declarative and procedural code

Declarative and procedure coding demand different kind of thinking; each require different setup, and have different sets of problems and solutions. 

I avoid mising them to keep terraform code simple.

For example, I avoid using `null_resource` to run procedural code (e.g. bash script) in the middle of a terraform apply. So far, I can run a separate bash script after an environment is created by terraform.


## Directory structure

For AWS, I use

`env/${aws_account_name}/${region}/${environment_name_if_required}`

For GCP, most environments are housed in project, this

`env/${project_name}`


TODOs:
- docker: env-terraform-aws