resource "consul_config_entry" "http_route_api_gateway-a-b-test" {
  kind = "http-route"
  name = "api-gateway-a-b-test"

  config_json = jsonencode({
    Parents = [
        {
            Kind = "api-gateway"
            Name = "api-gateway"
            SectionName = "http-listener"
        }
    ]

    Hostnames = ["a-b-test", "192.168.11.94"]

    Rules = [
      ### A side
      {
        Filters = {
          Headers = null,
          URLRewrite = null
        }
        Matches = [
          {
            Headers = [
              {
                Match = "exact"
                Name = "X-Backend-Service"
                Value = "a-side"
              }              
            ]
            Method = ""
            Path = {
              Match = "prefix"
              Value = "/"
            }
            Query = null
          }
        ]
        Services = [
          {
            Name = "a-b-test-a"
            Weight = 1
            Filters = {
              Headers = null
              URLRewrite = null
            }
          }
        ]
      },
      ### B Side
      {
        Filters = {
          Headers = null,
          URLRewrite = null
        }
        Matches = [
          {
            Headers = [
              {
                Match = "exact"
                Name = "X-Backend-Service"
                Value = "b-side"
              }              
            ]
            Method = ""
            Path = {
              Match = "prefix"
              Value = "/"
            }
            Query = null
          }
        ]
        Services = [
          {
            Name = "a-b-test-b"
            Weight = 1
            Filters = {
              Headers = null
              URLRewrite = null
            }
          }
        ]
      },
      ### Random with no header
      {
        Filters = {
          Headers = null,
          URLRewrite = null
        }
        Matches = [
          {
            Headers = null
            Method = ""
            Path = {
              Match = "prefix"
              Value = "/"
            }
            Query = null
          }
        ]
        Services = [
          {
            Name = "a-b-test"
            Weight = 1
            Filters = {
              Headers = null
              URLRewrite = null
            }
          }
        ]
      }              
    ]
  })
}