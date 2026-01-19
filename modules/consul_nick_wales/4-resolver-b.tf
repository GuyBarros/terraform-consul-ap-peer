resource "consul_config_entry_service_resolver" "a_b_testing-b" {
  name            = "a-b-test-b"
  connect_timeout = "10s"
  request_timeout = "15s"

  redirect {
    service = "a-b-test"
    service_subset = "b-side"
  }
}