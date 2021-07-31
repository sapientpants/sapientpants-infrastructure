resource "aws_iam_group" "group" {
  name = "Administrators"
}

resource "aws_iam_group_policy_attachment" "policy" {
  group      = aws_iam_group.group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_policy" "policy" {
  name        = "AdministratorPolicy"
  description = "Administrator policy"
  policy      = data.aws_iam_policy_document.document.json
}

data "aws_iam_policy_document" "document" {
  statement {
    sid = "AllowAdminIfMultiFactorEnabled"

    actions = [
      "*",
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"

      values = [
        "true",
      ]
    }
  }
}
