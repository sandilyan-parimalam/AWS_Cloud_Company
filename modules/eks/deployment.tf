resource "kubernetes_manifest" "dev" {
  manifest = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: dev

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dev-web-deployment
  namespace: dev
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web-nginx-app
  template:
    metadata:
      labels:
        app: web-nginx-app
    spec:
      containers:
      - name: web-nginx-app-container
        image: nginx:latest
        ports:
        - containerPort: 80

---
apiVersion: v1
kind: Service
metadata:
  name: dev-web-lb
  namespace: dev
spec:
  type: LoadBalancer
  selector:
    app: web-nginx-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
YAML

  depends_on = [aws_eks_node_group.dev_web_eks_node_group]
}
