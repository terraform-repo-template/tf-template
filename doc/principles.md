## Principles

- [Principles](#principles)
  - [Source of Truth](#source-of-truth)
  - [Environment Isolation (i.e. feeling of safe)](#environment-isolation-ie-feeling-of-safe)
  - [Keep Code simple](#keep-code-simple)

### Source of Truth

The reason of IaC is to have infrastructure created represented in code.

The aims are:

- able to recreate target environment resources.
  
- able to use git source control to track changes to resources in an environment.

- able to use terraform to detect changes to resources not effected through code


### Environment Isolation (i.e. feeling of safe)

Keep each terraform environment code isolated from others.

The aims are:

- to feel **safe** when working in one terraform environment; not impacting resources in other environments

- able to always keep code in sync with target environment

- avoid wrong apply to other environments

### Keep Code simple

Apply general coding principle of keeping code simple and independent. 