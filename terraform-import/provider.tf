provider "google" {
  # This provider block assumes you will authenticate with one of:
  # - `export GOOGLE_APPLICATION_CREDENTIALS=/full/path/to/key.json` (recommended for CI)
  # - `gcloud auth application-default login` (for local dev)
  # - GCE default service account with proper OAuth scopes

  # Use variables so the configuration is reusable and import-friendly.
  project = var.project_id
  region  = var.region
}
