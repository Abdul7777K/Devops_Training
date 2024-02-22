```markdown
# App Service Plan Module.

## Overview
This Terraform module creates Azure App Service Plans based on the provided configurations. The module allows for customization of various settings such as location, operating system type, SKU name, worker counts, timeouts, and tags.

## Files
1. **main.tf**
   - Contains the main configuration for creating Azure App Service Plans.
   
   **Variables:**
   - `app_Service_Plan`: Map object containing configurations for each App Service Plan.

2. **variables.tf**
   - Defines the input variables for the module.

   **Input Variables:**
   - `app_Service_Plan`: Map object defining the configurations for Azure App Service Plans.

3. **output.tf**
   - Contains the output configurations for the module.
   
   **Outputs:**
   - `app_Service_Plan_id`: Ids of the created App Service Plans.
   - `App_Service_Plan_kind`: Operating system type of the App Service Plans.
   - `App_Service_Plan_Sku_Name`: SKU name of the App Service Plans.

4. **terraform.tfvars**
   - Variables file containing configurations for the Azure App Service Plans.

## Usage
To use this module, provide the configurations in the `terraform.tfvars` file. An example configuration is provided below in a markdown table format.

| app_Service_Plan | demo-product                                     |
|------------------|--------------------------------------------------|
| appservicename   | "appserviceplan09871234567"                      |
| resource_group_name | "Test-AB1"                                      |
| location         | "north europe"                                   |
| os_type          | null                                             |
| sku_name         | "B1"                                             |
| maximum_elastic_worker_count | null                              |
| per_site_scaling_enabled | null                                |
| worker_count     | null                                             |
| zone_balancing_enabled | null                                   |
| app_service_environment_id | null                             |
| enable_timeouts  | false                                            |
| timeouts         | create = "", read = "", update = "", delete = "" |
| enable_tags      | false                                            |
| tags             | Environment = "Dev", Owner = "Abdul", Operations_Team = "PlatForm_Team", Bussiness_Creticality = "low", Work_Load = "Terraform_Poc" |

## Dependencies
The module may depend on other modules or resources. Ensure proper dependencies are defined to ensure successful execution.

## Notes
- Make sure to define all mandatory tags as per the set standards.
- Modify the configurations based on your specific requirements.

For any additional information or support, refer to the Terraform documentation or contact the module maintainer.
```

Process finished with exit code 0
