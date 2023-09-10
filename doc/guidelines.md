## terraform guidelines

- [terraform guidelines](#terraform-guidelines)
  - [Use folder-based Environment Isolation](#use-folder-based-environment-isolation)
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
  - [Reference Module with specific version](#reference-module-with-specific-version)
  - [Use repository for custom module](#use-repository-for-custom-module)
  - [Constant module](#constant-module)
  - [A repository for defining a type of resources](#a-repository-for-defining-a-type-of-resources)

### Use folder-based Environment Isolation

Folder based environment isolation is simple and able to keep code in-sync with target environment. Changes to code for an environment does not impact code for other environments or made them out-of-sync with their environments.

### Use locals instead of variable environment setting

I keep all environments setting for an environment in one file `locals.tf`. User has a single place to look for an environment specific settings.

When applying, no parameter is required at terraform command, i.e. one does not need to find the right `.tfvars` file eliminating one possibility to make mistake. 

At coding level, using terraform variable, one needs to define same information twice at

- variable in `tf` file

- `.tfvars` file

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

In situation that a repository only has a single terraform environment, I put terraform files at repository root directory

### statefile path mirror directory path

I mirror terraform environment directory structure in terraform remote statefile.

For aws s3 backend,
```json
  backend "s3" {
    bucket = "${s3-bucket-for-statefile}"
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

To allow for one central place to look for statefiles, I keep all statefiles in one place, e.g. in aws s3 bucket (or artifactory or GCP storage).

### No mixing of declarative and procedural

Declarative and procedure coding are two distinct coding scheme. Each demands different kind of thinking, requires different setup, has different sets of quirks, issues, and solutions.

Mixing them creates an additional set of quirks and issues to resolve.

I avoid mising them to keep terraform code simple.

For example, I avoid using `null_resource` to run procedural code (e.g. bash script) in the middle of a terraform apply. So far, I can run a separate bash script after an environment is created by terraform.

### Use human undestanable resource name

I avoid using cryptic name to specify an environment.

e.g. a subnet id `subnet-123456` does not provide meaning.

In most situation, I can use terraform's `data` element with name, tags and other attributes to get id or arn of a resource.

### Avoid Referencing via statefile

I try to keep each terraform environment independent. I avoid referencing another terraform environment's output via its statefile.

### Keep code flat

I like to have all `.tf` files in a directory. I avoid using nested module which make the code complex.

In earlier version of terraform, it was not easy to work with complex data-structure; using nested module was one way to get around this. This is no longer an issue since.

### Reference Module with specific version

Whenever using a module, I reference it with specific version for consistent outcome.

### Use repository for custom module

For custom terraform module, I use a repository. This allow versioning of the module.

### Constant module

I use a constant module for organization-wide constants.

### A repository for defining a type of resources

I generally have a single place to create resources that need to be centrally managed. For example, I put all iam related resources (roles, policies and users) in a repository named `tf-iam`.




