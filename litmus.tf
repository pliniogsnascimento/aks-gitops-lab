resource "kubernetes_namespace" "litmus" {
  metadata {
    name = "litmus"

    labels = {
      "app"             = "litmus"
      "istio-injection" = "enabled"
    }
  }
}

resource "helm_release" "litmuschaos" {
  name = "litmus"

  repository = "https://litmuschaos.github.io/litmus-helm/"
  chart      = "litmus"
  namespace  = kubernetes_namespace.litmus.metadata[0].name

  values = ["${file("${path.module}/charts/litmus/values.yaml")}"]
}
