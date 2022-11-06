# cda
PS-CDA

# About:

This project contains IaC for deploying and configuring the Virtual machine and Nginx Web server with sample html webpage. 

## Pre-request:
1. update the providers.tf, state.tf in deploy module.
2. update .envrc file in the config ansible/azure module.

## Stages

### Deploy Stage: 

In this stage , Virtual machine ,its dependencies and nginx webserver with simple webpage will be deployed using Terraform IaC . 

**How to run the Deployment**

> 1. Change directory to deploy/environments/dev.
> 
> 2. Run Terraform init/plan/apply

### Config Stage:

#### Ansible:

Ansible Stage is to install /update applications running in the Virtual machine. 
Ansible directory is split into 2 sections.

* Azure :
   Azure directory using azure dynamic inventory for ansible execution . 
* Local : 
    This directory is used to develope and test the ansible playbooks/roles locally. 
* Roles : 
    Centralized module to store all the ansible roles used in the repo. 

    **How to run the Ansible**

> Local: 
> 1. Change directory to config/ansible/local.
> 
> 2. Run ansible-playbook -i inventory site.yaml  --ask-pass

> Azure:
>
> 1.Change directory to config/ansible/azure
>
> 2. ansible-playbook -i azure_rm.py site.yaml --ask-pass

#### Iac Compliance tool:

I used [**checkov**](https://www.checkov.io/1.Welcome/What%20is%20Checkov.html) static IaC analysis tool for getting compliance checks. 

**How to run the checkov tool**

> 1.Change directory to config/checkov
>
> 2. Run the script scan.sh 

Note: All the config modules uses python virtual environment. Install the python requriements before running the scripts from the module. 
 
> python -m venv .venv # to create python virutal environment 
>
> source .venv/bin/activate # to activate virtual environment.
>
> pip install -r requirements.txt 






