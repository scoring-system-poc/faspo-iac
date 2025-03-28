# FASPO IaC

This repository contains the Infrastructure as Code (IaC) for the FASPO project. 
It uses Terraform in combination with GitHub Actions to manage and automatically deploy the infrastructure in MS Azure.

---

For each Azure environment following must be defined:

* has its own protected branch with `env/` prefix (e.g. `env/poc`, `env/dev`, ...)
* has its own GH environment matching its branch name (with secrets for Azure login and Terraform config)
* has its own Azure subscription (where permissions for GHA must be set)
* contains Terraform definitions in `./terraform/` directory

---

**WARNING**: Azure subscription for the entire project (i.e. environment) must be created manually through 
the Azure portal

For convenience, directory [./_iac](./_iac) contains Terraform definitions that can be run manually 
(by user with necessary permissions) to prepare the environment for the IaC deployment. This includes:

* creating application, service principal and federated credentials (in Azure AD) for GHA deploying the IaC
* setting necessary RBAC for the GHA service principal to modify resources in the subscription
* creating several resource groups
* creating a storage account for Terraform state and giving necessary permissions to the GHA service principal
* creating a private vNet and setting up integration to custom GHA runners
