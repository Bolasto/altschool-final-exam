
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                   = local.name
  cluster_version                = "1.25"
  cluster_endpoint_public_access = true
  # cluster_auth_token = data.aws_eks_cluster_auth.cluster_auth.token
  # EKS Cluster Addons
  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  # VPC

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  enable_irsa = true

  # Node Group(s)

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {

    use_name_prefix = true

    subnet_ids = module.vpc.private_subnets

    ami_type = "AL2_x86_64"

    enable_monitoring = true

    instance_types = ["t3.medium", "t3a.medium"]
    disk_size      = 50

    tags = {
      "k8s.io/cluster-autoscaler/enabled"       = "true"
      "k8s.io/cluster-autoscaler/${local.name}" = "owned"
    }

  }

  
  # aws-auth configmap
  # manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::234184299557:role/role1"
      username = "Bolasto"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::234184299557:user/user1"
      username = "Bolasto"
      groups   = ["system:masters"]
    },
    # {
    #   userarn  = "arn:aws:iam::66666666666:user/user2"
    #   username = "user2"
    #   groups   = ["system:masters"]
    # },
  ]

  aws_auth_accounts = [
    "234184299557",
    # "888888888888",
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "Cluster API to K8S services running on nodes"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  node_security_group_additional_rules = {
    ingress_cluster_api_ephemeral_ports_tcp = {
      description                   = "Cluster API to K8S services running on nodes"
      protocol                      = "tcp"
      from_port                     = 1025
      to_port                       = 65535
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }
eks_managed_node_groups = {

    default_worker_group = {
      name         = "EKS_default_group"
      desired_size = 3
      max_size     = 4
      min_size     = 1
      disk_size    = 50
    }
  }


}


# exec {
#   api_version = "client.authentication.k8s.io/v1beta1"
#   args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
#   command     = "aws"
# }




