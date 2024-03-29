# Proxmox Terraform Repo

This repository will serve as the storage location as well as a beginner friendly introduction to using Terraform by building resources in Proxmox. Proxmox is an open source server solution similar to ESXi and useful for homelabbers.

## File Structure
The file structure for this repo is as follows:

```
.
├── README.md
└── landing_zones
    ├── Linux
    │   └── ubuntu
    │       └── main.tf
    └── test_vm
        ├── main.tf
        ├── terraform.tfstate
        ├── terraform.tfstate.backup
        └── variables.tf
```

Directories are not static and may change over time depending on requirements for the project structure.

## Getting Started

### Installing Terraform

To install terraform on your machine, follow [these](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) instructions on the Hashicorp website. 

### Cloning the Github repo
1. Open a terminal or command prompt
2. Change current working directory where you want the cloned directory
3. Type `git clone`, and then paste this URL https://github.com/ZYQ9/proxmox-terraform.git
   `git clone https://github.com/ZYQ9/proxmox-terraform.git`
4. This will clone the repository to your local machine

### Setting up Proxmox for Terraform

Once you have Terraform installed on your machine, ssh into your proxmox server and perform the following:

```
pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt"
pveum user add terraform-prov@pve --password <password>
pveum aclmod / -user terraform-prov@pve -role TerraformProv
```

>**NOTE:** The documentation on how and why we are creating this user with these roles can be found in the Terraform Registry documentation for the Telmate Proxmox provider [here](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)

### Setting up the .env file

In order for Terraform to authenticate properly to your Proxmox server, we need to give it log on credentials as specified in the following block of code:

```
provider "proxmox" {
    pm_api_url = var.PM_API_URL
    pm_user = var.PM_USER
    pm_password = var.PM_PASS
}
```

This block is pulled directly from the `main.tf` file in the `test_vm` directory. We need to create a `.env` file in the root directory of our repo and enter the following code:

```
export TF_VAR_PM_API_URL="https://<Your Proxmox IP or Hostname>:8006/api2/json"
export TF_VAR_PM_USER="terraform-prov@pve"
export TF_VAR_PM_PASS="<Password for the account you created>"
```

This allows us to store our credentials without having to leave them in plaintext in the terraform code.

## Running the code

### Preparing the `.env` file

The `.env` file will need to be sourced every time you want to build a VM currently. TO do this, open a terminal and run the following command: `source .env`. 

### Running the Terraform

1. Initialize Terraform with the `terraform init` command
2. Run the `terraform plan` command to see what resources will be created
3. Run the `terraform apply` command to build the resources. You will be prompted for the values for the required variables. All other values will remain their default value in the `variables.tf` file. If you would like to modify those variables you can do so with the `terraform apply -var="<variable>=<value>` command.
   
   **EX:** `terraform apply -var="memory=4096"`

### Destroying a resource
To destroy a VM that was created by terraform all you have to do is issue the `terraform destroy` command and go through the prompts.

## Planned Changes

* Modify code to allow for different ISOs to be used
* Create a script to automatically run the terraform code and source the ENV file.
* General improvements to code