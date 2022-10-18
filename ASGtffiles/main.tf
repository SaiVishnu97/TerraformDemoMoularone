
resource "aws_launch_template" "web" {
  name = var.launchtemplate
  //name_prefix   = "foobar"
  image_id      = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_onweb1.id]
  key_name               = var.key_name
  //subnet_id              = aws_subnet.subnet-1.id
  depends_on = [
    aws_security_group.allow_onweb1
  ]
  //associate_public_ip_address = true
 // "${base64encode(data.template_file.test.rendered)}"
  user_data ="${base64encode(var.userData)}"

}

resource "aws_autoscaling_group" "web" {
 // availability_zones = var.AZ
    name             =  var.ASGName
  desired_capacity   = var.CapacitiesForASG["Desired"]
  max_size           = var.CapacitiesForASG["Maximum"]
  min_size           = var.CapacitiesForASG["Minimum"]
  
vpc_zone_identifier       = var.Subnetid
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
}
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.web.id
  lb_target_group_arn    = var.lb_target_group_arn
}

resource "aws_security_group" "allow_onweb1" {
  name = "Web1SG"
  // description = "Allow TLS inbound traffic"
  vpc_id = var.VPCid

  dynamic "ingress" {
    // description      = "TLS from VPC"
    for_each = var.SGForASG
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
    Name = var.ASGSGName
  }
}
