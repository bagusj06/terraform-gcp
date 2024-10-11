locals {
  topic_name = var.environment == "prod" ? "dsf-consent" : "dsf-consent-${var.environment}"
  subs_name  = var.environment == "prod" ? "dsf-consent_dcs" : "dsf-consent_dcs-${var.environment}"
}