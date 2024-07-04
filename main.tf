resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.region
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnet"
    address_prefix = "10.0.1.0/24"
  }
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

resource "azurerm_point_to_site_vpn_gateway" "P2S" {
  name                        = "P2S-vpn"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name

    connection_configuration {
      name = "connection-configuration"

      vpn_client_address_pool {
        address_prefixes = [ "192.100.20.0/24" ]

      }
    }
  scale_unit                  = 1       # 1 scale unit has 500 concurrent connections
  virtual_hub_id = azurerm_virtual_hub.virtual-hub.id
  vpn_server_configuration_id = azurerm_vpn_server_configuration.vpn-server-config.id
  
}

resource "azurerm_virtual_hub" "virtual-hub" {
  name = "virtual-hub"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  virtual_wan_id = azurerm_virtual_wan.virual-wan.id
  address_prefix = "10.0.0.0/23"

}
resource "azurerm_virtual_wan" "virual-wan" {
  name = "virtual-wan"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_vpn_server_configuration" "vpn-server-config" {
  name = "vpn-server-config"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  vpn_authentication_types = ["Certificate"]
    client_root_certificate {
    name = "root-cert"
    public_cert_data = # will create certificate later
    }
  

}