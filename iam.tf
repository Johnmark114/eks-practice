resource "aws_iam_user" "dev" {
  name = "innocent"
  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "dev" {
  user = aws_iam_user.dev.name
}
resource "aws_iam_policy" "eks_view_policy" {
  name        = "EKSViewPolicy"
  description = "Read-only access to view EKS cluster resources"
  policy      = file("eks_view_policy.json") 
}


data "aws_iam_policy_document" "readonly" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*", "eks:list*","eks:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "iam_policy" {
  name   = "dev"
  user   = aws_iam_user.dev.name
  policy = data.aws_iam_policy_document.readonly.json
}

resource "aws_iam_user_login_profile" "dev" {
  user    = aws_iam_user.dev.name
 # pgp_key = "keybase:dev"

}

resource "aws_eks_access_policy_association" "dev-eks-access" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminViewPolicy"
  principal_arn = aws_iam_user.dev.arn

  access_scope {
    type       = "namespace"
    namespaces = ["default"]
  }
}