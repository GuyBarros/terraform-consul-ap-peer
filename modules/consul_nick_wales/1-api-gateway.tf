resource "consul_config_entry" "api_gateway" {
  kind = "api-gateway"
  name = "api-gateway"

  config_json = jsonencode({
    Listeners = [
      {
        Name = "http-listener"
        Port = 8088
        Protocol = "http"
        TLS = {
          Certificates = null
        }
      }
    ]    
  })
}