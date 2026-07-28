Deploying the IAM VOMS Attribute Authority in Phalanx
=====================================================

Overview
--------

This document covers deploying the INDIGO-IAM VOMS Attribute Authority
(VOMS AA) as a sidecar alongside the ``lsst-indigo-iam`` application in the
Phalanx Argo CD monorepo.

The VOMS AA provides backward-compatible VOMS support so that an
IAM-managed Virtual Organization can also serve VOMS attribute
certificates to grid clients.

Prerequisites
-------------

1. **IGTF-accredited X.509 host certificate** with CN and SAN matching the
   VOMS hostname. Must be issued by a Certificate Authority present in the
   IGTF/EUGridPMA distribution. Download the **full chain** (host cert +
   intermediate CAs, in a single PEM file) and the **unencrypted** private
   key.

2. **``--enable-ssl-passthrough``** enabled on the cluster's ingress-nginx
   controller.


3. **IAM top-level group** matching ``voms.voName`` must exist. Only
   sub-groups under this parent are exposed in VOMS attribute certificates.

4. **User X.509 certificates must be linked** to IAM accounts so that the
   VOMS AA can resolve group memberships.

---


Deployment Steps
----------------

1. **Obtain and upload the host certificate**

   Request an X.509 host certificate from an IGTF-accredited CA (e.g.,
   TERENA/GEANT eScience, GridKa, INFN CA). Provide the VOMS hostname as
   the Common Name and Subject Alternative Name.

   Once obtained, upload the full chain and private key to Vault:

   .. code:: bash

      vault kv put <vaultPathPrefix>/lsst-indigo-iam \
        voms-hostcert.pem=@hostcert-fullchain.pem \
        voms-hostkey.pem=@hostkey.pem

   The key names (``voms-hostcert.pem``, ``voms-hostkey.pem``) are mapped to
   file names (``hostcert.pem``, ``hostkey.pem``) inside the pod by the
   Kubernetes Secret ``items`` mapping. No other file names are required.

2. **Configure the environment**

   In ``values-<env>.yaml``, enable VOMS and set the ingress hostname:

   .. code:: yaml

      voms:
        enabled: true
        ingress:
          host: "<voms-hostname>"

   The hostname must be present in the certificate's SAN extension and must
   not conflict with any existing Ingress on the cluster.

