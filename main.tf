resource "azurerm_resource_group" "rg" {
  name     = "vpn-rg"
  location = "central us"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vpn-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet"
    address_prefix = "10.0.1.0/24"
  } 
}