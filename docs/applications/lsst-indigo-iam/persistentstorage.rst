MariaDB — Persistent Storage
=============================

MariaDB runs as a single-replica **Deployment** with ``Recreate`` strategy.
The database and user are created automatically via an init ConfigMap.

Persistent Volume Claim
-----------------------

The PVC is always created (when MariaDB is enabled).  In the CC-IN2P3
environment it uses the ``mariadb-local-storage`` storage class:

.. code-block:: yaml
   :caption: environments/values-ccin2p3.yaml

   mariadb:
     persistentvolume:
       create: false
       class: "mariadb-local-storage"
       size: 5Gi
       reclaimPolicy: Retain

The resulting PVC:

.. code-block:: yaml

   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: <release>-mariadb-pvc
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 5Gi
     storageClassName: mariadb-local-storage

Key points:

* ``.Values.mariadb.persistentvolume.create`` is ``false`` — only the PVC
  is created; the PV must be provisioned by the storage class controller or
  pre-created by the cluster administrator.
* ``reclaimPolicy: Retain`` on the volume definition ensures the PV is not
  deleted when the PVC is removed.
* The data is mounted at ``/var/lib/mysql`` inside the container.
* The Deployment uses ``strategy.type: Recreate`` because a single-node
  database cannot safely do a rolling update.

Resource limits
---------------

.. code-block:: yaml

   mariadb:
     resources:
       requests:
         cpu: "500m"
         memory: "128Mi"
       limits:
         cpu: "1"
         memory: "256Mi"


Redis — Persistent Storage
===========================

Redis runs as a single-replica **StatefulSet** with ``volumeClaimTemplates``,
which means each replica gets its own dynamically-provisioned PVC.  In the
CC-IN2P3 environment it uses the ``redis-rsp-localstorage`` storage class:

.. code-block:: yaml
   :caption: environments/values-ccin2p3.yaml

   redis:
     persistence:
       storageClass: "redis-rsp-localstorage"

The resulting volume claim template:

.. code-block:: yaml

   volumeClaimTemplates:
     - metadata:
         name: <name>-redis-data
       spec:
         accessModes:
           - ReadWriteOnce
         storageClassName: redis-rsp-localstorage
         resources:
           requests:
             storage: 8Gi

Key differences from MariaDB:

* Redis uses ``volumeClaimTemplates`` (StatefulSet-native), while MariaDB
  uses a manually-defined PVC.
* Redis storage is 8 GiB; MariaDB is 5 GiB.
* Both use ``ReadWriteOnce`` access mode.

Resource limits
---------------

.. code-block:: yaml

   redis:
     resources:
       requests:
         cpu: "250m"
         memory: "128Mi"
       limits:
         cpu: "500m"
         memory: "192Mi"

