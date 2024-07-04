resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.region
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]

  #   subnet {
  #     name           = "subnet"
  #     address_prefix = "10.0.1.0/24"
  #   }
}

resource "azurerm_subnet" "Gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "vpn-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"

}

resource "azurerm_virtual_network_gateway" "vpn-gateway" {
  name                = "vpn-gateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku  = "Basic"
  type = "Vpn"

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.pip.id
    subnet_id                     = azurerm_subnet.Gateway.id
    private_ip_address_allocation = "Dynamic"
  }

}