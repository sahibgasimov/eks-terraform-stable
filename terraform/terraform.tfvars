#### Cluster and Nodes ####
cluster_name    = "dev"
cluster_version = "1.24"
environment = "dev"
instance_types = "t3.small"
/* nodes_volume_size = "20"
volume_type = "gp2" */
#image_id = "ami-0b4795e99297c2650"

#autoscaling desired instance size 
desired_size = 2
max_size     = 5
min_size     = 2
max_unavailable = 1

#### Route53 Domain ####
region         = "us-east-1"
domain         = "cmcloudlab1629.info"
hosted_zone_id = "Z10393931BKL476LLE0CK"

##### Networking #####
vpc_cidr         = "10.0.0.0/16"
private_subnet_1 = "10.0.0.0/19"
private_subnet_2 = "10.0.32.0/19"
private_subnet_3 = "10.0.128.0/19"
public_subnet_1  = "10.0.64.0/19"
public_subnet_2  = "10.0.96.0/19"
public_subnet_3  = "10.0.160.0/19"
