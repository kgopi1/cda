module "cda-webserver" {
  source             = "../../modules/cda"
  vm                 = var.vm
  project            = var.project
  network            = var.network
  location           = var.location
  tags               = var.tags
}