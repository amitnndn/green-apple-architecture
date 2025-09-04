## Quality Attributes
Quality attribtes for Green Apple E-Commerce System are as follows. 
### Security
* All customer data is stored in a secure manner. 
  * All the data that is stored in the database will be encrypted by KMS keys.
  * The data will only be decrypted on the front-end only after validating that the customer is logged in. 
  * If the session is inactive, the data is automatically hidden from the UI and a new request will require generating a new set of decryption keys.
* Payment information handled securely.
  * Payment is processed through trusted 3rd party payment providers. 
  * Payment information except for information needed by support team to verify payment methods will not be stored in the database.
* HTTPS communication
  * Communication between services that happen over HTTP are encrypted with strong encryption algorithms.
* Vault storage. 
  * Sensitive information like API keys etc. are stored in a secure vault (like AWS Secret Manager) and encrypted with KMS keys that are secured through strong IAM policies.

### Performance
* Page load times are fast for customer. 
  * All static data are cached behind a CDN (like AWS CloudFront). 
  * Dynamic data is cached in a short lived caching layer (like Redis)
  * Queries are distributed between writer and reader nodes in the database. 
  * Database tables are sharded if necessary by choosing the right sharding key.
* Nightly performance tests
  * Performance tests on the user facing site happens nightly with stats monitored and tickets are automatically created.
* EKS Scaling setup
  * EKS pods are configured to add more pods based on CPU and memory usage. 
  * Backend EKS pods are configured to scale up and down based on the number of messages that need to be processed.
* Database scaling
  * Database will automatically add reader nodes when needed to distribute traffic.

### Availability
* Resources are deployed across multiple regions. 
* Feature flags are used for new features and use blue/green deployements. 
* Auto rollbacks for deployements are enabled if spikes in errors are noticed. 
* App automatically fails over to a secondary region if there are spikes in errors in the primary region.

### Observability
* Custom monitors are reported to a monitoring system (like Datadog). 
* Alerts are created on built-in and custom monitors. 

### Testability
* Testing at all levels: 
  * Unit and integration testing done using reliable testing tools (like Jest or JUnit)
  * Automated black box testing using reliable testing tools on lower environments (like Playwright or Cypress)
  * Chaos testing on lower environment to uncover bottlenecs in infrastructure. 
  * Testing on infrastructure as code to validate that infrastructure is spun up as expected.
* Quality gates: 
  * 90% unit test coverage - validated during build time. 
  * 90% scenario coverage - validated during build time.
  * Blabk box testing will be run when code is promoted to staging or production and failures will cause the build to fail. 
  * Nightly chaos testing to identify bottle necks in infrastructure. 

