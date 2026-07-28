.. px-app:: lsst-indigo-iam

###############################################
lsst-indigo-iam — Indigo-IAM for LSST Community
###############################################

The `lsst-indigo-iam` application deploys an INDIGO IAM login service
with MariaDB, Redis, and an optional VOMS Attribute Authority sidecar.
It is managed as a parent Helm chart with two sub-charts.

.. code-block:: text

   lsst-indigo-iam/
   ├── Chart.yaml              # Parent chart (mariadb + redis sub-charts)
   ├── values.yaml             # Default values
   ├── values-<env>.yaml       # Per-environment overrides
   ├── secrets.yaml            # ConditionalSecretConfig definitions
   └── templates/
       ├── application.yaml    # Main StatefulSet (IAM + VOMS sidecars)
       ├── service.yaml        # ClusterIP Service
       ├── ingress.yaml        # Main HTTP Ingress
       ├── voms-ingress.yaml   # VOMS SSL-passthrough Ingress
       ├── voms-nginx-configmap.yaml
       ├── vault-secrets.yaml  # VaultSecret resources
       └── oidc-configmap.yaml # Optional OIDC configuration


.. jinja:: lsst-indigo-iam
   :file: applications/_summary.rst.jinja

Guides
======

.. toctree::
   :maxdepth: 1

   architecture
   persistent_storage
   ingress
   voms
   values
