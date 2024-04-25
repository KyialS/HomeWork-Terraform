resource "aws_launch_template" "foobar" {
  name_prefix   = var.name_prefix
  image_id      = data.aws_ami.ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg
}


resource "aws_autoscaling_group" "bar" {
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  vpc_zone_identifier = var.public_subnets

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
}