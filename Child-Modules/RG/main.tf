resource "azurerm_resource_group" "prod-rg"{
    for_each = var.var_rg
    name = each.value.name
    location = each.value.location
}