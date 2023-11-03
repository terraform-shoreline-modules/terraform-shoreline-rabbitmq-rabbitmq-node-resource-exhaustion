resource "shoreline_notebook" "rabbitmq_node_resource_exhaustion" {
  name       = "rabbitmq_node_resource_exhaustion"
  data       = file("${path.module}/data/rabbitmq_node_resource_exhaustion.json")
  depends_on = [shoreline_action.invoke_change_resource_allocation]
}

resource "shoreline_file" "change_resource_allocation" {
  name             = "change_resource_allocation"
  input_file       = "${path.module}/data/change_resource_allocation.sh"
  md5              = filemd5("${path.module}/data/change_resource_allocation.sh")
  description      = "Increase the resources allocated to the RabbitMQ node, such as CPU, memory, and disk space."
  destination_path = "/tmp/change_resource_allocation.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_change_resource_allocation" {
  name        = "invoke_change_resource_allocation"
  description = "Increase the resources allocated to the RabbitMQ node, such as CPU, memory, and disk space."
  command     = "`chmod +x /tmp/change_resource_allocation.sh && /tmp/change_resource_allocation.sh`"
  params      = ["YOUR_NODE_NAME","NEW_MEMORY_ALLOCATION","NEW_CPU_ALLOCATION"]
  file_deps   = ["change_resource_allocation"]
  enabled     = true
  depends_on  = [shoreline_file.change_resource_allocation]
}

