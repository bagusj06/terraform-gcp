output "topic_name" {
  value = google_pubsub_topic.dcs_service.name
}

output "subs_name" {
  value = google_pubsub_subscription.dcs_service.name
}