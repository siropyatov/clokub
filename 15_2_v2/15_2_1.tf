resource "aws_s3_bucket" "b_suba" {
  bucket = "netology29102022"
  acl    = "public-read"

  tags = {
    Name    = "bucket"
  }
}

resource "aws_s3_bucket_object" "img" {
  bucket = aws_s3_bucket.b_suba.id
  key    = "suba_image.png"
  source = "image.png"
  acl    = "public-read"

  etag = filemd5("image.png")
}

data "aws_s3_bucket" "b_suba" {
  bucket = aws_s3_bucket.b_suba.id
}

data "aws_s3_bucket_object" "img" {
  bucket = aws_s3_bucket.b_suba.id
  key    = aws_s3_bucket_object.img.id
}