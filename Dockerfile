###########################################################################################################
#
# How to build:
#
# docker build -t arkcase/haproxy:latest .
#
# How to run: (Helm)
#
# helm repo add arkcase https://arkcase.github.io/ark_helm_charts/
# helm install core arkcase/haproxy
# helm uninstall core
#
###########################################################################################################

#
# Basic Parameters
#
ARG FIPS=""
ARG PUBLIC_REGISTRY="public.ecr.aws"
ARG BASE_REGISTRY="${PUBLIC_REGISTRY}"
ARG VER="3.2"
ARG HAPROXY_APT_REPO="ppa:vbernat/haproxy-${VER}"

ARG BASE_REGISTRY="${BASE_REGISTRY}"
ARG BASE_REPO="arkcase/base"
ARG BASE_VER="24.04"
ARG BASE_VER_PFX=""
ARG BASE_IMG="${BASE_REGISTRY}/${BASE_REPO}${FIPS}:${BASE_VER_PFX}${BASE_VER}"

FROM "${BASE_IMG}"

ARG VER
ARG HAPROXY_APT_REPO

ENV APP_USER="haproxy"
ENV APP_GROUP="${APP_USER}"

ENV HAPROXY_VERSION="${VER}" \
    HOME="/var/lib/haproxy"

ENV SUMMARY="HAProxy is an advanced high-availability network proxy server" \
    DESCRIPTION="HAProxy is an advanced high-availability network proxy server, generally used for \
fault-tolerance and load-balancing backend servers."

LABEL summary="${SUMMARY}" \
      description="${DESCRIPTION}" \
      io.k8s.description="${DESCRIPTION}" \
      io.k8s.display-name="HAProxy ${VER}" \
      version="1"

RUN \
    apt-get -y install software-properties-common && \
    add-apt-repository -y "${HAPROXY_APT_REPO}" && \
    apt-get update && \
    apt-get -y install \
        haproxy \
        socat \
      && \
    apt-get -y purge --autoremove software-properties-common && \
    apt-get clean all && \
    usermod -a -G "${ACM_GROUP}" "${APP_USER}" && \
    rm -rf "${HOME}/.launchpadlib" "${HOME}/dev" && \
    chown -R "${APP_USER}:${APP_GROUP}" "${HOME}" "${CONF_DIR}" && \
    chmod -R u=rwX,g=rX,o= "${HOME}" "${CONF_DIR}"

COPY --chown=haproxy:haproxy --chmod=0644 responses.lua "${HOME}/responses.lua"
COPY --chown=root:root --chmod=0755 scripts/ /

WORKDIR "${HOME}"

STOPSIGNAL SIGUSR1

USER "${APP_USER}"

ENTRYPOINT [ "haproxy" ]
