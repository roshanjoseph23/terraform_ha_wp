resource "aws_lb_target_group" "hawpmaster" {
  name        = "hawpmaster"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check {
    protocol            = "HTTP"
    port                = 80
    path                = "/wp-admin/healthcheck.html"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
    interval            = 30
  }
}

resource "aws_lb_target_group" "hawpslave" {
  name        = "hawpslave"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check {
    protocol            = "HTTP"
    port                = 80
    path                = "/healthcheck.html"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
    interval            = 30
  }
}

resource "aws_lb" "hawordpress" {
  name               = "hawordpress"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_ha_alb]
  subnets            = [var.ha_wp_pub1_id, var.ha_wp_pub2_id, var.ha_wp_pub3_id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "hawpslave01" {
  load_balancer_arn = aws_lb.hawordpress.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hawpslave.arn
  }
}

resource "aws_lb_listener" "hawpslave02" {
  load_balancer_arn = aws_lb.hawordpress.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:060377381042:certificate/fa825fa1-88d7-452c-9d06-24a85d64ee92"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hawpslave.arn
  }
}

resource "aws_lb_listener_rule" "master" {
  listener_arn = aws_lb_listener.hawpslave01.arn
  priority     = 2
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hawpmaster.arn
  }
  condition {
    path_pattern {
      values = ["/wp-admin/*", "/wp-login.php"]
    }
  }
}

resource "aws_lb_listener_rule" "master02" {
  listener_arn = aws_lb_listener.hawpslave02.arn
  priority     = 2
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hawpmaster.arn
  }
  condition {
    path_pattern {
      values = ["/wp-admin/*", "/wp-login.php"]
    }
  }
}
