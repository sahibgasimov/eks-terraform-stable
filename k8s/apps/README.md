Ingress annotations example
```
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/tags: Environment=dev,Team=test
    alb.ingress.kubernetes.io/target-type: ip #external dns will create record
    alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-east-1:639625606919:certificate/8774d94e-8655-4465-a282-dc8fc5cc62a5
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
    alb.ingress.kubernetes.io/ssl-redirect: '443'
    alb.ingress.kubernetes.io/group.name: 2-app
    alb.ingress.kubernetes.io/group.order: '1'
```