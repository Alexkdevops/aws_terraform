variable AWS_REGION {
    default = "us-east-1"
}

variable AMI {
    type = map
    default = {
        us-east-1 = "ami-026656ba14e7cdc71"
        us-east-2 = "ami-026656ba14e7cdc71"
    }
}

variable PRIVATE_KEY_PATH {
    default = "my-project-key"
}

variable PUB_KEY_PATH {
    default = "my-project-key.pub"
}

variable USERNAME {
    default = "ubuntu"
}

# variable MYIP {
#     default = ["${chomp(data.http.myip.body)}/32"] 
# }

variable rmquser {
    default = "rabbit"
}

variable dbname {
    default = "accounts"
}

variable dbuser {
    default = "admin"
}

variable dbpass {
    default = "admin123"
}

variable instance_count {
    default = "1"
}

variable VPC_NAME {
    default = "default-terraform"
}

variable Zone1 {
    default = "us-east-1a"
}

variable Zone2 {
    default = "us-east-1b"
}

variable VpcCIDR {
    default = "172.21.0.0/16"
}

variable PubSub1CIDR {
    default ="172.21.10.0/24"
}

variable PubSub2CIDR {
    default ="172.21.20.0/24"
}

variable PrivSub1CIDR {
    default ="172.21.30.0/24"
}

variable PrivSub2CIDR {
    default ="172.21.40.0/24"
}