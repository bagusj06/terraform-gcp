resource "google_pubsub_subscription" "dcs_service" {
  name  = local.subs_name
  topic = google_pubsub_topic.dcs_service.id

  message_retention_duration = "604800s"
  retain_acked_messages      = false

  expiration_policy {
    ttl = ""
  }

  ack_deadline_seconds = 180

  enable_message_ordering    = false
}