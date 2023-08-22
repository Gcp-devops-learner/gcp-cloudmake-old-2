# GKE-Cloudmake: Terraform for GKE

## The tools that you need

### [tfenv](https://github.com/tfutils/tfenv): Terraform version manager
`brew install tfenv`

### [terraformer](https://github.com/GoogleCloudPlatform/terraformer): Generate tf file from existing resources
`brew install terraformer`

### [tflint](https://github.com/terraform-linters/tflint): A Terraform Linter
`brew install tflint`

## How to create a new project:
### Add the new project for formlabs.com/project-factory/projects.tf and deploy it

### Create a new folder with the following structure
`gcp-cloudmake/formlabs.com/(Folder structure in GCP)/(Env)/(Project)`

### Add the common backend and variable files
`ln -sf $(realpath --relative-to=$(PWD) $(git rev-parse --show-toplevel)/backend.tf) .`
`ln -sf $(realpath --relative-to=$(PWD) $(git rev-parse --show-toplevel)/globals.tf) .`

# Set the previously created project ID in the locals.tf
```
locals {
  project_id = "terraform-89df"
}
```

# Use this ID in the provider.tf
```
provider "google" {
  project = local.project_id
  region  = "us-east1"
}
```

### Create versions.tf file with the latest versions
# If you add a change in this project please make sure that you are using the latest versions
```
terraform {
  required_version = "1.3.4"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.43"
    }
  }
}
```

## How to use a Terraform project

### Init the project with the common config
`terraform init -backend-config="prefix=${${PWD#$(git rev-parse --show-toplevel)}:1}"`

### Making your changes

### Format your code
`terraform fmt .`

### View your changes
`terraform plan`

### After everything is good, create a Pull-Request for it

## How to import existing resource:

### Init your project

### Write Terraform config for resource(s) to be imported
You can also able to generate terraform config from existing resource with [terraformer](https://github.com/GoogleCloudPlatform/terraformer/blob/master/docs/gcp.md) This tool also generate the statefile with your terrafrom resourcees under your project into `generated` directory. You need to add the generated resources to the project. You need to clean up the config, remove not manageble parameters, default values, the terraform-related values and set proper name for the generate resource.

### Import your exist resource
[Import command](https://www.terraform.io/cli/commands/import)
`terraform import <resource_address> <resource_id>`
You can find which resource_id is needed for your resource in the provider documentation

### After the import you need to check the differences between the config and the deployed one
If there any, you need to change the config until you get only tags or terraform-related differences
# gcp-cloudmake-old
# gcp-cloudmake-old-2
