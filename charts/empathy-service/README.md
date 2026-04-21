# empathy-service

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.27.0](https://img.shields.io/badge/AppVersion-1.27.0-informational?style=flat-square)

Generic Helm chart for deploying a single HTTP-style workload (`Deployment` + `Service`) with optional classic `Ingress`, optional [Gateway API](https://gateway-api.sigs.k8s.io/) `HTTPRoute` (internal/public), autoscaling (HPA or KEDA), observability (Prometheus Operator), External Secrets, RBAC, and NetworkPolicy.

## Prerequisites

- Kubernetes **1.25+**
- Optional: [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator) CRDs for `ServiceMonitor` / `PodMonitor` / `PrometheusRule`
- Optional: [External Secrets Operator](https://external-secrets.io/) CRDs
- Optional: [KEDA](https://keda.sh/)
- Optional: [Gateway API](https://gateway-api.sigs.k8s.io/) CRDs (`gateway.networking.k8s.io`, e.g. v1) for `HTTPRoute` resources

## Quick start

```bash
helm install myapp ./charts/empathy-service \
  --set image.repository=myorg/myapp \
  --set image.tag=1.0.0
```

## Key design choices

- **Flattened values** (workload settings at the top level; `service` is only the Kubernetes `Service`).
- **Secure defaults** for `podSecurityContext` / `containerSecurityContext` (override as needed for your image).
- **No canary / blue-green** (standard `Deployment` rolling updates only).
- **No allow-all `NetworkPolicy`** when disabled (cluster default applies).
- **Secrets** are not rendered as Helm-managed `Secret` objects; use External Secrets (`externalSecrets.*`) and reference the resulting secrets via `envFrom` (`secretRef`) or volumes.

## Helm test

When `tests.enabled` is `true` (default), `helm test` runs a pod that curls the in-cluster `Service` URL.

## Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nameOverride | string | `""` | Override chart name (name label / resource prefix). |
| fullnameOverride | string | `""` | Override fully qualified app name. |
| commonLabels | object | `{}` | Labels applied to all resources. |
| replicaCount | int | `1` | Static replica count (ignored if HPA or KEDA is enabled). |
| image.registry | string | `""` | Image registry (optional). |
| image.repository | string | `nginxinc/nginx-unprivileged` | Image repository. |
| image.tag | string | `1.27-alpine` | Image tag (set to `""` to fall back to `Chart.AppVersion`). |
| image.digest | string | `""` | Image digest (mutually exclusive with tag in rendered image ref). |
| image.pullPolicy | string | `IfNotPresent` | Image pull policy. |
| service.type | string | `ClusterIP` | Kubernetes Service type. |
| service.ports | list | `[{name:http,port:8080,...}]` | Service ports (names must match `containerPorts` when using string `targetPort`). |
| containerPorts | list | `[{name:http,containerPort:8080,...}]` | Ports on the main container. |
| ingress.enabled | bool | `true` | Master switch: when `false`, no `Ingress` resources are created. |
| ingress.internal.enabled | bool | `false` | Create an internal `Ingress` (requires `ingress.enabled`, `ingressClassName` default: `internal`). |
| ingress.public.enabled | bool | `false` | Create a public `Ingress` (requires `ingress.enabled`, `ingressClassName` default: `public-nlb`). |
| httpRoutes.enabled | bool | `true` | Master switch: when `false`, no `HTTPRoute` resources are created. |
| httpRoutes.internal.enabled | bool | `false` | Create an internal `HTTPRoute` (requires `httpRoutes.enabled` and `httpRoutes.internal.parentRefs`). |
| httpRoutes.public.enabled | bool | `false` | Create a public `HTTPRoute` (requires `httpRoutes.enabled` and `httpRoutes.public.parentRefs`). |
| autoscaling.enabled | bool | `false` | Create an `HorizontalPodAutoscaler` (mutually exclusive with `autoscaling.keda.enabled`). |
| autoscaling.keda.enabled | bool | `false` | Create a KEDA `ScaledObject` (mutually exclusive with `autoscaling.enabled`). |
| pdb.enabled | bool | `true` | Create a `PodDisruptionBudget` when effective min replicas > 1. |
| metrics.serviceMonitor.enabled | bool | `false` | Create a `ServiceMonitor` (requires a matching port name on the Service, default `metrics` or `metrics.portName`). |
| metrics.podMonitor.enabled | bool | `false` | Create a `PodMonitor`. |
| metrics.prometheusRule.enabled | bool | `false` | Create a `PrometheusRule` when extra rules are provided. |
| externalSecrets.secretStores | list | `[]` | `SecretStore` / `ClusterSecretStore` definitions (`spec` is passed through). |
| externalSecrets.items | list | `[]` | `ExternalSecret` definitions (`spec` is passed through). |
| extraObjects | list | `[]` | Extra manifests (YAML string or object, passed through `tpl`). |

See [values.yaml](values.yaml) for the complete list and inline comments.

## Upgrading from `motive-service`

This chart uses **flattened** values (not `service.replicaCount`, `service.image`, etc.). Migrate by moving keys to the top level. **Ingress** and **HTTPRoute** each expose `enabled` (master) plus `internal` / `public` toggles. When `httpRoutes.*.rules` is empty, a default rule sends traffic to this release’s `Service` on `service.ports[0].port`.

## License

See repository [LICENSE](../../LICENSE) if present.
