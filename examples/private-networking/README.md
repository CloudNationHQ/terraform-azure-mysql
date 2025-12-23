# Private Networking

This example demonstrates how to deploy a MySQL Flexible Server with private networking (VNet integration) for enhanced security.

## Features

- **VNet Integration**: Subnet delegation for MySQL Flexible Server
- **Private DNS Zone**: Azure Private DNS for private endpoint connectivity
- **Public Access Disabled**: Server is only accessible from within the VNet
- **Secure by Default**: No public internet exposure

## Architecture

The MySQL server is deployed into a delegated subnet within a virtual network and uses a private DNS zone for name resolution. Public network access is explicitly disabled, ensuring the database is only accessible from resources within the VNet or connected networks (via VPN/ExpressRoute).

## Prerequisites

- A virtual network with a subnet that will be delegated to MySQL
- A private DNS zone for `privatelink.mysql.database.azure.com`
- VNet link between the private DNS zone and the virtual network

## Production Considerations

- Ensure your application resources are in the same VNet or a peered VNet
- Configure NSG rules on the delegated subnet if additional access control is needed
- Consider using a VPN Gateway or ExpressRoute for administrative access
- The delegated subnet cannot be used for other resources

## Related Examples

- [default](../default/) - Basic deployment with public access
- [complete](../complete/) - Comprehensive example with multiple features
