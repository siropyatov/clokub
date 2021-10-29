resource "aws_route53_zone" "private" {
  name = "task-15_2.com"

  vpc {
    vpc_id = aws_vpc.vpc-task.id
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "www.task-15_2.com"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_elb.netology-elb.dns_name]
}