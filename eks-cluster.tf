module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = "1.33"

  addons = {
    coredns = {
      before_compute = true
      most_recent = true
    }

    eks-pod-identity-agent = {
      before_compute =true
    }

    kube-proxy = {}

    vpc-cni = {
      before_compute = true
    }

    aws-ebs-csi-driver = {
      most_recent = true
      service_account_role_arn = "arn:aws:iam::812835203419:role/AmazonEKS_EBS_CSI_DriverRole"
    }
  }

  iam_role_additional_policies = {
    AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }

  endpoint_public_access                   = true
  enable_irsa                              = true
  # enable_cluster_creator_admin_permissions = false

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    innovatemart-nodegroup = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    Name                                       = var.cluster_name
    Environment                                = "dev"
    Terraform                                  = "production"
  }

  access_entries = {
    InnovateMart = {
      kubernetes_group = []
      principal_arn    = "arn:aws:iam::812835203419:user/InnovateMart"

      policy_associations = {
       InnovateMartPolicy = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type       = "cluster"
          }
        }
      }
    }

     Innocent = {
    kubernetes_group = []
    principal_arn    = aws_iam_role.innocent_role.arn

    policy_associations = {
      Innocent = {
        policy_arn   = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
        access_scope = {
          type       = "cluster"
          }
        }
      }
    }
  }
}
