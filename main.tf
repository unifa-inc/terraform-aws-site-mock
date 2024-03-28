resource aws_s3_bucket mock {
  bucket = var.bucket_name
}

resource aws_s3_bucket_website_configuration mock {
  bucket = aws_s3_bucket.mock.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource aws_s3_bucket_ownership_controls mock {
  bucket = aws_s3_bucket.mock.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource aws_s3_bucket_acl mock {
  bucket = aws_s3_bucket.mock.id
  acl    = "public-read"
}

resource aws_s3_bucket_public_access_block mock {
  bucket                  = aws_s3_bucket.mock.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource aws_s3_bucket_policy mock {
  bucket = aws_s3_bucket.mock.id
  policy = data.aws_iam_policy_document.mock.json
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
