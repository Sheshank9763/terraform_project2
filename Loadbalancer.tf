resource "aws_lb" "LB1" {
  name               = "LB1"
  load_balancer_type = "application"
  internal           = "false"
  security_groups    = [aws_security_group.sg1.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
  tags = {
    Name = "LB1"
  }
}
resource "aws_lb_target_group" "TG1" {
  name     = "TG1"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
  health_check {
    path = "/"
    port = "80"
  }
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.LB1.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.TG1.arn
    type             = "forward"
  }
}
resource "aws_alb_target_group_attachment" "TG1" {
    target_group_arn = aws_lb_target_group.TG1.id
    target_id = aws_instance.public-ec2.id
    port = 80
}
resource "aws_alb_target_group_attachment" "TG2" {
    target_group_arn = aws_lb_target_group.TG1.id
    target_id = aws_instance.private-ec2.id
    port = 80
}
output "loadbalancerdns" {
  value = aws_lb.LB1.dns_name
}