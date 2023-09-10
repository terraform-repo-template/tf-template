## Principles

- [Principles](#principles)
  - [Source of Truth](#source-of-truth)
  - [Environment Isolation](#environment-isolation)
  - [Keep Code simple](#keep-code-simple)

### Source of Truth

The reason of IaC is to have infrastructure represented in code.

With Infrastructure represented in code, one is:

- able to recreate target environment resources.
  
- able to use git source control to track changes made to resources in an environment.

- able to use terraform to detect changes to resources not effected through code


### Environment Isolation

Keep each terraform environment code isolated from others.

The aims are:

- not impacting resources in other environments;

- able to always keep code in sync with target environment

### Keep Code simple

Apply general coding principle of keeping code simple and independent. 