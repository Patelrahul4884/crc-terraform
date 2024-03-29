data "aws_acm_certificate" "my_certificate" {
  domain   = "${var.environment_acronym}.rahulpatel.cloud"  # Replace with your domain name
  statuses = ["ISSUED", "PENDING_VALIDATION"]      # Filter to only include issued certificates
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "CloudWatchLogsPolicy" {
  statement {
    sid = "AllowWriteToCloudWatchLogs"
    effect = "Allow"
    actions = [ 
        "logs:CreateLogGroup",
        "logs:CreateLogsStream",
        "logs:PutLogEvents" 
        ]
    resources = [ "*" ]
  }
}

data "aws_iam_policy_document" "DynamoDBPolicy" {
    statement {
    effect = "Allow"
    actions = [ "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem", ]
    resources = [ 
        aws_dynamodb_table.visit_counter.arn,
        aws_dynamodb_table.unique_visitor.arn
        ]
  }
}
