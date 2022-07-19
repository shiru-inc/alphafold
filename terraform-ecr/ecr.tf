resource "aws_ecr_repository" "alphafold" {
  name = "alphafold"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "alphafold-dl" {
  name = "alphafold-dl"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_iam_policy_document" "data-account-policy" {
  statement {
    sid    = "AllowECRReadAccess"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::582526512915:root"]
    }
    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      # "ecr:CompleteLayerUpload",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      # "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      # "ecr:PutImage",
      # "ecr:UploadLayerPart"
    ]
  }
}

resource "aws_ecr_repository_policy" "data-account-readible" {
  repository = aws_ecr_repository.etl-alphafold.name
  policy     = data.aws_iam_policy_document.data-account-policy.json
}
resource "aws_ecr_repository_policy" "data-account-readible-dl" {
  repository = aws_ecr_repository.etl-alphafold-dl.name
  policy     = data.aws_iam_policy_document.data-account-policy.json
}
