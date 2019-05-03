# docker-sonatype-nexus3-github-auth

Sonatype Nexus3 with github authentication docker container.

This Dockerfile inherits  [https://hub.docker.com/r/sonatype/nexus3](sonartype/nexus) and add the [https://github.com/larscheid-schmitzhermes/nexus3-github-oauth-plugin](nexus3-github-oauth-plugin) plugin.

## Configuration

When using docker-compose

docker-compose.yaml:

```yaml
version: "3"

services:
  nexus:
    image: sczuka/sonatype-nexus3-github-oauth:version-3.16.1
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

githuboauth.properties:
```properties
github.api.url=https://api.github.com
github.principal.cache.ttl=PT1M
github.org=organization-to-check
```
