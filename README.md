# Variable Description

## Rg

The `Rg` variable is a map variable that contains objects with the following attributes:
- **name**: A string value representing the name of the resource group.
- **location**: A string value representing the location of the resource group.

The default value for the `Rg` variable is as follows:

| Key | Value                                |
|-----|--------------------------------------|
| R   | {"name": "qwertyui", "location": "west us"} |

# Resource Creation

The `azurerm_resource_group` resource named `example` is created using the values provided in the `Rg` variable.

| Attribute | Description                                      |
|-----------|--------------------------------------------------|
| for_each   | Iterates over each element in the `Rg` variable. |
| name      | Sets the name of the resource group.             |
| location  | Sets the location of the resource group.         |

## Example Code

```hcl
resource "azurerm_resource_group" "example" {
  for_each = var.Rg
  name     = each.value.name
  location = each.value.location
}
```

Please let me know if you need any further clarification or assistance.

Process finished with exit code 0
