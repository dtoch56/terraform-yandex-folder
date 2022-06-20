module "folder" {
  source             = "../../"
  cloud_id           = var.cloud_id
  folder_name        = var.folder_name
  folder_description = var.folder_description
  folder_labels      = var.folder_labels
  admin_roles        = var.admin_roles
}
