resource "google_project_iam_binding" "logging" {
  project = var.project
  role    = var.role

  members = [
    "${var.userType}:${var.email}"
  ]
}

