resource "consul_config_entry_service_resolver" "a_b_testing" {
  name            = "a-b-test"
  connect_timeout = "10s"
  request_timeout = "15s"

  subsets {
    name   = "a-side"
    filter = "Service.Meta.version == a_side"
    only_passing = false
  }

  subsets {
    name   = "b-side"
    filter = "Service.Meta.version == b_side"
    only_passing = false
  }
}   