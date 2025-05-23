data "google_service_account" "iac" {
  account_id = var.iac_service_account
}

resource "google_iam_workload_identity_pool" "tbd-workload-identity-pool" {
  workload_identity_pool_id = "github-actions-pool-2"
}


resource "google_iam_workload_identity_pool_provider" "tbd-workload-identity-provider" {
  #checkov:skip=CKV_GCP_125: "Ensure GCP GitHub Actions OIDC trust policy is configured securely"
  workload_identity_pool_id          = google_iam_workload_identity_pool.tbd-workload-identity-pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-provider-2"
  display_name                       = "GitHub provider"
  description                        = "GitHub identity pool provider for CI/CD purposes"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
    "attribute.org"        = "assertion.repository_owner"
    "attribute.refs"       = "assertion.ref"
  }
  attribute_condition = "attribute.repository == \"${var.github_org}/${var.github_repo}\""
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "tbd-sa-workload-identity-iam" {
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = data.google_service_account.iac.name
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.tbd-workload-identity-pool.name}/attribute.repository/${var.github_org}/${var.github_repo}"
}