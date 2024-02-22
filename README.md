## App Service Plan Module

### Table of Contents
1. [Description](#description)
2. [Files](#files)
3. [Variables](#variables)
4. [Outputs](#outputs)
5. [Usage](#usage)

---

### 1. Description <a name="description"></a>

This Terraform module creates Azure App Service Plans based on the provided configuration.

---

### 2. Files <a name="files"></a>

1. **App_Service_Plan/main.tf**
2. **App_Service_Plan/variables.tf**
3. **App_Service_Plan/output.tf**

---

### 3. Variables <a name="variables"></a>
**1. `App_Service_Plan` (in `variables.tf`)**

| Name                         | Description                                                                                           | Type           | Default      |
| -----------------------------|-------------------------------------------------------------------------------------------------------|----------------|--------------|
| `appservicename`              | Name of the App Service                                                                               | string         | -            |
| `resource_group_name`         | Azure Resource Group in which the App Service Plan will be created                                     | string         | -            |
| `location`                    | Location for the App Service Plan                                                                      | string         | East US      |
| `os_type`                     | Operating System type for the App Service Plan                                                         | string         | Windows      |
| `sku_name`                    | SKU name of the App Service Plan                                                                       | string         | -            |
| `maximum_elastic_worker_count` | Maximum elastic worker count for the App Service Plan                                                 | number         | -            |
| `per_site_scaling_enabled`     | Flag to enable per site scaling on the App Service Plan                                                | bool           | false        |
| `worker_count`                 | Number of workers for the App Service Plan                                                             | number         | 1            |
| `zone_balancing_enabled`       | Flag to enable zone balancing on the App Service Plan                                                   | bool           | false        |
| `app_service_environment_id`   | ID of the App Service Environment for the App Service Plan                                              | string         | -            |
| `enable_timeouts`              | Flag to enable timeouts for the App Service Plan                                                       | bool           | -            |
| `create/read/update/delete` | Timeout values for creating, reading, updating, and deleting the App Service Plan                     | string         | -            |
| `enable_tags`                  | Flag to enable tagging for the App Service Plan                                                        | bool           | -            |
| `tags`                        | Tags for the App Service Plan                                                                          | object         | -            |

**2. `Terraform.tfvars`**

```tfvars
app_Service_Plan = {
  "demo-product" = {
    "appservicename"               = "appserviceplan09871234567"
    "resource_group_name"          = "Test-AB1" 
    "location"                     = "north europe"
    "os_type"                      = null
    "sku_name"                     = "B1"
    "maximum_elastic_worker_count" = null
    "per_site_scaling_enabled"     = null
    "worker_count"                 = null
    "zone_balancing_enabled"       = null
    "app_service_environment_id"   = null
    "enable_timeouts"              = false
    "timeouts" = {
      "create" = ""
      "read"   = ""
      "update" = ""
      "delete" = ""
    }
    "enable_tags" = false
    "tags" = {
      "Environment" = "Dev"
      "Owner"       = "Abdul"
      "Operations_Team" = "PlatForm_Team"
      "Bussiness_Criticality" = "low"
      "Work_Load" = "Terraform_Poc"
    }
  }
}
```

---

### 4. Outputs <a name="outputs"></a>

1. **app_Service_Plan_id**
   - Description: App Service Plan Id's
   - Value: { for k, v in azurerm_service_plan.example : k => v.id }

2. **App_Service_Plan_kind**
   - Description: App Service Plan Kind
   - Value: { for k, v in azurerm_service_plan.example : k => v.os_type }

3. **App_Service_Plan_Sku_Name**
   - Description: App Service Plan Sku name
   - Value: { for k, v in azurerm_service_plan.example : k => v.sku_name }

---

### Usage <a name="usage"></a>

```hcl
module "app_Service_plan_M" {
  source           = "./App_Service_Plan"
  app_Service_Plan = var.app_Service_Plan
  depends_on       = [module.Resource_Groups_M]
}
```

Please ensure you have provided all necessary variables and tags as mentioned in the `Terraform.tfvars` file.

--- 

This readme.md file provides a detailed overview of the files and configuration used in the App Service Plan module. Feel free to reach out in case of any queries.

Process finished with exit code 0
