##############
#Common     #
#############

random_instance_name = true
project_id           = "formlabs-377008"
database_version     = "MYSQL_8_0"
region               = "us-central1"           


########################
# Master Configuration #
########################

tier                            = "db-custom-1-3840"
zone                            = "us-central1-c"
availability_type               = "REGIONAL"
maintenance_window_day          = 7
maintenance_window_hour         = 12
maintenance_window_update_track = "stable"

deletion_protection = false

database_flags = [
  { name = "autovacuum", value = "off" }
]

user_labels = {
  foo = "bar"
}

ip_configuration = {
  ipv4_enabled       = true
  require_ssl        = true
  private_network    = null
  allocated_ip_range = null
  authorized_networks = [
    {
      name  = "demo-network"
      value = "10.10.10.0/24"
    },
  ]
}
backup_configuration = {
  enabled                        = true
  start_time                     = "20:55"
  location                       = null
  point_in_time_recovery_enabled = false
  transaction_log_retention_days = null
  retained_backups               = 365
  retention_unit                 = "COUNT"
}


################################
# Read Replicas Configurations #
################################

read_replicas = [
  {
    name = "0"
    zone = "us-central1-a"
    tier = "db-custom-1-3840"
    ip_configuration = {
      ipv4_enabled       = true
      require_ssl        = false
      private_network    = null
      allocated_ip_range = null
      authorized_networks = [
        {
          name  = "demo2-network"
          value = "10.10.10.0/24"
        },
      ]
    }
    database_flags        = [{ name = "autovacuum", value = "off" }]
    disk_autoresize       = null
    disk_autoresize_limit = null
    disk_size             = null
    disk_type             = "PD_HDD"
    user_labels           = { bar = "baz" }
    encryption_key_name   = null
  },
  {
    name = "1"
    zone = "us-central1-b"
    tier = "db-custom-1-3840"
    ip_configuration = {
      ipv4_enabled       = true
      require_ssl        = false
      private_network    = null
      allocated_ip_range = null
      authorized_networks = [
        {
          name  = "demo2-network"
          value = "10.10.10.0/24"
        },
      ]
    }
    database_flags        = [{ name = "autovacuum", value = "off" }]
    disk_autoresize       = null
    disk_autoresize_limit = null
    disk_size             = null
    disk_type             = "PD_HDD"
    user_labels           = { bar = "baz" }
    encryption_key_name   = null
  }
]
pg_ha_name   = "tf-pg-ha"
db_charset   = "UTF8"
db_collation = "en_US.UTF8"

user_name     = "tftest-01"
user_password = "tftest#2022"

additional_databases = [
  {
    name      = "test-additional-01"
    charset   = "UTF8"
    collation = "en_US.UTF8"
  },
]
additional_users = [
  {
    name     = "tftest2"
    password = "abcdefg"
    host     = "localhost"
  },
  {
    name     = "tftest3"
    password = "abcdefg"
    host     = "localhost"
  },
]
