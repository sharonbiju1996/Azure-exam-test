locals {
  name_prefix = "${var.project_name}-${var.environment}-${var.location}"

  common_tags = merge(var.tags, {
    environment = var.environment
    region      = var.location
    managed_by  = "terraform"
    owner       = "platform-team"
    project     = var.project_name
  })
}