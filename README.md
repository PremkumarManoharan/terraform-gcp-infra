# Terraform VPC Module for Google Cloud

This Terraform module provisions resources in Google Cloud Platform (GCP).

## Prerequisites

Before you begin, ensure you have the following prerequisites satisfied:

- Terraform installed on your local machine. [Download Terraform](https://www.terraform.io/downloads.html)
- An active GCP account with an existing project.
- Google Cloud SDK installed and initialized on your machine. [Install Google Cloud SDK](https://cloud.google.com/sdk)
- Adequate permissions within your GCP project to create and manage VPCs, subnets, and routing.

## Configuration Details

Create Terraform configurations defined within a `terraform.tfvars` file. Below is an example of the expected structure:(fill appropiate values in the below tfvars)

```hcl
region = ""
project_name = ""

vpcs = [ 
  {
    vpc_name = ""
    vpc_auto_create_subnetworks = false
    vpc_routing_mode = ""
    vpc_delete_default_routes_on_create = true
    subnets = [ 
      {
        name          = ""
        ip_cidr_range = ""
      },
      {
        name          = ""
        ip_cidr_range = ""
      },
    ]
    routes = [ 
      {
        name             = ""
        dest_range       = ""
        next_hop_gateway = ""
      } 
    ]
  }
]
```
# Usage Instructions

To use this Terraform module for deploying resources to Google Cloud Platform, please follow the steps below:

1. **Clone the repository**: Clone this repository to your local machine using your preferred Git client.

    ```
    git clone <repository-url>
    ```

2. **Navigate to the directory**: Change into the directory where the repository has been cloned.

    ```
    cd <cloned-repository-directory>
    ```

3. **Initialize Terraform**: Run the following command to initialize the Terraform environment, which will download the necessary plugins and modules.

    ```
    terraform init
    ```

4. **Plan your deployment**: Execute the following command to review the changes that Terraform plans to make to your infrastructure.

    ```
    terraform plan
    ```

5. **Apply the changes**: Apply the changes to your GCP project by running:

    ```
    terraform apply
    ```

## APIs Required

Ensure that the following Google Cloud APIs are enabled for your project:

- **Compute Engine API (`compute.googleapis.com`)**: Required for managing Virtual Private Clouds (VPCs), subnets, and routes.

You can enable these APIs in the GCP Console or by using the `gcloud` command:

```sh
gcloud services enable compute.googleapis.com
