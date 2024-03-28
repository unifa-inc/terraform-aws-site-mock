output domain {
  value = aws_s3_bucket_website_configuration.mock.website_domain
}

output bucket_name {
  value = aws_s3_bucket.mock.id
}

output bucket_arn {
  value = aws_s3_bucket.mock.arn
}

output hosted_zone_id  {
  value = aws_s3_bucket.mock.hosted_zone_id 
}
