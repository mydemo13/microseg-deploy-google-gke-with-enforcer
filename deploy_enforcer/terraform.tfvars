project = "<GCP_project_ID>"

# https://cloud.google.com/compute/docs/regions-zones
region = "asia-southeast1"

cns_api = "<Microsegmentation API Endpoint for your tenant>"

cns_namespace = "<Microsegmentation Name Space to deploy the Enforcer e.g. "/81234567890/production/cluster1">"


# These default values can be used

cluster_name = "microseg-demo-cluster"

cns_enforcerd_image = "gcr.io/prismacloud-cns/enforcerd:release-6.10.1"

cns_enforcerd_cni_bin_dir="/home/kubernetes/bin"

cns_enforcerd_cni_conf_dir="/etc/cni/net.d"
