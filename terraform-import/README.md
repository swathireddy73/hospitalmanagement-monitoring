Quick setup for importing existing GKE cluster

Prereqs
- Terraform 1.3+ installed (the Jenkinsfile can install a workspace-local terraform binary).
- `gcloud` installed and APIs enabled: `compute.googleapis.com` and `container.googleapis.com`.

Authentication (choose one)

1) Service account key (recommended for CI)

```bash
# create a service account with appropriate roles (see below), then generate a key
# example (adjust names/project):
gcloud iam service-accounts create tf-admin --display-name="terraform admin"
gcloud projects add-iam-policy-binding hospital-project-485718 \
  --member="serviceAccount:tf-admin@hospital-project-485718.iam.gserviceaccount.com" \
  --role="roles/container.admin"
gcloud projects add-iam-policy-binding hospital-project-485718 \
  --member="serviceAccount:tf-admin@hospital-project-485718.iam.gserviceaccount.com" \
  --role="roles/compute.viewer"

# create key and export path
gcloud iam service-accounts keys create ~/keys/tf-sa-key.json \
  --iam-account=tf-admin@hospital-project-485718.iam.gserviceaccount.com
export GOOGLE_APPLICATION_CREDENTIALS=~/keys/tf-sa-key.json
```

2) Local user (dev):

```bash
gcloud auth application-default login
```

Important notes
- If you're running Terraform on a GCE VM with the VM's service account, ensure the VM's OAuth scopes include `cloud-platform`.
- Enable APIs if not already: `gcloud services enable compute.googleapis.com container.googleapis.com`

Importing the cluster

```bash
terraform init
terraform import google_container_cluster.existing \
  projects/hospital-project-485718/locations/us-central1-a/clusters/cluster-1
terraform plan
```

If you see the "insufficient authentication scopes" error when reading networks, either use a service-account key (method #1) or recreate the VM with broader scopes / use ADC.
