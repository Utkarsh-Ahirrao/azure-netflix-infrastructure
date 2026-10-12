data "azurerm_subnet" "data-subnet" {
    for_each = var.var-vm
    name                 = each.value.sub_name
    virtual_network_name = each.value.virtual_network_name
    resource_group_name  = each.value.resource_group_name
}
data "azurerm_public_ip" "data-pubip" {
    for_each = var.var-vm
    name                = each.value.pubip_name
    resource_group_name = each.value.resource_group_name
}

#NSG Association 
data "azurerm_network_security_group" "data-nsg" {
  for_each = var.var-vm

  name                = each.value.nsg_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_interface" "prod-nic" {
    for_each = var.var-vm
    name = each.value.nic_name
    resource_group_name = each.value.resource_group_name
    location = each.value.location
    ip_configuration {
    name                          = each.value.ipconf_name
    subnet_id                     = data.azurerm_subnet.data-subnet[each.key].id
    public_ip_address_id          = data.azurerm_public_ip.data-pubip[each.key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}

resource "azurerm_network_interface_security_group_association" "prod-nic-nsg" {
  for_each = var.var-vm

  network_interface_id     = azurerm_network_interface.prod-nic[each.key].id
  network_security_group_id = data.azurerm_network_security_group.data-nsg[each.key].id
}

resource "azurerm_virtual_machine" "prod-vm"{
    for_each = var.var-vm
    name                  = each.value.vm_name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.prod-nic[each.key].id]
  vm_size               = each.value.vm_size

  storage_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }

  storage_os_disk {
    name              = each.value.os_name
    caching           = each.value.caching
    create_option     = each.value.create_option
    managed_disk_type = each.value.managed_disk_type
  }

  os_profile {
    computer_name  = each.value.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = each.value.disable_password_authentication
  }
}