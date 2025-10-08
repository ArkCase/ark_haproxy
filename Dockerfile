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
ARG PUBLIC_REGISTRY="public.ecr.aws"
ARG BASE_REGISTRY="${PUBLIC_REGISTRY}"
ARG VER="2.6"

ARG HAP_BASE_REGISTRY="docker.io"
ARG HAP_BASE_REPO="library/haproxy"
ARG HAP_BASE_VER="${VER}"
ARG HAP_BASE_IMG="${HAP_BASE_REGISTRY}/${HAP_BASE_REPO}:${HAP_BASE_VER}"

ARG ARK_BASE_REGISTRY="${BASE_REGISTRY}"
ARG ARK_BASE_REPO="arkcase/base"
ARG ARK_BASE_VER="22.04"
ARG ARK_BASE_VER_PFX=""
ARG ARK_BASE_IMG="${ARK_BASE_REGISTRY}/${ARK_BASE_REPO}:${ARK_BASE_VER_PFX}${ARK_BASE_VER}"

FROM "${ARK_BASE_IMG}" AS arkcase-base

ARG HAP_BASE_IMG

FROM "${HAP_BASE_IMG}"

COPY --from=arkcase-base /.functions /

USER root

RUN apt-get update && \
    apt-get install -y \
        bind9-dnsutils \
        socat \
      && \
    apt-get clean all

USER haproxy
