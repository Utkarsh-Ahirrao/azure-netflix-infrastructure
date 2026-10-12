module "rg-prod" {
  source = "../../Child-Modules/RG"
  var_rg = var.rg
}

module "stgacc-prod" {
  depends_on = [module.rg-prod]
  source     = "../../Child-Modules/STORAGEACC"
  var_stgacc = var.stgacc
}

module "vnet-prod" {
  depends_on = [module.rg-prod]
  source     = "../../Child-Modules/VNET"
  var_vnet   = var.vnet
}

module "subnet-prod" {
  depends_on = [module.rg-prod, module.vnet-prod]
  source     = "../../Child-Modules/SUBNET"
  var_subnet = var.subnet
}

module "nsg-prod" {
  depends_on = [module.rg-prod]
  source     = "../../Child-Modules/NSG"
  var_nsg    = var.nsg
}

module "pubip-prod" {
  depends_on = [module.rg-prod]
  source     = "../../Child-Modules/PUBLIC-IP"
  var-pubip  = var.pubip
}

module "vm-prod" {
  depends_on     = [module.rg-prod, module.vnet-prod, module.subnet-prod, module.nsg-prod, module.pubip-prod]
  source         = "../../Child-Modules/VM"
  var-vm         = var.vm
  admin_username = var.admin_username
  admin_password = var.admin_password
}