## terraform guidelines

### Use dierctory for Environment Isolation

I use directory structure house a terraform envrionment.

When I am in a terraform environment directory, I am only applying change to resources in the directory.

I can re-factor code in a directory focusing only on the resources defined in the directory.

### Avoid using workspace

I avoid using workspace. 

- it requires to identify and set a `tfvar` file to defined the target environment it effects on.

- changing a `tf` file impacts resources in multiple environments, 

  - on merging the code and applying to one environment, the other environment is immediately out-of-sync with the code. For example, one may only wish to update version of a resource (or a module) to `dev` environment, immediately making `prod` environment out-of-sync with code.

  - any modification needs to consider its impact to all environments. Not an easy task.

### Avoid using git branch to map to each terraform environment

### Use locals instead of variable environment setting

I keep all environment setting in one file `locals.tf`. When applying, no parameter is required, i.e. one less possibility to make mistake. 

Using variable, need to define same information twice at

- variable in `tf` file

- `tfvar` file
  
Applying require to identify the `tfvar` to use.


### terraform environment directory structure

### statefile path mirror directory path

### single statefile location for all repository

### no mixing of declarative and procedural

### Use human undestanable resource name
Use data element

### Avoid Referencing via statefile

### keep code flat

### module set version

### Use repo for module




