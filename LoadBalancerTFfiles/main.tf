resource "aws_lb" "web" {
  name               = var.AWSALBName
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.Subnetid

  //enable_deletion_protection = true

  tags = {
    Name = var.AWSALBName
  }
}
resource "aws_lb_target_group" "web" {
  name     = var.TargetGroup["name"]
  port     = var.TargetGroup["port"]
  protocol = var.TargetGroup["protocol"]
  vpc_id   = var.VPCid
  target_type = var.TargetGroup["target_type"]
}
/*resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.web.arn
  //for_each = var.webservers
  target_id        = aws_instance.web.id
  port             = 80
}*/
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"
 // ssl_policy        = "ELBSecurityPolicy-2016-08"
  //certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}
resource "aws_security_group" "lb_sg" {
  name = "ALBsSG"
  // description = "Allow TLS inbound traffic"
  vpc_id = var.VPCid

  dynamic "ingress" {
    // description      = "TLS from VPC"
    for_each = var.SGForALB
    content {
    from_port   = ingress.value
    to_port     = ingress.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //   ipv6_cidr_blocks = [aws_vpc.vpc1.ipv6_cidr_block]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.ALBSGName
  }
}