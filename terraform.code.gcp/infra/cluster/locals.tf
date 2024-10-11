locals {
    cluster_name    = "${var.project_name}-${var.environment}-cluster"
    pool_name       = "${var.project_name}-${var.environment}-pool"
    subnet_name     = "subnet-${var.project_name}-${var.environment}"
    vpc_name        = "vpc-${var.project_name}-${var.environment}"            
}