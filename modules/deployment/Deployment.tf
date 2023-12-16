locals {
  yaml_content = file("K8_Manifests/Dev_Web_Manifest.yaml")
}

resource "kubernetes_manifest" "dev_web_manifest" {
  manifest = local.yaml_content

  # Apply the manifest only when the workspace is "AWS_Cloud_Company"
  count = terraform.workspace == "AWS_Cloud_Company" ? 1 : 0
}

output "decoded_yaml" {
  value = kubernetes_manifest.dev_web_manifest
}
