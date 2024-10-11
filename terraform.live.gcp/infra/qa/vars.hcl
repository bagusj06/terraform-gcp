locals{
    project_name        = "dcs"
    gcp_project_id      = "dcs-dev-419201"
    remote_state_bucket = "backend-terraform-${local.project_name}-${local.environment}"
    region              = "asia-southeast2"
    zone                = "asia-southeast2-a"
    environment         = "qa"
    git_repo_token      = get_env("GIT_REPO_TOKEN")

    module_version = {
        artifact        = "10c715d838cccf88e585f540a1e8d8697d457667"
        pubsub          = "c43f3a2c2ee6ce69bfed858641de80c4cb10eb86"
    }

    vpc = {
       ip_cidr_range    = "172.16.5.64/26" 
    }

    cluster = {
        project_id              = "local.gcp_project_id"
        project_name            = "local.project_name"
        region                  = "local.region"
        zone                    = "asia-southeast2-a"
        environment             = "local.environment"
        disk_size               = "20"
        disk_type               = "pd-ssd"
        min_node_count          = "1"
        max_node_count          = "3"
        machine_type            = "n1-standard-1"
        disk_size_gb            = "20"
        deletion_protection     = "false"
        master_ipv4_cidr_block  = "172.16.7.0/28"
        release_channel         = "REGULAR"
        cluster_ipv4_cidr_block = "10.121.0.0/20"
        services_ipv4_cidr_block= "10.122.0.0/20"
        maintenance_start_time  = "2024-04-25T18:00:00Z"
        maintenance_end_time    = "2024-04-25T22:00:00Z"
        maintenance_recurrence  = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
    }

    cloud_sql = {
        database_version        = "POSTGRES_15"
        instance_tier           = "db-custom-1-3840"
    }
}