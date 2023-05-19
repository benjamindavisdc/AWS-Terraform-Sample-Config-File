# Bootstrap Sample Terraform AWS Instance Provisioning

This repository contains the necessary Terraform code to provision an AWS instance with a specific VPC, security group, and user data, giving you a quickstart template to run a simple webpage.

## Prerequisites

Before using this Terraform configuration, make sure you have the following:

- An AWS account with the necessary permissions to create resources.
- Terraform installed on your local machine.

## Usage

Follow the instructions below to provision the AWS instance using Terraform:

1. Clone this repository to your local machine.
2. Navigate to the cloned repository's directory:

```shell
$ cd repository-directory
```
Open the main.tf file and update the values as per your requirements. Specifically, ensure the AWS region, VPC ID, security group settings, and AMI ID are correct.

Provide your public key in the public_key field of the aws_key_pair.deployer resource block. Replace the *Key* placeholder with your public key.

If required, update the userdata.yaml file with your desired user data for the instance.

Initialize the Terraform configuration by running the following command:

```shell
$ terraform init
```

Preview the resources that will be created by executing the following command:
```shell
$ terraform plan
```

If the plan looks satisfactory, apply the Terraform configuration:
```shell
$ terraform apply
```

Terraform will prompt for confirmation. Type yes and press Enter to proceed.

Wait for Terraform to provision the AWS resources. Once completed, it will output the public IP address of the newly created server.

Access your instance using SSH by running the following command:

```shell
$ ssh -i /path/to/private/key.pem ec2-user@<public_ip>
```

Replace /path/to/private/key.pem with the path to your private key file and <public_ip> with the actual public IP address obtained from the Terraform output.

You now have access to your AWS instance and can start using it according to your requirements.
Cleanup
To clean up and destroy the created AWS resources, follow the steps below:

Open your terminal and navigate to the cloned repository's directory.

Run the following command to destroy the provisioned resources:

```shell
$ terraform destroy
```

Terraform will prompt for confirmation. Type yes and press Enter to proceed.

Wait for Terraform to remove the AWS resources.

Notes
Ensure that you have appropriate AWS credentials configured on your system. You can set them up using environment variables, shared credentials file, or AWS CLI configuration.

Modify the security group settings in the aws_security_group.sg_my_server resource block to allow access only from trusted sources. Update the cidr_blocks and ipv6_cidr_blocks as per your requirements.

Customize the userdata.yaml file to include any necessary configuration or setup scripts for your instance.

Review and update the ami and instance_type values in the aws_instance.ben_server resource block based on your desired AMI and instance type.
