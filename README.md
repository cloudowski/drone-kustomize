# Drone kustomize plugin

Kustomize plugin for Drone CI. 

# Usage


The most basic usage requires `kubeconfig` (preferably as secret) with
kubeconfig content and `basepath` pointing to a path inside a repo where
`kustomization.yaml` file is placed.

```
steps:
  - name: deploy-stage
    image: cloudowski/drone-kustomize
    settings:
      kubeconfig:
        from_secret: kubeconfig
      basepath: deploy/envs/stage
```
