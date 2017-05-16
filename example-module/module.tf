variable "command" {
  default = "echo 'Hello World'"
}

resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "${var.command}"
  }
}

output "command" {
  value = "${null_resource.null.local-exec.command}"
}
