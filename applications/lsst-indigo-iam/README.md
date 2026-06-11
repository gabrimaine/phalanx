# lsst-indigo-iam

Indigo-IAM for LSST Community

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| container | object | `{"port":8080,"portDebug":1443}` | Container port configuration |
| database | object | `{"host":"mariadb-svc","name":"lsst_iam","port":3306,"secretName":"mariadb-secret"}` | Database configuration |
| global | object | `{"baseUrl":null,"environmentName":null,"host":null,"iam":{"ingress":{"serviceName":"iam-ingress"},"serviceName":"iam-svc"},"mariadb":{"serviceName":"mariadb-svc"},"redis":{"host":"localhost","port":6379,"serviceName":"redis-svc"},"repertoireUrl":null,"vaultSecretsPath":null}` | Global configuration shared across subcharts |
| global.baseUrl | string | `nil` | Base URL for the environment |
| global.environmentName | string | `nil` | Environment name |
| global.host | string | `nil` | Redis host |
| global.iam | object | `{"ingress":{"serviceName":"iam-ingress"},"serviceName":"iam-svc"}` | IAM service configuration |
| global.mariadb | object | `{"serviceName":"mariadb-svc"}` | MariaDB service configuration |
| global.redis | object | Set by Argo CD | Host name for ingress |
| global.repertoireUrl | string | `nil` | Repertoire URL |
| global.vaultSecretsPath | string | `nil` | Base path for Vault secrets |
| iam | object | `{"cache":{"redisEnabled":"true"},"host":null,"javaOpts":"-Dspring.profiles.active=prod,oidc,mysql,registration,redis","jwt":"wlcg","logo":{"url":"https://doc.lsst.eu/_static/lsst-france-logo.png"},"organisation":"Vera C. Rubin Observatory","port":8080,"redis":{"host":"redis-svc","port":6379},"security":{"forwardHeaders":"native"},"session":{"storeType":"redis"},"token":{"includeAuthnInfo":"false","includeNbf":"false","includeScope":"true","scopes":"openid profile email"},"tokenValidity":259200,"topbar":"INDIGO IAM for Rubin Observatory Community"}` | IAM service core configuration |
| iam.redis | object | `{"host":"redis-svc","port":6379}` | Redis connection for the IAM service |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"indigoiam/iam-login-service","tag":"v1.12.3"}` | Image configuration |
| image.tag | string | `"v1.12.3"` | Tag of the IAM login service image to use |
| ingress | object | `{"enabled":true,"host":null,"path":"/"}` | Ingress configuration |
| ingress.path | string | `"/"` | Path prefix for the ingress |
| mail | object | `{"host":"zrelay.in2p3.fr","port":"25","secretName":"mail-secret"}` | Mail configuration |
| mariadb | object | See the `values.yaml` file. | MariaDB configuration |
| mariadb.image | object | `{"tag":"11.4"}` | Image configuration |
| mariadb.image.tag | string | `"11.4"` | Tag of the MariaDB image to use |
| mariadb.mariadb | object | `{"database":"lsst_iam","enabled":true}` | MariaDB core configuration |
| mariadb.mariadb.database | string | `"lsst_iam"` | Database name |
| mariadb.mariadb.enabled | bool | `true` | Enable MariaDB |
| mariadb.persistentvolume | object | `{"class":"","create":false,"reclaimPolicy":"Retain","size":"5Gi"}` | Persistent volume configuration |
| mariadb.replicaCount | int | `1` | Number of replicas |
| mariadb.resources | object | `{"limits":{"cpu":"1","memory":"256Mi"},"requests":{"cpu":"500m","memory":"128Mi"}}` | Resource requests and limits |
| oidc | object | `{"enabled":false}` | OIDC configuration |
| redis | object | See the `values.yaml` file. | Redis configuration |
| redis.enabled | bool | `true` | Enable Redis |
| redis.persistence | object | `{"storageClass":""}` | Persistent storage configuration |
| redis.persistence.storageClass | string | Cluster default | Storage class for the Redis PVC |
| redis.service | object | `{"enabled":true}` | Service configuration |
| replicaCount | int | `3` | Number of replicas |
| resources | object | `{"limits":{"cpu":"1","memory":"2Gi"},"requests":{"cpu":"1","memory":"1.5Gi"}}` | Resource requests and limits |
| securityContext | object | `{"runAsUser":"1003790000"}` | Security context |
