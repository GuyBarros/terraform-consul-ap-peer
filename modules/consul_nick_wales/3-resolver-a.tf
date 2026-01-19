resource "consul_config_entry_service_resolver" "a_b_testing-a" {
  name            = "a-b-test-a"
  connect_timeout = "10s"
  request_timeout = "15s"

  redirect {
    service = "a-b-test"
    service_subset = "a-side"
  }
}