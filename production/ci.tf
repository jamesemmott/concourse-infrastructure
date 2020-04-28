data "helm_repository" "concourse" {
  name = "concourse"
  url  = "https://concourse-charts.storage.googleapis.com"
}

resource "helm_release" "ci-concourse" {
  namespace  = "ci"
  name       = "concourse"
  repository = data.helm_repository.concourse.metadata[0].name
  chart      = "concourse"
  version    = "9.1.1"

  values = [
    file("ci-values.yml")
  ]
}