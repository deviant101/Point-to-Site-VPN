output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "vpn_gateway_public_ip" {
  description = "The public IP address of the VPN gateway"
  value       = azurerm_public_ip.gateway_ip.ip_address
}

output "vpn_gateway_name" {
  description = "The name of the VPN gateway"
  value       = azurerm_virtual_network_gateway.vpn_gateway.name
}

output "vpn_connection_name" {
  description = "The name of the VPN connection"
  value       = azurerm_virtual_network_gateway_connection.vpn_connection.name
}