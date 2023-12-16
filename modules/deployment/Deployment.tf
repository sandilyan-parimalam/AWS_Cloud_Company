resource "kubernetes_manifest" "dev_web_manifest" {
  manifest = file("K8_Manifests/Dev_Web_Manifest.yaml")

  # Apply the manifest only when the workspace is "AWS_Cloud_Company"
  count = terraform.workspace == "AWS_Cloud_Company" ? 1 : 0
}