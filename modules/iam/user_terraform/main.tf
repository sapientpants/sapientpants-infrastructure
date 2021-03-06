resource "aws_iam_user" "user" {
  name = "terraform"
  path = "/system/"
}

resource "aws_iam_access_key" "access_key" {
  user    = aws_iam_user.user.name
  pgp_key = var.pgp_key
}

resource "aws_iam_user_policy" "policy" {
  name   = "terraform"
  user   = aws_iam_user.user.name
  policy = data.aws_iam_policy_document.document.json
}

data "aws_iam_policy_document" "document" {
  statement {
    actions = [
      "*",
    ]

    resources = [
      "*",
    ]
  }
}
