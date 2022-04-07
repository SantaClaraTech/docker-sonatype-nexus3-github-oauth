# docker-sonatype-nexus3-github-auth

Sonatype Nexus3 with github authentication docker container.

This docker environment inherits  [sonartype/nexus](https://hub.docker.com/r/sonatype/nexus3) and add the [nexus3-github-oauth-plugin](https://github.com/larscheid-schmitzhermes/nexus3-github-oauth-plugin) plugin.

## Configuration

The following configurations may be used then deploying with **docker-compose**:

**docker-compose.yaml**:

```yaml
version: "3"

services:
  nexus:
    image: ghcr.io/sczuka/docker-sonatype-nexus3-github-oauth:v3.38.1
    volumes:
      - nexus-data:/nexus-data
      - "./githuboauth.properties:/opt/sonatype/nexus/etc/githuboauth.properties:ro"
    restart: unless-stopped
    ports:
      - "8081:8081"
volumes:
  nexus-data: 
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: '/srv/nexus3/data'
```

**githuboauth.properties**:
```properties
github.api.url=https://api.github.com
github.principal.cache.ttl=PT1M
# Filtering out my-organization-to-check
github.org=my-organization-to-check
```

