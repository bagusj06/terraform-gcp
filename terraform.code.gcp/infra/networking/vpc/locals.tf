locals {
    subnet_name     = "subnet-${var.project_name}-${var.environment}"
    vpc_name        = "vpc-${var.project_name}-${var.environment}"
    nat_name        = "${var.project_name}-${var.environment}-nat"
    nat_router_name = "router-${var.project_name}-${var.environment}"
}