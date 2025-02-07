variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "VPN-rg"
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "MyVNet"
}

variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "gateway_subnet_name" {
  description = "The name of the gateway subnet"
  default     = "GatewaySubnet"
}

variable "gateway_subnet_prefix" {
  description = "The address prefix for the gateway subnet"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "gateway_ip_name" {
  description = "The name of the public IP for the gateway"
  type        = string
  default     = "MyGatewayIP"
}

variable "vpn_gateway_name" {
  description = "The name of the VPN gateway"
  type        = string
  default     = "MyVpnGateway"
}

variable "vpn_gateway_sku" {
  description = "The SKU of the VPN gateway"
  type        = string
  default     = "VpnGw1"
}

variable "vpn_client_address_space" {
  description = "The address space for the VPN client"
  type        = list(string)
  default     = ["172.16.0.0/24"]
}

variable "vpn_connection_name" {
  description = "The name of the VPN connection"
  type        = string
  default     = "MyVpnConnection"
}

variable "shared_key" {
  description = "The shared key for the VPN connection"
  type        = string
  default     = "YourSharedKey"
}