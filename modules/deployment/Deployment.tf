locals {
  yaml_content = file("K8_Manifests/Dev_Web_Manifest.yaml")
  yaml_decoded  = jsondecode(local.yaml_content)
}

resource "kubernetes_manifest" "dev_web_manifest" {
  manifest = local.yaml_decoded

  # Apply the manifest only when the workspace is "AWS_Cloud_Company"
  count = terraform.workspace == "AWS_Cloud_Company" ? 1 : 0
}
