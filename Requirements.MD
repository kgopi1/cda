Cloud Domain Assessment: 

Pre-requisites: 

Laptop (preferably mac) with Jenkins, Minikube (or alternative) 

Text editor such as Atom, SublimeText, IntelliJ 

Cloud 

Using your favorite configuration management tool write the code to: 

Provision a virtual machine on your preferred cloud provider (AWS, Azure, GCP)

***Using Terraform provisioned the Linux VM and its dependencies in Azure***

Install the components necessary to run your favourite webserver on it

***Using VM custom script extension to installed the web server with sample web page***

Write the code to push/install new application code onto the server :

***Using Ansible playbook application code (nginx webpage) is updated in the server***

Using your favourite configuration management tool and cloud provider, implement compliance checks for the following: 

Network only allows secured HTTP access from the outside. ***

***NSG rules created to allow only the https ports ***
CheckOV Rule: 
Ensure that HTTP (port 80) access is restricted from the internet" : Passed

Versioning, audit trails are enabled on file/object stores ****

***Blob versioning and storage account Audit enabled***

Logs are sent to an appropriate location 
***Log Analystics created and OMS agent installed in the servers to send the logs to Log analystics***


All data at rest for any databases/volumes are encrypted

***VM Disks are encrypted and storage account ***

***Using Checkov tool IaC compliance scanning ran and collected results summary***

  
