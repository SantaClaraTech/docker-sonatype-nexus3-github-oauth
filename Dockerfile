FROM sonatype/nexus3:3.34.1

# Version of the github oauth plugin
ARG GITHUB_OAUTH_PLUGIN_VERSION=2.0.2
ENV BUILD_TRIGGER=3

ARG RELEASE_URL=https://github.com/Sczuka/nexus3-github-oauth-plugin/releases/download/sub-team-flattening/nexus3-github-oauth-plugin.zip
# ARG RELEASE_URL=https://github.com/larscheid-schmitzhermes/nexus3-github-oauth-plugin/releases/download/$GITHUB_OAUTH_PLUGIN_VERSION/nexus3-github-oauth-plugin.zip
ARG PLUGIN_LOCATION=/opt/sonatype/nexus/system/com/larscheidschmitzhermes

USER root

RUN yum install -y \
  unzip \
  && yum clean all

ENV PLUGIN_LOCATION=$PLUGIN_LOCATION

RUN mkdir -p "${PLUGIN_LOCATION}" &&\ 
  curl -L -s -o ${PLUGIN_LOCATION}/nexus3-github-oauth-plugin.zip ${RELEASE_URL} &&\
  unzip ${PLUGIN_LOCATION}/nexus3-github-oauth-plugin.zip -d ${PLUGIN_LOCATION}/ &&\
  rm ${PLUGIN_LOCATION}/nexus3-github-oauth-plugin.zip

RUN echo "mvn\:com.larscheidschmitzhermes/nexus3-github-oauth-plugin/${GITHUB_OAUTH_PLUGIN_VERSION} = 200" >> /opt/sonatype/nexus/etc/karaf/startup.properties &&\
  echo "github.api.url=https://api.github.com" >> /opt/sonatype/nexus/etc/githuboauth.properties &&\
  echo "github.principal.cache.ttl=PT1H" >> /opt/sonatype/nexus/etc/githuboauth.properties

USER nexus
