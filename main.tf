resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  subnet {
    name            = var.gateway_subnet_name
    address_prefixes = var.gateway_subnet_prefix
  }
}

resource "azurerm_public_ip" "gateway_ip" {
  name                = var.gateway_ip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = var.vpn_gateway_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  active_active       = false
  enable_bgp          = false
  sku                 = var.vpn_gateway_sku

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.gateway_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_virtual_network.vnet.subnet[0].id
  }

  vpn_client_configuration {
    address_space = var.vpn_client_address_space

    root_certificate {
      name            = "root-cert"
      public_cert_data = filebase64("${path.module}/rootCA.crt")
    }
  }
}

resource "azurerm_virtual_network_gateway_connection" "vpn_connection" {
  name                       = var.vpn_connection_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway.id
  type                       = "IPsec"
  connection_protocol        = "IKEv2"
  shared_key                 = var.shared_key
}