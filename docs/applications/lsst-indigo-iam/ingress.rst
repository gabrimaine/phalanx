Ingress Configuration
=====================

Two Ingress resources are created:

Main Ingress
------------

Handles regular HTTP/HTTPS traffic to the IAM login service.

.. code-block:: yaml
   :caption: templates/ingress.yaml

   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     annotations:
       nginx.ingress.kubernetes.io/ssl-redirect: "true"
       nginx.ingress.kubernetes.io/proxy-body-size: "0"
   spec:
     ingressClassName: "nginx"
     rules:
       - host: <iam.host.com>
         http:
           paths:
             - path: "/"
               pathType: "Prefix"
               backend:
                 service:
                   name: iam-svc
                   port:
                     number: 8085

Key annotations:

* ``ssl-redirect: "true"`` — all HTTP requests are redirected to HTTPS.
* ``proxy-body-size: "0"`` — no body size limit; needed for large
  requests (e.g., uploading JWK keystores, bulk user operations).

VOMS Ingress
------------

Handles VOMS traffic with SSL passthrough, preserving the client X.509
certificate for authentication by the VOMS NGINX sidecar.

.. code-block:: yaml
   :caption: templates/voms-ingress.yaml

   apiVersion: networking.k8s.io/v1
   kind: Ingress
   metadata:
     name: <release>-lsst-indigo-iam-voms
     annotations:
       nginx.ingress.kubernetes.io/ssl-passthrough: "true"
   spec:
     ingressClassName: "nginx"
     rules:
       - host: data.lsst.eu
         http:
           paths:
             - path: "/"
               pathType: "Prefix"
               backend:
                 service:
                   name: iam-svc
                   port:
                     number: 10443

Key design decisions:

* **Separate hostname** (``iam.host`` vs ``voms.host``) is
  required because SSL passthrough routes by SNI.  Two Ingresses on the
  same hostname with conflicting TLS behaviors (termination vs passthrough)
  cannot coexist.
* **No path-based routing** — SSL passthrough forwards raw TCP; the
  ingress controller cannot inspect HTTP paths inside an encrypted
  connection.
* **Cluster prerequisite**: the ingress-nginx controller must be started
  with ``--enable-ssl-passthrough``.

.. code-block:: yaml
    extraArgs:
      enable-ssl-passthrough: true

