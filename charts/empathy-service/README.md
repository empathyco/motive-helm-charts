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
- **Secrets** are not rendered as Helm-managed `Secret` objects; use External Secrets (`externalSecrets.items`) and reference the resulting secrets via top-level `envFrom` (`secretRef`), per-item `mountAsEnvFrom: true` (auto `secretRef`), or volumes.

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
| service.port | int | `8080` | Primary app port (named `http` on the container and Service). |
| service.metricsPort | int/string | `""` | Optional metrics port (named `metrics`). `""` or `0` for no separate port; set equal to `service.port` to serve metrics on the app port only. |
| ingress.enabled | bool | `true` | Master switch: when `false`, no `Ingress` resources are created. |
| ingress.internal.enabled | bool | `false` | Create an internal `Ingress` (requires `ingress.enabled`, `ingressClassName` default: `internal`). |
| ingress.public.enabled | bool | `false` | Create a public `Ingress` (requires `ingress.enabled`, `ingressClassName` default: `public-nlb`). |
| httpRoutes.enabled | bool | `true` | Master switch: when `false`, no `HTTPRoute` resources are created. |
| httpRoutes.internal.enabled | bool | `false` | Create an internal `HTTPRoute` (requires `httpRoutes.enabled` and `httpRoutes.internal.parentRefs`). |
| httpRoutes.public.enabled | bool | `false` | Create a public `HTTPRoute` (requires `httpRoutes.enabled` and `httpRoutes.public.parentRefs`). |
| autoscaling.enabled | bool | `false` | Create an `HorizontalPodAutoscaler` (mutually exclusive with `autoscaling.keda.enabled`). |
| autoscaling.keda.enabled | bool | `false` | Create a KEDA `ScaledObject` (mutually exclusive with `autoscaling.enabled`). |
| pdb.enabled | bool | `true` | Create a `PodDisruptionBudget` when effective min replicas > 1. |
| metrics.serviceMonitor.enabled | bool | `true` | Create a `ServiceMonitor`. |
| metrics.serviceMonitor.port | string | _(omit)_ | Service port **name** to scrape (`http` or `metrics`). When omitted or empty, defaults to `metrics` if a distinct metrics port exists, otherwise `http`. |
| metrics.podMonitor.enabled | bool | `false` | Create a `PodMonitor`. |
| metrics.podMonitor.port | string | _(omit)_ | Pod port **name** to scrape; same semantics as `metrics.serviceMonitor.port`. |
| metrics.prometheusRule.enabled | bool | `false` | Create a `PrometheusRule` when extra rules are provided. |
| externalSecrets.enabled | bool | `true` | When `true`, render `ExternalSecret` resources if the cluster advertises ESO CRDs (`external-secrets.io/v1` or `v1beta1`). |
| externalSecrets.items | list | `[]` | One `ExternalSecret` per list entry. Required: `name`, `secretStoreRef.name`. Optional: `labels`, `annotations`, `refreshInterval` (default `1h`), `secretStoreRef.kind` (default `ClusterSecretStore`), `target.name` (default `<fullname>-<name>`), `target.creationPolicy` (default `Owner`), `data`, `dataFrom` (can combine both), `mountAsEnvFrom` (append `secretRef` to the pod). |
| extraObjects | list | `[]` | Extra manifests (YAML string or object, passed through `tpl`). |

See [values.yaml](values.yaml) for the complete list and inline comments.

### External Secrets example

Mixed `dataFrom` (whole remote secret as keys) and `data` (single property), with automatic `envFrom` wiring:

```yaml
externalSecrets:
  enabled: true
  items:
    - name: app-secrets
      mountAsEnvFrom: true
      secretStoreRef:
        name: my-cluster-store
      dataFrom:
        - extract:
            key: myapp/prod
      data:
        - secretKey: EXTRA
          remoteRef:
            key: myapp/prod
            property: extra_key
```

## Upgrading from `motive-service`

This chart uses **flattened** values (not `service.replicaCount`, `service.image`, etc.). Migrate by moving keys to the top level. **Ingress** and **HTTPRoute** each expose `enabled` (master) plus `internal` / `public` toggles. When `httpRoutes.*.rules` is empty, a default rule sends traffic to this release’s `Service` on `service.port` (the `http` port).

## License

See repository [LICENSE](../../LICENSE) if present.
