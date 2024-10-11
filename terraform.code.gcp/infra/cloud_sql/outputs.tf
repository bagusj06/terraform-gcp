output "connection_name" {
  description = "DB Connection Name"
  value = google_sql_database_instance.db_dcs.connection_name
}

output "public_ip_address" {
  description = "DB Public Endpoint"
  value = google_sql_database_instance.db_dcs.public_ip_address
}

output "private_ip_address" {
  description = "DB Private Endpoint"
  value = google_sql_database_instance.db_dcs.private_ip_address
}