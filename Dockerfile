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
ARG VER="2.6"

ARG BASE_REG="docker.io"
ARG BASE_REPO="library/haproxy"
ARG BASE_VER="${VER}"
ARG BASE_IMG="${BASE_REG}/${BASE_REPO}:${BASE_VER}"

ARG PUBLIC_REGISTRY="public.ecr.aws"
ARG ARK_BASE_REPO="arkcase/base"
ARG ARK_BASE_TAG="8"
ARG ARK_BASE_IMG="${PUBLIC_REGISTRY}/${ARK_BASE_REPO}:${ARK_BASE_TAG}"

FROM "${ARK_BASE_IMG}" AS arkbase

ARG BASE_IMG

FROM "${BASE_IMG}"

COPY --from=arkbase /.functions /
