# prompt-proto-service-lsstcomcam

Deployment for prompt proto service for LSSTComCam images

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| prompt-proto-service.apdb.db | string | `"lsst-devl"` |  |
| prompt-proto-service.apdb.ip | string | `""` |  |
| prompt-proto-service.apdb.namespace | string | `"pp_apdb"` |  |
| prompt-proto-service.apdb.user | string | `"rubin"` |  |
| prompt-proto-service.image.pullPolicy | string | `"IfNotPresent"` |  |
| prompt-proto-service.image.repository | string | `"ghcr.io/lsst-dm/prompt-proto-service"` |  |
| prompt-proto-service.image.tag | string | `"latest"` |  |
| prompt-proto-service.imageNotifications.imageTimeout | string | `"120"` |  |
| prompt-proto-service.imageNotifications.kafkaClusterAddress | string | `""` |  |
| prompt-proto-service.imageNotifications.topic | string | `""` |  |
| prompt-proto-service.instrument.calibRepo | string | `""` |  |
| prompt-proto-service.instrument.name | string | `""` |  |
| prompt-proto-service.instrument.pipelines | string | `""` |  |
| prompt-proto-service.instrument.skymap | string | `""` |  |
| prompt-proto-service.knative.ephemeralStorageLimit | string | `"20Gi"` |  |
| prompt-proto-service.knative.ephemeralStorageRequest | string | `"20Gi"` |  |
| prompt-proto-service.knative.idleTimeout | int | `900` |  |
| prompt-proto-service.knative.responseStartTimeout | int | `900` |  |
| prompt-proto-service.knative.timeout | int | `900` |  |
| prompt-proto-service.podAnnotations | object | `{"autoscaling.knative.dev/max-scale":"30","autoscaling.knative.dev/min-scale":"3","autoscaling.knative.dev/target-burst-capacity":"-1","autoscaling.knative.dev/target-utilization-percentage":"60","revision":"1"}` | Annotations for the prompt-proto-service pod |
| prompt-proto-service.registry.db | string | `"lsstdb1"` |  |
| prompt-proto-service.registry.ip | string | `""` |  |
| prompt-proto-service.registry.user | string | `"rubin"` |  |
| prompt-proto-service.s3.auth_env | bool | `true` |  |
| prompt-proto-service.s3.disableBucketValidation | string | `"0"` |  |
| prompt-proto-service.s3.endpointUrl | string | `""` |  |
| prompt-proto-service.s3.imageBucket | string | `""` |  |
| prompt-proto-service.vaultSecretsPath | string | `"secret/rubin/usdf-prompt-processing-dev/prompt-proto-service-lsstcomcam"` |  |