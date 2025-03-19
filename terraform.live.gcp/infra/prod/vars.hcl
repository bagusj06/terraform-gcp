locals{
    project_name        = "project-a"
    gcp_project_id      = "project-id"
    remote_state_bucket = "backend-terraform-${local.project_name}-${local.environment}"
    region              = "asia-southeast2"
    zone                = "asia-southeast2-a"
    environment         = "prod"
    git_repo_token      = get_env("GIT_REPO_TOKEN")

    module_version = {
        vpc             = "7932e60606acacdcf0cea30fce4988ae66fe0d42"
        firewall_rules  = "7932e60606acacdcf0cea30fce4988ae66fe0d42"
        cluster         = "dbfcd713e87bf03b978d7f306480b9d0437323fe"
        artifact        = "10c715d838cccf88e585f540a1e8d8697d457667"
        peering_vpc     = "1c1e5d3f1bb30b17e27e413929f21851772acbf4"
        service_account = "f9efc65f13e1e63bd54ecef98fb7dad20376eb88"
        cloud_sql       = "85bedce0ffe91c35b8161d6396e23f5ecb9a3765"
        pubsub          = "888c192bad08780a88fe9bf8ab4c03cca4a2f001"
    }

    vpc = {
       ip_cidr_range    = "172.16.5.128/26" 
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
        machine_type            = "n2-standard-2"
        disk_size_gb            = "20"
        deletion_protection     = "false"
        master_ipv4_cidr_block  = "172.16.7.0/28"
        release_channel         = "REGULAR"
        cluster_ipv4_cidr_block = "10.121.0.0/20"
        services_ipv4_cidr_block= "10.122.0.0/20"
        maintenance_start_time  = "2024-04-25T18:00:00Z"
        maintenance_end_time    = "2024-04-25T22:00:00Z"
        maintenance_recurrence  = "FREQ=WEEKLY;BYDAY=SU,FR,SA"
    }

    cloud_sql = {
        database_version        = "POSTGRES_15"
        instance_tier           = "db-custom-2-7680"
    }
}
