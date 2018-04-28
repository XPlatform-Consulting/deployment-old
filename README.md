# deployment
Scripts and files used by XPlatform Consulting for system deployment

## Terraform Modules
Found in the modules directory, these are used to deploy AWS infrastructure. 
* aws-aspera-orchestrator: Used to deploy AWS resources needed to start Aspera orchestrator. (currently in dev)
* aws- aspera-orchestrator-ha: Used to deploy AWS resources needed to start Aspera orchestrator in a high availability configuration. (currently in dev)
* aws-vidispine-services: Used to deploy the AWS resources needed to start a Vidispine API server.
* aws-portal-services: Used to deploy the AWS resources needed to start Cantemo Portal.
* aws-envoi: Used to start AWS resources to run Envoi.
* aws-docker-swarm: Used to start a Docker Swarm in AWS.
---
* aws-amazonmq: Used by other modules to start AmazonMQ services.
* aws-aurora: Used by other modules to start AWS Aurora clusters.
* aws-elasticache: Used by other modules to start AWS Elasticache services.
* aws-elasticsearch: Used by other modules to start AWS Elasticsearch services.

### Usage
All modules and playbooks are intended to be run from within the VPC and connect to instances using the private IP addresses of each instance. 