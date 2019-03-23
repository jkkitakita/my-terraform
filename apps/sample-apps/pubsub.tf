variable "pubsub" {
  type = "map"

  default = {
    ack_deadline_seconds.dev = 20
    ack_deadline_seconds.qa  = 20
    ack_deadline_seconds.prd = 20
  }
}

# resource / module
module "pubsub" {
  source     = "github.com/terraform-google-modules/terraform-google-pubsub"
  topic      = "${local.environment}-${local.service_name}-topic"
  project_id = "${local.project_id}"

  pull_subscriptions = [
    {
      name                 = "${local.environment}-${local.service_name}-pull-dataflow"
      ack_deadline_seconds = "${var.pubsub[format(local.map_var_fmt, "ack_deadline_seconds", local.environment)]}"
    },
  ]
}
