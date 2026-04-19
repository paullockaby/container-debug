> [!IMPORTANT]
> If you are viewing this repository in GitHub, know that GitHub is [a mirror of the original repository](https://code.lockaby.org/public/container-debug).

# container-debug
A container image for running debugging in Kubernetes.

You can use this container by applying a yaml file that looks like this:

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: debug
  labels:
    app.kubernetes.io/name: debug
spec:
  replicas: 1
  serviceName: debug
  selector:
    matchLabels:
      app.kubernetes.io/name: debug
  template:
    metadata:
      labels:
        app.kubernetes.io/name: debug
    spec:
      restartPolicy: Always
      containers:
        - name: debug
          image: ghcr.io/paullockaby/container-debug:latest
          imagePullPolicy: Always
          command: ["/bin/bash", "-c", "--"]
          args: ["while true; do exit 1; done;"]
```

When you're doing doing your debugging then simply delete the StatefulSet.
