# Module: Azurerm Resource Group

This Terraform module creates an Azure Resource Group based on the specified input parameters.

## Variables

### Rg

This variable is of type map with object elements containing the following properties:
- `name`: (string) The name of the resource group.
- `location`: (string) The location where the resource group will be created.

The default value of this variable is set to a map with a single element:
- Key: "R"
  - `name`: "qwertyui"
  - `location`: "west us"

## Resources

### azurerm_resource_group.example

This resource will create an Azure Resource Group based on the settings provided in the `var.Rg` variable. It will iterate over each element in the map and create a resource group with the specified `name` and `location`.

## Example Usage

```hcl
module "example_rg" {
  source = "path/to/module"

  Rg = {
    "R1" = {
      name = "example-rg1"
      location = "east us"
    },
    "R2" = {
      name = "example-rg2"
      location = "west europe"
    }
  }
}
```

In this example, two Azure Resource Groups will be created based on the values provided in the `Rg` variable.

## Author

Submitted by: [Your Name]

## License

This module is licensed under the [MIT License](link-to-license).
