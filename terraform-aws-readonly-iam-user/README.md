# Terraform AWS Readonly IAM User Module

This module creates read-only IAM users in AWS and assigns them to a group, along with the necessary policies attached to the users to provide them with read-only access.

## Usage


## Inputs

| Name          | Description                              | Type          | Default | Required |
|---------------|------------------------------------------|---------------|---------|----------|
| IAM-ro-users  | Set of IAM user names to create          | set(string)    | n/a     | yes      |

## Outputs

| Name             | Description                     |
|------------------|---------------------------------|
| iam_user_names   | List of IAM user names           |
| iam_group_name   | Name of the IAM group            |

## License

This code is licensed under the MIT License. See [LICENSE](LICENSE) for full details.

# Terraform Module: My Module

This is version ${var.version} of my Terraform module.