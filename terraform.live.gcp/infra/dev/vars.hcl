locals{
    project_name        = "fiducia"
    gcp_project_id      = "fiducia-dev-437604"
    remote_state_bucket = "backend-terraform-${local.project_name}-${local.environment}"
    region              = "asia-southeast2"
    zone                = "asia-southeast2-a"
    environment         = "dev"
    git_repo_token      = get_env("GIT_REPO_TOKEN")

    module_version = {
        vpc             = "3a81cb6cbfaa45a3daec7d4580b23831c14a5a06"
        firewall_rules  = "3a81cb6cbfaa45a3daec7d4580b23831c14a5a06"
        cluster         = "3a81cb6cbfaa45a3daec7d4580b23831c14a5a06"
        artifact        = "3a81cb6cbfaa45a3daec7d4580b23831c14a5a06"
        peering_vpc     = "3a81cb6cbfaa45a3daec7d4580b23831c14a5a06"
        service_account = "3a81cb6cbfaa45a3daec7d4580b23831c14a5a06"
        cloud_sql       = "3a81cb6cbfaa45a3daec7d4580b23831c14a5a06"
        pubsub          = "3a81cb6cbfaa45a3daec7d4580b23831c14a5a06"
    }

    vpc = {
       ip_cidr_range    = "172.16.6.128/26" 
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
        master_ipv4_cidr_block  = "10.100.0.0/28"
        release_channel         = "REGULAR"
        cluster_ipv4_cidr_block = "10.50.0.0/21"
        services_ipv4_cidr_block= "10.51.0.0/22"
        maintenance_start_time  = "2024-10-10T18:00:00Z"
        maintenance_end_time    = "2024-10-10T22:00:00Z"
        maintenance_recurrence  = "FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR"
    }

    cloud_sql = {
        database_version        = "POSTGRES_16"
        instance_tier           = "db-custom-1-3840"
    }
}