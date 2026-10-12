rg = {
  rg1 = {
    name     = "azlz-prod-rg"
    location = "centralindia"
  }
}

stgacc = {
  stg1 = {
    name                     = "stgaccut07"
    resource_group_name      = "azlz-prod-rg"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

vnet = {
  vnet1 = {
    name                = "azlz-prod-vnet"
    resource_group_name = "azlz-prod-rg"
    location            = "centralindia"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet = {
  subnet1 = {
    name                 = "azlz-prod-subnet"
    virtual_network_name = "azlz-prod-vnet"
    resource_group_name  = "azlz-prod-rg"
    address_prefixes     = ["10.0.1.0/24"]
  }
}

nsg = {
  nsg1 = {
    name                = "azlz-prod-nsg"
    resource_group_name = "azlz-prod-rg"
    location            = "centralindia"

    sr_name                    = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
}

pubip = {
  pubip1 = {
    name                = "azlz-prod-pubip"
    resource_group_name = "azlz-prod-rg"
    location            = "centralindia"
    allocation_method   = "Static"
  }
}

vm = {
  vm1 = {
    sub_name             = "azlz-prod-subnet"
    virtual_network_name = "azlz-prod-vnet"

    pubip_name = "azlz-prod-pubip"

    nsg_name = "azlz-prod-nsg"

    nic_name            = "azlz-prod-nic"
    resource_group_name = "azlz-prod-rg"
    location            = "centralindia"

    ipconf_name                   = "internal"
    private_ip_address_allocation = "Dynamic"

    vm_name = "azlz-prod-vm"
    vm_size = "Standard_B2ats_v2"

    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"

    os_name           = "azlz-prod-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"

    computer_name  = "azlz-prod-comp"

    disable_password_authentication = false
  }
}