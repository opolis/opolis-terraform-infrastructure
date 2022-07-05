# Opolis Terraform Infrastructure 

This is a proposal for a new style of managing AWS infrastructure with Terraform/Terragrunt.

- Based on commonly recommended AWS Organizations structure for managing multiple AWS accounts.
    - Better management of delegating policies across different scopes of your organization. 
    - Multiple accounts reduce blsst radius across environments.
    - Easier audit trail of activity based on scope of operations.
    - Easier means to track resource and services costs.

![orgchart](https://i.imgur.com/lb0s7Rk.png)

- With the use of terragrunt:
    - Resource states are decoupled and less prone to conflicts, less monolithic.
    - Allows for better versioning of IaC.
    - Code is now more DRY with common variables now dynamically generated.

