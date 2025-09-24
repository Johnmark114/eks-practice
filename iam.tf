resource "aws_iam_user" "dev" {
  name = "innocent"
  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "dev" {
  user = aws_iam_user.dev.name
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
  cluster-name  = module.eks.cluster-name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminViewPolicy"
  principal_arn = aws_iam_user.dev.arn

  access_scope {
    type       = "namespace"
    namespaces = ["default"]
  }
}