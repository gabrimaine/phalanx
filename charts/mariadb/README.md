# mariadb

MariaDB Helm chart

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| container.port | int | `3306` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"bitnami/mariadb"` |  |
| image.tag | string | `"11.8.2"` |  |
| initdbScript.configMap | string | `"mariadb-init-script"` |  |
| initdbScript.key | string | `"data"` |  |
| mariadb.database | string | `""` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.rootPassword.key | string | `"root-password"` |  |
| mariadb.rootPassword.secret | string | `"mariadb-secret"` |  |
| mariadb.user.key | string | `"user"` |  |
| mariadb.user.secret | string | `"mariadb-secret"` |  |
| mariadb.userPassword.key | string | `"user-password"` |  |
| mariadb.userPassword.secret | string | `"mariadb-secret"` |  |
| nameOverride | string | `"mariadb"` |  |
| persistentvolume.hostPath | bool | `true` |  |
| persistentvolume.local | bool | `false` |  |
| persistentvolume.path | string | `"/tmp/data/mariadb"` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
