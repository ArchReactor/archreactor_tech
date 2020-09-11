## OpenID endpoints

[https://users.archreactor.net/auth/realms/archreactor/.well-known/openid-configuration](https://users.archreactor.net/auth/realms/archreactor/.well-known/openid-configuration)

## Ldap settings in Keycloack

Provider ID
0edad132-d110-4ade-afbd-5067e3793815
Enabled
ON
Console Display Name
ldap
Priority
0
Import Users
OFF
Edit Mode

Sync Registrations
ON

- Vendor
  Active Directory
- Username LDAP attribute
  cn
- RDN LDAP attribute
  cn
- UUID LDAP attribute
  objectGUID
- User Object Classes
  person, organizationalPerson, user
- Connection URL
  ldap://10.42.20.143
- Users DN
  cn=users,dc=ad,dc=archreactor,dc=net
- Bind Type

Enable StartTLS
OFF

- Bind DN
  cn=Administrator,cn=users,dc=ad,dc=archreactor,dc=net
- Bind Credential

---

Custom User LDAP Filter
(samaccounttype=805306368)
Search Scope

Validate Password Policy
OFF
Trust Email
ON
Use Truststore SPI

Connection Pooling
ON
Connection Timeout
10000
Read Timeout
30000
Pagination
ON
Kerberos Integration
Allow Kerberos authentication
OFF
Use Kerberos For Password Authentication
OFF
Sync Settings
Batch Size
1000
Periodic Full Sync
ONOFF
Full Sync Period
86400
Periodic Changed Users Sync
ONOFF
Changed Users Sync Period
18000
Cache Settings
Cache Policy
