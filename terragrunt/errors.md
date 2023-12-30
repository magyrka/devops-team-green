### Common Errors when running Terragrunt:

### LoadBalancer IP is always `<pending>`
Reason:
```text
NAMESPACE     NAME                     TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S) 
consul        service/gateway-front    LoadBalancer   10.52.15.183   <pending>        80:30834/TCP
```

```text
Warning  SyncLoadBalancerFailed  89s (x10 over 22m)   service-controller  
Error syncing load balancer: failed to ensure load balancer: failed to create forwarding rule for load balancer (afe5955ae6fac499ea7143d94ea61381(consul/gateway-front)): 
googleapi: Error 403: QUOTA_EXCEEDED - Quota 'IN_USE_ADDRESSES' exceeded.  Limit: 4.0 globally.
```
how to fix:
Delete some unused [LoadBalancer IP](https://console.cloud.google.com/net-services/loadbalancing/list/loadBalancers)

------------------------------------------
### Cluster with only One node: "e2-medium" (need minimum 3)

```text
Warning  FailedScheduling   93s (x2 over 95s)  default-scheduler   0/1 nodes are available: 1 Insufficient cpu. 
```

Nodes have External IP