data "google_secret_manager_secret_version" "wavefront_token" {
  provider = google-beta
  secret   = "wavefront_token"
}

module "wavefront" {
  source = "../../dependencies/wavefront"

  prefix   = "concourse"
  hostname = "dispatcher.concourse-ci.org"
  token    = data.google_secret_manager_secret_version.wavefront_token.secret_data

  depends_on = [
    module.cluster.node_pools,
  ]
}

module "cluster-metrics" {
  source           = "../../dependencies/cluster-metrics"
  hostname         = "dispatcher.concourse-ci.org"
  metrics_endpoint = module.wavefront.metrics_endpoint

  depends_on = [
    module.cluster.node_pools,
  ]
}
