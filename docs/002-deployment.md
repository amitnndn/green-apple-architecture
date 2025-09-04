## Deployment
![](embed:Deployment-001)

* Global Route 53 entry that splits traffic between region specific elastic load balancer.
* EKS Clusters are used to host the different containers. 
* There is an SNS topic and SQS queue for communication between API and Backend containers. 
* Globally available database with reader and writer nodes. 
* Elastic Search instances that are globally available with reader and writer nodes.