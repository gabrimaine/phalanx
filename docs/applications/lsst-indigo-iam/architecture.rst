Architecture
============

The deployment consists of three workload types:

* A **StatefulSet** with three replicas running the IAM login service
  and optional VOMS sidecar containers.
* A **Deployment** (single replica) for MariaDB with a persistent volume.
* A **StatefulSet** (single replica) for Redis with a persistent volume.

.. code-block:: text

   Namespace: lsst-indigo-iam

   ┌─ StatefulSet (replicas: 3) ─────────────────────-─────-┐
   │  Init (VOMS): [init-trust-anchors] [init-vomsdir]      │
   │                                                        │
   │  Containers:                                           │
   │    [iam-login-service]  :8085  (Java / Spring Boot)    │
   │    [voms-nginx]         :10443 (NGINX + VOMS module)   │
   │    [voms-aa]            :8080  (Spring Boot, internal) │
   └───────────────────────────────────────────────────────-┘
               │                    │
       ┌───────┴──────┐    ┌───────┴──────────┐
       ▼              ▼    ▼                  ▼
   ┌─────────┐  ┌──────────┐  ┌─────────────────────-─┐
   │ MariaDB │  │  Redis   │  │ Ingress (main)        │
   │ :3306   │  │  :6379   │  │ <iam.host.com>        │
   │ RWO 5Gi │  │  RWO 8Gi │  │ → iam-svc:8085        │
   └─────────┘  └──────────┘  │                       │
                              │ Ingress (VOMS)        │
                              │ <voms.host.com>       │
                              │ SSL-passthrough       │
                              │ → iam-svc:10443       │
                              └───────────────────────┘
