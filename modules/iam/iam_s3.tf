resource "aws_iam_role" "ha_wp_role" {
  name               = "ha_wp_role"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "s3.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF
  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "iampolicy" {
  name        = "s3_bucket_policy"
  description = "A s3 policy"

  policy = file("./modules/iam/iam.json")
}

resource "aws_iam_role_policy_attachment" "iam-attach" {
  role       = aws_iam_role.ha_wp_role.name
  policy_arn = aws_iam_policy.iampolicy.arn
}

resource "aws_iam_instance_profile" "s3_role" {
  name = "s3_profile"
  role = aws_iam_role.ha_wp_role.name
}
