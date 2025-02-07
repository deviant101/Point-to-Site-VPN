# Point-to-Site VPN Deployment on Azure using Terraform

This project provides Terraform configurations to deploy a Point-to-Site VPN on Azure. The deployment includes creating a resource group, virtual network, VPN gateway, and VPN connection.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- An Azure account with the necessary permissions to create resources.
- A root certificate file (`rootCA.crt`) for the VPN client configuration.

## Project Structure

- `main.tf`: Contains the main Terraform configuration for the resources.
- `variables.tf`: Defines the variables used in the Terraform configuration.
- `provider.tf`: Specifies the required provider and its version.
- `outputs.tf`: Defines the outputs of the Terraform configuration.
- `.gitignore`: Specifies files and directories to be ignored by Git.
- `generate-certificates.sh`: Script to generate self-signed certificates.

## Steps to Deploy

1. **Clone the Repository**

   ```sh
   git clone https://github.com/deviant101/Point-to-Site-VPN.git
   cd Point-to-Site-VPN
   ```

2. **Generate Self-Signed Certificates**

   Run the script to generate self-signed certificates:

   ```sh
   ./generate-certificates.sh
   ```

   This will create the `rootCA.crt` file required for the VPN client configuration.

3. **Initialize Terraform**

   Initialize the Terraform configuration:

   ```sh
   terraform init
   ```

4. **Review the Execution Plan**

   Review the execution plan to ensure everything is set up correctly:

   ```sh
   terraform plan
   ```

5. **Apply the Configuration**

   Apply the Terraform configuration to create the resources:

   ```sh
   terraform apply
   ```

6. **Verify the Deployment**

   After the deployment is complete, you can verify the resources in the Azure portal.

## Using the VPN

1. **Download the VPN Client Configuration**

   After the deployment, download the VPN client configuration from the Azure portal.

2. **Install the VPN Client**

   Install the VPN client on your local machine using the downloaded configuration.

3. **Connect to the VPN**

   Use the installed VPN client to connect to the VPN. You should now have access to the resources in the virtual network.

## Variables

The following variables are defined in `variables.tf`:

- `location`: The location of the resources (default: `eastus`).
- `resource_group_name`: The name of the resource group (default: `VPN-rg`).
- `vnet_name`: The name of the virtual network (default: `MyVNet`).
- `vnet_address_space`: The address space of the virtual network (default: `["10.0.0.0/16"]`).
- `gateway_subnet_name`: The name of the gateway subnet (default: `GatewaySubnet`).
- `gateway_subnet_prefix`: The address prefix for the gateway subnet (default: `["10.0.0.0/24"]`).
- `gateway_ip_name`: The name of the public IP for the gateway (default: `MyGatewayIP`).
- `vpn_gateway_name`: The name of the VPN gateway (default: `MyVpnGateway`).
- `vpn_gateway_sku`: The SKU of the VPN gateway (default: `VpnGw1`).
- `vpn_client_address_space`: The address space for the VPN client (default: `["172.16.0.0/24"]`).
- `vpn_connection_name`: The name of the VPN connection (default: `MyVpnConnection`).
- `shared_key`: The shared key for the VPN connection (default: `YourSharedKey`).

## Outputs

The following outputs are defined in `outputs.tf`:

- `resource_group_name`: The name of the resource group.
- `vnet_name`: The name of the virtual network.
- `vpn_gateway_public_ip`: The public IP address of the VPN gateway.
- `vpn_gateway_name`: The name of the VPN gateway.
- `vpn_connection_name`: The name of the VPN connection.

## Cleanup

To remove the resources created by this Terraform configuration, run:

```sh
terraform destroy
```

## License

This project is licensed under the [MIT License](LICENSE).