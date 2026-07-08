This example shows how to configure Azure MySQL Flexible Server with Entra ID (Active Directory) authentication.

MySQL Flexible Server requires a **user-assigned managed identity** for Entra authentication. The identity is attached to the server via the `identity` block and referenced in `ad_admin.identity_id`. The module grants that identity the **Directory Readers** Entra role so the server can resolve user identities at login time.

* `ad_admin.identity_id` — resource ID of the user-assigned identity (passed to the AD admin resource)
* `ad_admin.principal_id` — principal object ID of the same identity (used for the Directory Readers role assignment)
* `ad_admin.login` — display name of the Entra principal (user, group, or service principal) to set as admin
* `ad_admin.object_id` — object ID of the admin principal in Entra ID

**Note**: The Terraform principal running this must have either the `RoleManagement.ReadWrite.Directory` application role (for a Service Principal) or the `Privileged Role Administrator` / `Global Administrator` directory role (for a User Principal) to assign Directory Readers to the managed identity.
