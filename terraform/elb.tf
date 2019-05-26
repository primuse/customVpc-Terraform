# Create a new load balancer for the frontend instance
resource "aws_elb" "public" {
  name            = "sendit-public-elb"
  internal        = false
  security_groups = ["${aws_security_group.public_elb.id}"]
  subnets         = ["${aws_subnet.us-east-1a-public.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.frontend.id}"]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "sendit_public_elb"
  }
}

# Create a new load balancer for the api instance
resource "aws_elb" "private" {
  name            = "sendit-private-elb"
  internal        = true
  security_groups = ["${aws_security_group.private_elb.id}"]
  subnets         = ["${aws_subnet.us-east-1a-private.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.backend.id}"]
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 300

  tags = {
    Name = "sendit_private_elb"
  }
}
