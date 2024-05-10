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
ARG BASE_VER="${VER}.17"
ARG BASE_IMG="${BASE_REG}/${BASE_REPO}:${BASE_VER}"

FROM "${BASE_IMG}"
