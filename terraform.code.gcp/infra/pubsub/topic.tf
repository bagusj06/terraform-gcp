resource "google_pubsub_topic" "dcs_service" {
  name = local.topic_name

  message_storage_policy {
    allowed_persistence_regions = [
      "${var.region}",
    ]
  }

  message_retention_duration = "2678400s"
}