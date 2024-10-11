locals {
    db_name = "${var.project_name}-${var.environment}-db"
    private_ip_name = "${local.db_name}-private-ip"
}