# Variable "Rg"

This variable `Rg` is a map type variable which contains objects with two attributes: `name` (string) and `location` (string). The default value for this variable is set to a map with a single entry for "R":

```hcl
variable "Rg" {
  type = map(object({
    name     = string
    location = string
  }))
  default = {
    "R" = {
      name     = "qwertyui"
      location = "west us"
    }
  }
}
```

## Resource Creation

The `azurerm_resource_group` resource named "example" is created using the values provided in the variable `Rg`.

```hcl
resource "azurerm_resource_group" "example" {
  for_each  = var.Rg
  name      = each.value.name
  location  = each.value.location
}
```

## Generating Terraform Documentation

To automatically generate documentation for the Terraform variable and resource using `terraform-docs`, you can run the following command:

```bash
terraform-docs markdown table --output-file README.md --output-mode inject
```

After running the above command, the README.md file will be updated with a markdown table that includes the information about the variable `Rg` and the resource `azurerm_resource_group`.

Please make sure to run the `terraform-docs` command in the same directory where your Terraform configurations are located.

Process finished with exit code 0
