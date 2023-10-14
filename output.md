#### 1. kubectl get all -A -o yaml
```
piVersion: v1
items:
- apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: "2023-10-14T17:00:32Z"
    generateName: model-serve-cc79df86b-
    labels:
      app: model-serve
      pod-template-hash: cc79df86b
    name: model-serve-cc79df86b-zshm8
    namespace: default
    ownerReferences:
    - apiVersion: apps/v1
      blockOwnerDeletion: true
      controller: true
      kind: ReplicaSet
      name: model-serve-cc79df86b
      uid: 627013c0-8ba6-4658-b70f-170c50805fda
    resourceVersion: "2765"
    uid: 0c5445ac-ba9c-4115-9680-824c84a5714f
  spec:
    containers:
    - env:
      - name: REDIS_HOST
        valueFrom:
          configMapKeyRef:
            key: hostname
            name: redis-config-v1.0
      - name: REDIS_PORT
        valueFrom:
          configMapKeyRef:
            key: port
            name: redis-config-v1.0
      - name: REDIS_PASSWORD
        valueFrom:
          secretKeyRef:
            key: db_password
            name: redis-secret-v1.0
      - name: GPT_MODEL
        valueFrom:
          configMapKeyRef:
            key: gpt_model
            name: model-config-v1.0
      - name: TOKENIZER_MODEL
        valueFrom:
          configMapKeyRef:
            key: tokenizer_model
            name: model-config-v1.0
      image: devdastl/emlo:assignment18-model-server
      imagePullPolicy: IfNotPresent
      name: model-serve
      ports:
      - containerPort: 80
        protocol: TCP
      resources:
        limits:
          cpu: 500m
          memory: 1000Mi
        requests:
          cpu: 500m
          memory: 1000Mi
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
      - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
        name: kube-api-access-xg6bp
        readOnly: true
    dnsPolicy: ClusterFirst
    enableServiceLinks: true
    nodeName: ip-192-168-95-21.ap-south-1.compute.internal
    preemptionPolicy: PreemptLowerPriority
    priority: 0
    restartPolicy: Always
    schedulerName: default-scheduler
    securityContext: {}
    serviceAccount: default
    serviceAccountName: default
    terminationGracePeriodSeconds: 30
    tolerations:
    - effect: NoExecute
      key: node.kubernetes.io/not-ready
      operator: Exists
      tolerationSeconds: 300
    - effect: NoExecute
      key: node.kubernetes.io/unreachable
      operator: Exists
      tolerationSeconds: 300
    volumes:
    - name: kube-api-access-xg6bp
      projected:
        defaultMode: 420
        sources:
        - serviceAccountToken:
            expirationSeconds: 3607
            path: token
        - configMap:
            items:
            - key: ca.crt
              path: ca.crt
            name: kube-root-ca.crt
        - downwardAPI:
            items:
            - fieldRef:
                apiVersion: v1
                fieldPath: metadata.namespace
              path: namespace
  status:
    conditions:
    - lastProbeTime: null
      lastTransitionTime: "2023-10-14T17:00:32Z"
      status: "True"
      type: Initialized
    - lastProbeTime: null
      lastTransitionTime: "2023-10-14T17:01:03Z"
      status: "True"
      type: Ready
    - lastProbeTime: null
      lastTransitionTime: "2023-10-14T17:01:03Z"
      status: "True"
      type: ContainersReady
    - lastProbeTime: null
      lastTransitionTime: "2023-10-14T17:00:32Z"
      status: "True"
      type: PodScheduled
    containerStatuses:
    - containerID: containerd://8bb59853cf452755bb044d6979ce86c561937219edf0410c26087cb1a2046462
      image: docker.io/devdastl/emlo:assignment18-model-server
      imageID: docker.io/devdastl/emlo@sha256:4d68b501563df1003a5adbc7f3826a5fd022ea62bf3bb4f068fe49933369f9d1
      lastState: {}
      name: model-serve
      ready: true
      restartCount: 0
      started: true
      state:
        running:
          startedAt: "2023-10-14T17:01:02Z"
    hostIP: 192.168.95.21
    phase: Running
    podIP: 192.168.79.196
    podIPs:
    - ip: 192.168.79.196
    qosClass: Guaranteed
    startTime: "2023-10-14T17:00:32Z"
- apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: "2023-10-14T17:00:32Z"
    generateName: redis-db-686b7bfff8-
    labels:
      app: redis-db
      pod-template-hash: 686b7bfff8
      role: master
    name: redis-db-686b7bfff8-9pntp
    namespace: default
    ownerReferences:
    - apiVersion: apps/v1
      blockOwnerDeletion: true
      controller: true
      kind: ReplicaSet
      name: redis-db-686b7bfff8
      uid: 4109a87a-f4a2-4d85-8463-d71ae7f5503b
    resourceVersion: "2668"
    uid: 905a6e9e-bbd3-4853-84bc-5c8998199154
  spec:
    containers:
    - args:
      - --requirepass
      - $(REDIS_PASSWORD)
      command:
      - redis-server
      env:
      - name: REDIS_PASSWORD
        valueFrom:
          secretKeyRef:
            key: db_password
            name: redis-secret-v1.0
      image: redis:7.2.1
      imagePullPolicy: IfNotPresent
      name: redis-master
      ports:
      - containerPort: 6379
        protocol: TCP
      resources:
        limits:
          cpu: 200m
          memory: 200Mi
        requests:
          cpu: 200m
          memory: 200Mi
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
      - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
        name: kube-api-access-mqbrm
        readOnly: true
    dnsPolicy: ClusterFirst
    enableServiceLinks: true
    nodeName: ip-192-168-95-21.ap-south-1.compute.internal
    preemptionPolicy: PreemptLowerPriority
    priority: 0
    restartPolicy: Always
    schedulerName: default-scheduler
    securityContext: {}
    serviceAccount: default
    serviceAccountName: default
    terminationGracePeriodSeconds: 30
    tolerations:
    - effect: NoExecute
      key: node.kubernetes.io/not-ready
      operator: Exists
      tolerationSeconds: 300
    - effect: NoExecute
      key: node.kubernetes.io/unreachable
      operator: Exists
      tolerationSeconds: 300
    volumes:
    - name: redis-storage
      persistentVolumeClaim:
        claimName: redis-pvc
    - name: kube-api-access-mqbrm
      projected:
        defaultMode: 420
        sources:
        - serviceAccountToken:
            expirationSeconds: 3607
            path: token
        - configMap:
            items:
            - key: ca.crt
              path: ca.crt
            name: kube-root-ca.crt
        - downwardAPI:
            items:
            - fieldRef:
                apiVersion: v1
                fieldPath: metadata.namespace
              path: namespace
  status:
    conditions:
    - lastProbeTime: null
      lastTransitionTime: "2023-10-14T17:00:32Z"
      status: "True"
      type: Initialized
    - lastProbeTime: null
      lastTransitionTime: "2023-10-14T17:00:47Z"
      status: "True"
      type: Ready
    - lastProbeTime: null
      lastTransitionTime: "2023-10-14T17:00:47Z"
      status: "True"
      type: ContainersReady
    - lastProbeTime: null
      lastTransitionTime: "2023-10-14T17:00:32Z"
      status: "True"
      type: PodScheduled
    containerStatuses:
    - containerID: containerd://681eb42368b21fefc9bab28c4168ac92a586e92181e0cbc114c80799fa2bbe31
      image: docker.io/library/redis:7.2.1
      imageID: docker.io/library/redis@sha256:4ca2a277f1dc3ddd0da33a258096de9a1cf5b9d9bd96b27ee78763ee2248c28c
      lastState: {}
      name: redis-master
      ready: true
      restartCount: 0
      started: true
      state:
        running:
          startedAt: "2023-10-14T17:00:46Z"
    hostIP: 192.168.95.21
    phase: Running
    podIP: 192.168.93.1
    podIPs:
    - ip: 192.168.93.1
    qosClass: Guaranteed
    startTime: "2023-10-14T17:00:32Z"
- apiVersion: v1
  kind: Pod
  metadata:
    creationTimestamp: "2023-10-14T17:00:32Z"
    generateName: web-serve-66fdf4c8c4-
    labels:
      app: web-serve
      pod-template-hash: 66fdf4c8c4
    name: web-serve-66fdf4c8c4-mgwgk
    namespace: default
    ownerReferences:
    - apiVersion: apps/v1
      blockOwnerDeletion: true
      controller: true
      kind: ReplicaSet
      name: web-serve-66fdf4c8c4
      uid: fb8205c8-0221-490c-b635-29d22ed4819b
    resourceVersion: "2688"
    uid: adb58db3-fd4a-4998-8167-47956e0b285f
  spec:
    containers:
    - env:
      - name: REDIS_HOST
        valueFrom:
          configMapKeyRef:
            key: hostname
            name: redis-config-v1.0
      - name: REDIS_PORT
        valueFrom:
          configMapKeyRef:
            key: port
            name: redis-config-v1.0
      - name: REDIS_PASSWORD
        valueFrom:
          secretKeyRef:
            key: db_password
            name: redis-secret-v1.0
      - name: MODEL_SERVER_URL
        valueFrom:
          configMapKeyRef:
            key: model_server_url
            name: model-config-v1.0
      image: devdastl/emlo:assignment18-web-server
      imagePullPolicy: IfNotPresent
      name: web-serve
      ports:
      - containerPort: 80
        protocol: TCP
      resources:
        limits:
          cpu: 500m
          memory: 200Mi
        requests:
          cpu: 500m
          memory: 200Mi
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
      - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
        name: kube-api-access-8d6w7
        readOnly: true
    dnsPolicy: ClusterFirst
    enableServiceLinks: true
    nodeName: ip-192-168-95-21.ap-south-1.compute.internal
    preemptionPolicy: PreemptLowerPriority
    priority: 0
    restartPolicy: Always
    schedulerName: default-scheduler
    securityContext: {}
    serviceAccount: default
    serviceAccountName: default
    terminationGracePeriodSeconds: 30
    tolerations:
    - effect: NoExecute
      key: node.kubernetes.io/not-ready
      operator: Exists
      tolerationSeconds: 300
    - effect: NoExecute
      key: node.kubernetes.io/unreachable
      operator: Exists
      tolerationSeconds: 300
    volumes:
    - name: kube-api-access-8d6w7
      projected:
        defaultMode: 420
        sources:
        - serviceAccountToken:
            expirationSeconds: 3607
            path: token
        - configMap:
            items:
            - key: ca.crt
              path: ca.crt
            name: kube-root-ca.crt
        - downwardAPI:
            items:
            - fieldRef:
                apiVersion: v1
                fieldPath: metadata.namespace
              path: namespace
...
...

  status:
    availableReplicas: 2
    fullyLabeledReplicas: 2
    observedGeneration: 1
    readyReplicas: 2
    replicas: 2
- apiVersion: apps/v1
  kind: ReplicaSet
  metadata:
    annotations:
      deployment.kubernetes.io/desired-replicas: "1"
      deployment.kubernetes.io/max-replicas: "2"
      deployment.kubernetes.io/revision: "1"
      meta.helm.sh/release-name: gpt-server
      meta.helm.sh/release-namespace: default
    creationTimestamp: "2023-10-14T17:00:32Z"
    generation: 1
    labels:
      k8s-app: metrics-server
      pod-template-hash: 5d875656f5
    name: metrics-server-5d875656f5
    namespace: kube-system
    ownerReferences:
    - apiVersion: apps/v1
      blockOwnerDeletion: true
      controller: true
      kind: Deployment
      name: metrics-server
      uid: 90fc5aab-e351-470e-a8d4-85ae54b0696f
    resourceVersion: "2758"
    uid: 6f599d05-85c6-45aa-b6cf-3321073a7af7
  spec:
    replicas: 1
    selector:
      matchLabels:
        k8s-app: metrics-server
        pod-template-hash: 5d875656f5
    template:
      metadata:
        creationTimestamp: null
        labels:
          k8s-app: metrics-server
          pod-template-hash: 5d875656f5
      spec:
        containers:
        - args:
          - --cert-dir=/tmp
          - --secure-port=4443
          - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
          - --kubelet-use-node-status-port
          - --metric-resolution=15s
          image: registry.k8s.io/metrics-server/metrics-server:v0.6.4
          imagePullPolicy: IfNotPresent
          livenessProbe:
            failureThreshold: 3
            httpGet:
              path: /livez
              port: https
              scheme: HTTPS
            periodSeconds: 10
            successThreshold: 1
            timeoutSeconds: 1
          name: metrics-server
          ports:
          - containerPort: 4443
            name: https
            protocol: TCP
          readinessProbe:
            failureThreshold: 3
            httpGet:
              path: /readyz
              port: https
              scheme: HTTPS
            initialDelaySeconds: 20
            periodSeconds: 10
            successThreshold: 1
            timeoutSeconds: 1
          resources:
            requests:
              cpu: 100m
              memory: 200Mi
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            runAsNonRoot: true
            runAsUser: 1000
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
          volumeMounts:
          - mountPath: /tmp
            name: tmp-dir
        dnsPolicy: ClusterFirst
        nodeSelector:
          kubernetes.io/os: linux
        priorityClassName: system-cluster-critical
        restartPolicy: Always
        schedulerName: default-scheduler
        securityContext: {}
        serviceAccount: metrics-server
        serviceAccountName: metrics-server
        terminationGracePeriodSeconds: 30
        volumes:
        - emptyDir: {}
          name: tmp-dir
  status:
    availableReplicas: 1
    fullyLabeledReplicas: 1
    observedGeneration: 1
    readyReplicas: 1
    replicas: 1
- apiVersion: autoscaling/v2
  kind: HorizontalPodAutoscaler
  metadata:
    annotations:
      meta.helm.sh/release-name: gpt-server
      meta.helm.sh/release-namespace: default
    creationTimestamp: "2023-10-14T17:03:53Z"
    labels:
      app.kubernetes.io/managed-by: Helm
    name: model-serve
    namespace: default
    resourceVersion: "7690"
    uid: a66bde45-9865-4209-a938-39a04daf7275
  spec:
    maxReplicas: 4
    metrics:
    - resource:
        name: cpu
        target:
          averageUtilization: 50
          type: Utilization
      type: Resource
    minReplicas: 1
    scaleTargetRef:
      apiVersion: apps/v1
      kind: Deployment
      name: model-serve
  status:
    conditions:
    - lastTransitionTime: "2023-10-14T17:04:08Z"
      message: recommended size matches current size
      reason: ReadyForNewScale
      status: "True"
      type: AbleToScale
    - lastTransitionTime: "2023-10-14T17:04:08Z"
      message: the HPA was able to successfully calculate a replica count from cpu
        resource utilization (percentage of request)
      reason: ValidMetricFound
      status: "True"
      type: ScalingActive
    - lastTransitionTime: "2023-10-14T17:20:23Z"
      message: the desired replica count is less than the minimum replica count
      reason: TooFewReplicas
      status: "True"
      type: ScalingLimited
    currentMetrics:
    - resource:
        current:
          averageUtilization: 0
          averageValue: 2m
        name: cpu
      type: Resource
    currentReplicas: 1
    desiredReplicas: 1
    lastScaleTime: "2023-10-14T17:20:23Z"
kind: List
metadata:
  resourceVersion: ""

```

#### 2. kubectl top pods (before load)
```
NAME                          CPU(cores)   MEMORY(bytes)   
model-serve-cc79df86b-zshm8   2m           731Mi           
redis-db-686b7bfff8-9pntp     2m           2Mi             
web-serve-66fdf4c8c4-mgwgk    2m           50Mi
```
#### 3. kubectl top pods (during load)
```
NAME                          CPU(cores)   MEMORY(bytes)   
model-serve-cc79df86b-jn2qv   120m         716Mi           
model-serve-cc79df86b-l9rgp   107m         731Mi           
model-serve-cc79df86b-x8m2q   118m         747Mi           
model-serve-cc79df86b-zshm8   54m          731Mi           
redis-db-686b7bfff8-9pntp     2m           2Mi             
web-serve-66fdf4c8c4-mgwgk    41m          59Mi 
```
#### kubectl top nodes
```
NAME                                           CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
ip-192-168-34-50.ap-south-1.compute.internal   26m          1%     2720Mi          81%       
ip-192-168-95-21.ap-south-1.compute.internal   50m          2%     1583Mi          47% 
```
#### 3. kubectl describe ingress web-serve
```
Name:             web-serve
Labels:           app.kubernetes.io/managed-by=Helm
Namespace:        default
Address:          k8s-default-webserve-2e58196f1d-1030968271.ap-south-1.elb.amazonaws.com
Ingress Class:    alb
Default backend:  <default>
Rules:
  Host        Path  Backends
  ----        ----  --------
  *           
              /   web-serve:8000 (192.168.74.184:80)
Annotations:  alb.ingress.kubernetes.io/scheme: internet-facing
              alb.ingress.kubernetes.io/target-type: ip
              meta.helm.sh/release-name: gpt-server
              meta.helm.sh/release-namespace: default
Events:
  Type    Reason                  Age   From     Message
  ----    ------                  ----  ----     -------
  Normal  SuccessfullyReconciled  30m   ingress  Successfully reconciled
```