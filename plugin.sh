#!/bin/sh

set -euo pipefail
PLUGIN_DEBUG=true
[ -n "${PLUGIN_DEBUG:-}" ] && set -x

if [ -n "$PLUGIN_KUBECONFIG" ];then
    [ -d $HOME/.kube ] || mkdir $HOME/.kube 
    echo "# Plugin PLUGIN_KUBECONFIG available" >&2
    echo "$PLUGIN_KUBECONFIG" > $HOME/.kube/config
    unset PLUGIN_KUBECONFIG
fi

#kubectl config view

if [ -n "${PLUGIN_TEMPLATE_PATH:-}" ]; then
    cd $PLUGIN_TEMPLATE_PATH
    # set new namespace
    NEWNS="${PLUGIN_NAMESPACE_PREFIX}-${PLUGIN_NAMESPACE_SUFFIX}"
    echo "# Setting new namespace: $NEWNS" >&2
    kustomize edit set namespace ${NEWNS}

    cat << EOF > namespace.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: $NEWNS
EOF

    kustomize edit add resource namespace.yaml

elif [ -n "${PLUGIN_BASEPATH:-}" ]; then
    cd $PLUGIN_BASEPATH
    if [ -n "${PLUGIN_DIR:-}" ]; then
        cd $PLUGIN_DIR
    fi
elif [ -n "${PLUGIN_DIR:-}" ];then
    cd $PLUGIN_DIR
fi

[ -n "${PLUGIN_DEBUG:-}" ] && kustomize build
kustomize build | kubectl apply -f-

