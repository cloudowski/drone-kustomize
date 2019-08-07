FROM alpine
RUN apk add --no-cache curl make git bash
RUN curl -Lo /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl && chmod +x /usr/bin/kubectl
RUN curl -Lo /usr/bin/kustomize https://github.com/kubernetes-sigs/kustomize/releases/download/v3.1.0/kustomize_3.1.0_linux_amd64 && chmod +x /usr/bin/kustomize
COPY plugin.sh /drone/
ENTRYPOINT [ "/drone/plugin.sh" ]
