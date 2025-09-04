# Communicating between API and Backend
Date: 2025-09-11

## Status 
Accepted

## Context 
Deciding the communication mechanism beween E-Commerce API and Backend containers.

![](embed:Container)

## Alternatives
### APIs
Pros: 
* Less infrastructure overhead. 
* Scaling based on memory and CPU. 
* Tight coupling.

Cons: 
* Authentication and authorization should be setup. 
* Resiliancy needs to be built.

### RPCs
Pros: 
* Less infrastructure overhead. 

Cons:
* Tight coupling. 
* Scaling could be a challenge.


## Desicion
Use message queues for communication

Pros: 
* Containers can scale based on the number of messages. 
* No data loss if containers are down. 
* Messages can be retried if needed. 
* Loose coupling - Backend can evolve independently of the API. 
* Easy to add integrations between other containers.

Cons: 
* More infrastructure components to maintain.
* Latency is introduced by added infrastructure overhead.
* Historical analysis on message consumption can get complicated.
