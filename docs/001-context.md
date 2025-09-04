# Green Apple E-Commerce System 
## Context 
Green Apple, a fast- growing brick-and-mortar store business that specializes in selling personalized health and wellness products, has recently selected Bold Orange to envision and create a new ecommerce experience. To stay competitive in the market, Green Apple has decided to implement a new digital delivery capability and e-commerce distribution channel. The goal is to have a leading customer experience, and from a technology perspective, to identify and select a Content Management System (CMS), Customer Data Platform (CDP), Marketing Automation, and integrated e-commerce capabilities seamlessly.

![](embed:Context)

## E-Commerce Database
This is the relational database that holds the necessary data about products, promotions and other things that are being used by the e-commerce website. This database will be multi-node and multi-region with a single writer instances and multipe reader instances across multiple regions. Reader instances can also be used to connect to a reporting service that will allow us to write and display the results of aggregate queries.

Further scope could include splitting this database into smaller databases to be used by microservices thus avoiding a single point of failure and enabling the ability to scale individual components.

## Product Search Database
A text based document storage database (like elastic search) that will enable the system to run fast text based search on the products. This database will also be multi-region and multi-node allowing the system to scale as a whole. 

## Containers
This system will be using a Kubernetes based hosting (like EKS) with multiple clusters and pods handling the user and backend traffic. 

![](embed:Container)

### Anatomy of containers
Containers are split into a user facing interface and an employee facing interface. This will enable us to make sure that employees can maintain the system without having to worry about adding additional load to the user facing system. This will also enable the employee facing containers to reside behind a VPN network and add a specialized authentication layer for employees.

User facing UI component that holds different user facing components.
![](embed:UI)
Components with the Admin UI container. This UI will be used to interact with the Admin API and will handle authentication, product management, promotion management etc.
![](embed:AdminUI)
Backend component that is reponsible for interacting with most of the external systems and also tracking payments, taxes, shipping etc. This backend service will also integrate with external systems to manage marketing tools, notifications and maintaining aggregate customer stats.
![](embed:Backend)


## Messaging Infrastructure
The backend service will involve scheduled jobs and message based triggers through a message broker (like SNS + SQS). This will enable the API to submit jobs to the backend container for processing and the backend service to asynchronously process and act on these messages. 

For example, the tax calculation service could be done by submitting a message with the following payload: 
```
{
  "order_id": "1234",
  "calculation_type": "tax"
}
```


