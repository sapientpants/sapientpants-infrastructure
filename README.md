# sapientpants-infrastructure

## Local setup

~/.aws/credentials

```
[sapientpants-organization]
aws_access_key_id = AWS_ACCESS_KEY_ID
aws_secret_access_key = AWS_SECRET_ACCESS_KEY
```

### Sapientpants Organization

From the `accounts/organization` folder:

```
awsudo -u sapientpants-organization terraform init -var-file=../../organization.tfvars
```

```
awsudo -u sapientpants-organization terraform plan -var-file=../../organization.tfvars
```

```
awsudo -u sapientpants-organization terraform apply -var-file=../../organization.tfvars
```
