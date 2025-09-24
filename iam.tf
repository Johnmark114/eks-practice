resource "aws_iam_role" "innocent_role" {
  name = "innocent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
resource "aws_iam_role_policy_attachment" "innocent_eks_policy" {
  role       = aws_iam_role.innocent_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
