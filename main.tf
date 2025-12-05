#Blueprint request
module "deployments" {
  source  = "github.com/sentania-labs/terraform-vcfa-vmapps-blueprint"
  version = "v0.8"

  for_each = var.deployments

  project_name    = var.vcfa_project
  deployment_name = each.value.deployment_name
  description     = each.value.description
  blueprint_name  = each.value.blueprint_name
  inputs          = each.value.inputs
}

data "vra_machine" "all" {
  for_each = {
    for k, m in module.deployments :
    k => m.deployment_info
  }

  filter = "deploymentId eq '${each.value.id}'"
}

resource "local_file" "lb_config" {
  content = templatefile("${path.module}/output-template.tpl", {
    nodes = data.vra_machine.all
  })
  filename = "${path.module}/server-list.txt"
}
