resource aws_s3_bucket mock {
  bucket = var.bucket_name
  acl    = "public-read"
  policy = data.aws_iam_policy_document.mock.json

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource aws_s3_bucket_ownership_controls mock {
  bucket = aws_s3_bucket.mock.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

data aws_iam_policy_document mock {
  statement {
    actions = ["s3:GetObject"]

    resources = ["arn:aws:s3:::${var.bucket_name}/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }


    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.unifa_ips
    }
  }
}
