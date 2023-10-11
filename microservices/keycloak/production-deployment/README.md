# production-deployment

This directory demonstrates a production-level deployment of keycloak.

It has:

1. deploy time configuration for realms and users.
2. persistence database.

## Docs

[Configuring Keycloak for production | Learn how to make Keycloak ready for production.](https://www.keycloak.org/server/configuration-production)

Checklist:

- [ ] TLS/HTTPS
  - `edge` mode behind proxy
- [x] Hostname
  - Behind Istio Gateway
- [x] Load balance behind reverse proxy
  - Replica + K8S Service
- [ ] Hide certain path from public access. [Using a reverse proxy](https://www.keycloak.org/server/reverseproxy)
- [x] Production level database. [Configuring the database](https://www.keycloak.org/server/db)
  - PostgreSQL subchart with tuning, replication and backup
- [ ] Keycloak as Cluster, more than 2 nodes
- [x] IPV4 or V6 or Both
- [ ] Prometheus monitoring
