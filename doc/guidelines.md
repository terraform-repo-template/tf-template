## terraform guidelines

- [terraform guidelines](#terraform-guidelines)
  - [Use directory for Environment Isolation](#use-directory-for-environment-isolation)
    - [Directory](#directory)
    - [Workspace](#workspace)
    - [Git branch](#git-branch)
  - [Use locals instead of variable environment setting](#use-locals-instead-of-variable-environment-setting)
  - [terraform environment directory structure](#terraform-environment-directory-structure)
    - [multi-environment repository](#multi-environment-repository)
    - [Single environment repository](#single-environment-repository)
  - [statefile path mirror directory path](#statefile-path-mirror-directory-path)
  - [Single statefile location for all environments](#single-statefile-location-for-all-environments)
  - [No mixing of declarative and procedural](#no-mixing-of-declarative-and-procedural)
  - [Use human undestanable resource name](#use-human-undestanable-resource-name)
  - [Avoid Referencing via statefile](#avoid-referencing-via-statefile)
  - [Keep code flat](#keep-code-flat)
  - [Module set version](#module-set-version)
  - [Use repo for module](#use-repo-for-module)
  - [Constant module](#constant-module)
  - [No overlapping resources in multiple environments](#no-overlapping-resources-in-multiple-environments)

### Use directory for Environment Isolation

I prefer using directory over terraform workspace or git branch for terraform environment isolation.

#### Directory

Changing files in a directory only applies to resources defined in the terraform file in the directory. This is useful when refactor, adding resources and changing module version.

Using directory for environment isolation has added advantage; when I am in a terraform environment directory, I am only applying change to resources in the directory.

#### Workspace

Using workspace, 

- requires to set workspace which is usually not immediately obvious and visible.

- it requires to identify and set a `.tfvar` file to set the target environment it effects on.

- changing a `tf` file impacts resources in multiple environments, 

  - on merging the code and applying to one environment, the other environment is immediately out-of-sync with the code. For example, one may only wish to update version of a resource (or a module) to `dev` environment, immediately making `prod` environment out-of-sync with code.

  - any modification needs to consider its impact to all environments. Not an easy task.

####  Git branch

I prefer to have single source of truth in master (or main) branch. Using git branch for different environment messy and difficult to manage.

### Use locals instead of variable environment setting

I keep all environment setting in one file `locals.tf`. User has a single place to look to change settings.

When applying, no parameter is required at terraform command, i.e. one does not need to find the right `.tfvars` file eliminating one possibility to make mistake. 

At coding level, using terraform variable, one need to define same information twice at

- variable in `tf` file

- `.tfvars` file
  
Running `terraform plan` or `terraform apply` requires to identify the correct `.tfvars` to use.


### terraform environment directory structure

#### multi-environment repository

Most repository has multiple terraform environments.

I keep terraform environment under `/env` at repository root level.

Within `/env` directory, I use directory structure to fully qualified a terraform environment.

For AWS

- `/env/${aws-account}/${region}/${additional-qualifier-if-required}`

e.g. for my eks cluster

- `/env/non-prod/ap-southeast-2/eks-dev`

e.g. for my iam which is region-less in AWS

- `/env/non-prod`

In GCP, project name is unique, so I can normally have

- `/env/${project-name}`

#### Single environment repository

In situation that a repository only has a single terraform environment, put terraform files at repository root directory

### statefile path mirror directory path

I mirror terraform environment directory structure in terraform remote statefile.

For aws s3 backend,
```json
  backend "s3" {
    bucket = "${s3-bucket-to-store-statefile}"
    key    = "${git-repository-name}/env/${mirror-sub-directory-structure}"
    ...
  }
```

e.g.
```json
  backend "s3" {
    bucket = "my-tf-statefile"
    key    = "tf-eks/env/non-prod/ap-southeast-2/eks-dev"
    ...
  }
```

### Single statefile location for all environments

To allow for one central place to look for statefiles, I prefer to keep all statefiles in one place, e.g. in aws s3 bucket (or artifactory or GCP storage).

### No mixing of declarative and procedural

Declarative and procedure coding are two distinct different scheme. Each demands different kind of thinking, requires different setup, has different sets of quirks, issues, and solutions.

Mixing them creates an additional set of quirks and issues to resolve.

I avoid mising them to keep terraform code simple.

For example, I avoid using `null_resource` to run procedural code (e.g. bash script) in the middle of a terraform apply. So far, I can run a separate bash script after an environment is created by terraform.

### Use human undestanable resource name

I avoid using cryptic name to specify an environment.

e.g. a subnet id `subnet-123456` does not provide meaning.

In most situation, I can use terraform's `data` element with name, tags and other attributes to get id of a resource.

### Avoid Referencing via statefile

I try to keep each terraform environment independent. I avoid referencing another terraform environment's output via its statefile.

### Keep code flat

I like to have all `.tf` files in a directory. I avoid using nested module which make the code complex.

e.g.
`main.tf`
```tf
module "folder" {
  source = "./modules/folder"

  ...
}

```

In earlier version of terraform, it was not easy to work with nested data-structure; using nested module was one way to get around this. This is no longer an issue since.

### Module set version

Whenever

### Use repo for module

### Constant module

### No overlapping resources in multiple environments




