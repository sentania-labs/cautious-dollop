deployments = {
  myFirstDeployment = {
    blueprint_name    = "VM With Disks"
    deployment_name      = "Deployed from Template"
    description          = "Provisioned by TF"
    inputs = {
      flavorSize   = "medium"
      diskCount    = 2
      diskSize     = 10
      image        = "ubuntu24"
      serviceLevel = "sandbox"
      application  = "sandbox"
    }
  }
}