# Deploy a Google GKE cluster with Enforcer

These Terraform templates will deploy a Google GKE cluster with Enforcer installed and connected to the Prisma Cloud Console.



## Prequisites:
1. Create a new microsegmentation namespace

2. Create a new project in Google Cloud Platform (or use an existing project)

3. Create a cloud auto-registration policy on Prisma Cloud Console
    - Navigate to the namespace where you will deploy the Enforcer
    - Go to Network Security -> Namespaces -> Authorizations
    - click on the "+" sign and create a cloud auto-registration policy
    - Under "Auto-registration":
        - For Cloud Provider, choose GKE
        - For Claims, enter the key=value pairs:
            - projectid=<Google_Project_ID>

4. Terraform v1.0 and above

5. Install gcloud CLI
    - https://cloud.google.com/sdk/docs/install

6. Install kubectl
    - https://kubernetes.io/docs/tasks/tools/



## Deployment

### Deploy GKE Cluster

1. cd into the "deploy_gke_cluster" directory

2. Update the "terraform.tfvars" file with the necessary information.

3. Run "terraform init"

4. Run "terraform apply"

5. The GKE cluster will be deployed. It takes about 10-15 minutes for it to be fully ready.

6. Note down the "get_kubeconfig_command" in the Terraform output. This command will be used later to retrieve the kubeconfig file.



### Deploy Enforcer

1. cd into the "deploy_enforcer" directory

2. Update the "terraform.tfvars" file with the necessary information.

3. Run "terraform init"

4. Run "terraform apply"

5. On the Prisma Cloud console, go to Network Security -> Agent -> Enforcers to check that the Enforcer is connected to the Console



### Retrieving the kubeconfig file to run kubectl commands
1. run the following commands:
    - export KUBECONFIG="$PWD/kubeconfig"
    - run the get_kubeconfig_command (gcloud container clusters get-credentials ...) which you noted down earlier

2. Run "kubectl get all -n aporeto" to list the microsegmentation pods and service.



## Removing The Demo Environment

1. cd into the "deploy_enforcer" directory

2. Run "terraform destroy"

3. Run "unset KUBECONFIG"

4. Run "rm kubeconfig"

5. cd into the "deploy_eks_cluster" directory

6. Run "terraform destroy"



## Note
The enforcerd.tf file is based on the enforcerd yaml file from https://github.com/aporeto-se/aporeto-k8s-enforcerd-builder
