# App Service Plan Module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.91.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.91.0 |


## Description
This Terraform module creates Azure App Service Plans based on the provided configuration.

## Files
1. **main.tf**
```hcl
# Define Azure Service Plan resources based on input variables
resource "azurerm_service_plan" "example" {
  for_each                     = var.app_Service_Plan
  name                         = replace(format("%s-%s-%s", each.key, each.value.appservicename, each.value.location), " ", "")
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  os_type                      = each.value.os_type
  sku_name                     = each.value.sku_name
  maximum_elastic_worker_count = each.value.maximum_elastic_worker_count
  per_site_scaling_enabled     = each.value.per_site_scaling_enabled
  worker_count                 = each.value.worker_count
  zone_balancing_enabled       = each.value.zone_balancing_enabled
  app_service_environment_id   = each.value.app_service_environment_id

  dynamic "timeouts" {
    for_each = each.value.enable_timeouts == false ? [] : [each.value.timeouts]
    content {
      create = timeouts.value.create
      read   = timeouts.value.read
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }

  tags = merge({ "ResourceName" = format("%s", each.value.appservicename) }, each.value.tags)
}
```

2. **variables.tf**
```hcl
variable "app_Service_Plan" {
  type = map(object({
    appservicename               = string
    resource_group_name          = string
    location                     = optional(string, "East US")
    os_type                      = optional(string, "Windows")
    sku_name                     = string
    maximum_elastic_worker_count = number
    per_site_scaling_enabled     = optional(bool, false)
    worker_count                 = optional(number, 1)
    zone_balancing_enabled       = optional(bool, false)
    app_service_environment_id   = string
    enable_timeouts              = bool
    timeouts = object({
      create = string
      read   = string
      update = string
      delete = string
    })
    enable_tags = bool
    tags = object({
      Environment           = string
      Owner                 = string
      Operations_Team       = string
      Bussiness_Creticality = string
      Work_Load             = string
    })
  }))
  default = {
  }
  
  validation {
    condition = length(flatten([for key, value in var.app_Service_Plan : [for k, v in value.tags : k if v == "" || v == null]])) == 0
    error_message = "One or more required tags are missing values. Please check."
  }
}
```

3. **output.tf**
```hcl
output "app_Service_Plan_id" {
  description = "App Service Plan Id's"
  value       = { for k, v in azurerm_service_plan.example : k => v.id }
}

output "App_Service_Plan_kind" {
  description = "App Service Plan Kind"
  value       = { for k, v in azurerm_service_plan.example : k => v.os_type }
}

output "App_Service_Plan_Sku_Name" {
  description = "App Service Plan Sku name"
  value = { for k, v in azurerm_service_plan.example : k => v.sku_name }
}
```

## Usage
```hcl
module "app_Service_plan_M" {
  source           = "./App_Service_Plan"
  app_Service_Plan = var.app_Service_Plan
  depends_on       = [module.Resource_Groups_M]
}

```

4. **terraform.tfvars**
```hcl
app_Service_Plan = {
  "demo-product" = {
    appservicename               = "appserviceplan09871234567"
    resource_group_name          = "Test-AB1"
    location                     = "north europe"
    os_type                      = null
    sku_name                     = "B1"
    maximum_elastic_worker_count = null
    per_site_scaling_enabled     = null
    worker_count                 = null
    zone_balancing_enabled       = null
    app_service_environment_id   = null
    enable_timeouts              = false
    timeouts = {
      create = ""
      read   = ""
      update = ""
      delete = ""
    }
    enable_tags = false
    tags = {
      Environment           = "Dev"
      Owner                 = "Abdul"
      Operations_Team       = "Platform_Team"
      Business_Criticality  = "low"
      Work_Load             = "Terraform_POC"
    }
  }
}
```

## Variable Requirements

| Argument              | Required | Description                                                                                                                                                                                                                                               |
|-----------------------|:--------:|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `name`                |   Yes    | The name which should be used for this Service Plan. Changing this forces a new App Service to be created.                                                                                                                                               |
| `location`            |   Yes    | The Azure Region where the Service Plan should exist. Changing this forces a new App Service to be created.                                                                                                                                               |
| `os_type`             |   Yes    | The Operating System type for the App Services to be hosted in this plan. Possible values include `Windows`, `Linux`, and `WindowsContainer`. Changing this forces a new resource to be created.                                                         |
| `resource_group_name` |   Yes    | The name of the Resource Group where the App Service should exist. Changing this forces a new App Service to be created.                                                                                                                                  |
| `sku_name`            |   Yes    | The SKU for the plan. Possible SKUs include `B1`, `B2`, `B3`, `D1`, `F1`, `I1`, `I2`, `I3`, `I1v2`, `I2v2`, `I3v2`, `I4v2`, `I5v2`, `I6v2`, `P1v2`, `P2v2`, `P3v2`, `P0v3`, `P1v3`, `P2v3`, `P3v3`, `P1mv3`, `P2mv3`, `P3mv3`, `P4mv3`, `P5mv3`, `S1`, `S2`, `S3`, `SHARED`, `EP1`, `EP2`, `EP3`, `WS1`, `WS2`, `WS3`, and `Y1`. |
| `tags`                |   Yes    | A mapping of tags which should be assigned to the App Service. Common required tags include: `Owner` (the person or team responsible for the service), `Environment` (e.g., `Production`, `Staging`, `Dev`), `Operations_Team` (team responsible for operations), `Business_Criticality` (importance of the service, e.g., `Critical`, `Important`, `Normal`), and `Work_Load` (type of workload, e.g., `Web`, `API`, `Background`). |

Note: Isolated SKUs (`I1`, `I2`, `I3`, `I1v2`, `I2v2`, and `I3v2`) can only be used with App Service Environments. Elastic and Consumption SKUs (`Y1`, `EP1`, `EP2`, and `EP3`) are for use with Function Apps.


## Notes
- Ensure all required tags are provided in the `terraform.tfvars` file to prevent validation errors.

| Variable Name | Description | Required |
|---------------|-------------|----------|
| app_Service_Plan | Map containing details of app service plans to create | Yes |
| appservicename | Name of the App Service | Yes |
| resource_group_name | Name of the Resource Group | Yes |
| location | Location where the App Service Plan should be created | No (default: East US) |
| os_type | Operating System for the App Service | No (default: Windows) |
| sku_name | SKU type for the plan | Yes |
| maximum_elastic_worker_count | Maximum number of elastic workers | Yes |
| per_site_scaling_enabled | Enable per-site scaling | No (default: false) |
| worker_count | Number of workers | No (default: 1) |
| zone_balancing_enabled | Enable zone balancing | No (default: false) |
| app_service_environment_id | ID of the app service environment | Yes |
| enable_timeouts | Enable timeouts | Yes |
| timeouts | Timeout configurations | Yes |
| enable_tags | Enable tagging | Yes |
| tags | Tags for the App Service Plan | Yes |


Process finished with exit code 0
