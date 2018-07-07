resource "aws_instance" "worker" {
    count = 1
    tags {
      Owner = "Lorenzo"
      Name = "worker-${count.index}"
      ansibleFilter = "Kubernetes01"
      ansibleNodeType = "worker"
      ansibleNodeName = "worker${count.index}"
    }
  }
}