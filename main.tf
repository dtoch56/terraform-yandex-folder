resource "yandex_resourcemanager_folder" "folder" {
  cloud_id    = var.cloud_id
  name        = var.folder_name
  description = var.folder_description
  labels      = var.folder_labels
}

resource "yandex_iam_service_account" "admin" {
  folder_id   = yandex_resourcemanager_folder.folder.id
  name        = "${yandex_resourcemanager_folder.folder.name}-admin"
  description = "Folder admin service account"
}

resource "yandex_resourcemanager_folder_iam_member" "folder_iam_member" {
  for_each  = toset(var.admin_roles)
  folder_id = yandex_resourcemanager_folder.folder.id
  role      = each.value
  member    = "serviceAccount:${yandex_iam_service_account.admin.id}"
}

resource "yandex_iam_service_account_static_access_key" "folder_admin" {
  service_account_id = yandex_iam_service_account.admin.id
  description        = "Static access key"
}
