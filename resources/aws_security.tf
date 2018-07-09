resource "aws_security_group" "kubernetes" {
  vpc_id = "${aws_vpc.kubernetes.id}"
  name = "kubernetes"

  # Allow all outbound
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    ##cidr_blocks = ["0.0.0.0/0"]
    cidr_blocks = ["10.43.0.1/16"]
  }

  # Allow all internal
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  # Allow all traffic from the API ELB
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = ["${aws_security_group.kubernetes_api.id}"]
  }

  # Allow all traffic from control host IP
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["${var.control_cidr}"]
  }
}

##resource "aws_security_group" "kubernetes_api" {
##  vpc_id = "${aws_vpc.kubernetes.id}"
##  name = "kubernetes-api"

##  # Allow inbound traffic to the port used by Kubernetes API HTTPS
##  ingress {
##    from_port = 6443
##    to_port = 6443
##    protocol = "TCP"
##    cidr_blocks = ["${var.control_cidr}"]
##  }

##  # Allow all outbound traffic
##  egress {
##    from_port = 0
##    to_port = 0
##    protocol = "-1"
##    cidr_blocks = ["0.0.0.0/0"]
##  }
##}