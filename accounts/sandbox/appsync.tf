# =============
# --- Roles ---
# -------------

# Lambda role

data "aws_iam_policy_document" "iam_lambda_role_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_lambda_role" {
  name               = "sandbox_iam_lambda_role"
  assume_role_policy = data.aws_iam_policy_document.iam_lambda_role_document.json
}

# Appsync role

data "aws_iam_policy_document" "iam_appsync_role_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["appsync.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_appsync_role" {
  name               = "sandbox_iam_appsync_role"
  assume_role_policy = data.aws_iam_policy_document.iam_appsync_role_document.json
}

# ================
# --- Policies ---
# ----------------

# Invoke Lambda policy

data "aws_iam_policy_document" "iam_invoke_lambda_policy_document" {
  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "iam_invoke_lambda_policy" {
  name   = "sandbox_iam_invoke_lambda_policy"
  policy = data.aws_iam_policy_document.iam_invoke_lambda_policy_document.json
}

# ===================
# --- Attachments ---
# -------------------

# Attach Invoke Lambda policy to AppSync role.

resource "aws_iam_role_policy_attachment" "appsync_invoke_lambda" {
  role       = aws_iam_role.iam_appsync_role.name
  policy_arn = aws_iam_policy.iam_invoke_lambda_policy.arn
}

# --- AppSync Setup ---

# Create the AppSync GraphQL api.
resource "aws_appsync_graphql_api" "appsync" {
  name                = "sandbox_appsync"
  schema              = file("schema.graphql")
  authentication_type = "API_KEY"
}

# Create the API key.
resource "aws_appsync_api_key" "appsync_api_key" {
  api_id = aws_appsync_graphql_api.appsync.id
}
