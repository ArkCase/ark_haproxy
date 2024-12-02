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
ARG VER="2.6"

ARG BASE_REGISTRY="docker.io"
ARG BASE_REPO="library/haproxy"
ARG BASE_VER="${VER}"
ARG BASE_IMG="${BASE_REGISTRY}/${BASE_REPO}:${BASE_VER}"

ARG ARK_BASE_REGISTRY="${PUBLIC_REGISTRY}"
ARG ARK_BASE_REPO="arkcase/base"
ARG ARK_BASE_VER="8"
ARG ARK_BASE_VER_PFX=""
ARG ARK_BASE_IMG="${ARK_BASE_REGISTRY}/${ARK_BASE_REPO}:${ARK_BASE_VER_PFX}${ARK_BASE_VER}"

FROM "${ARK_BASE_IMG}" AS arkbase

ARG BASE_IMG

FROM "${BASE_IMG}"

COPY --from=arkbase /.functions /
