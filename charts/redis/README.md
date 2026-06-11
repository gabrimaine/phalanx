# redis

Redis Helm chart

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| container.port | int | `6379` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"redis"` |  |
| image.tag | string | `"8.0.3"` |  |
| nameOverride | string | `"redis"` |  |
| persistence.size | string | `"8Gi"` |  |
| replicaCount | int | `1` |  |
| resources.limits.cpu | string | `"500m"` |  |
| resources.limits.memory | string | `"192Mi"` |  |
| resources.requests.cpu | string | `"250m"` |  |
| resources.requests.memory | string | `"128Mi"` |  |
| securityContext.runAsUser | int | `1003790000` |  |
| service.enabled | bool | `true` |  |
