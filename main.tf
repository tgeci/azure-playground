# Create a Remote Backend
terraform {
  backend "azurerm" {
    storage_account_name = "aujxci04mterraform"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"

  }
}

# Configure the Azure Provider
provider "azurerm" {
  version = "=1.22.0"
}

# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "rg_test" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"

  tags {
    environment = "test"
  }
}

resource "azurerm_policy_assignment" "pa_test" {
  name                 = "example-policy-assignment"
  scope                = "${azurerm_resource_group.rg_test.id}"
  policy_definition_id = "${var.policy_definition_id}"
  description          = "Policy Assignment created by Terraform"
  display_name         = "Policy Assignment CIS"
}