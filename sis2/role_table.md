1. Declare a role table.
a) What roles/groups of users will be in your system?

| Role                  | Description                                          | Permissions                                                      | Superuser permissions                                                                            |
| --------------------- | ---------------------------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| **devops_engineer**   | Infrastructure owner, manages deployments via GitHub | Read/write in `/var/www/blog`  <br>Git access  <br>Docker access | Install Nginx, Hugo, Docker  <br>Manage services (`systemctl`)  <br>Configure UFW  <br>Setup SSL |
| **monitoring_system** | For Prometheus                                       | Read `/proc` and `/sys` metrics  <br>Access Prometheus DB        | None                                                                                             |
| **logging_system**    | For Loki                                             | Read logs                                                        | None                                                                                             |
2. Create all groups and at least one user for each role.
![[Pasted image 20251001230237.png]]
3. Get a permission for all groups
![[Pasted image 20251001230919.png]]
![[Pasted image 20251001230933.png]]

4. Setting up SSH connection.

![[Pasted image 20251001224210.png]]
![[Pasted image 20251001230855.png]]
