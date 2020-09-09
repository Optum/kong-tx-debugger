local typedefs = require "kong.db.schema.typedefs"

return {
  name = "kong-tx-debugger",
  fields = {
    { consumer = typedefs.no_consumer },
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { log_request_headers = { type = "boolean", required = false, default = true }, },
          { log_request_query_params = { type = "boolean", required = false, default = false }, },
          { log_request_body = { type = "boolean", required = false, default = false }, },
          { log_response_headers = { type = "boolean", required = false, default = true }, },
          { log_response_body = { type = "boolean", required = false, default = false }, },
          { max_response_body_size = { type = "number", default = 65536 }, },
          { log_on_response_status = { type = "string", required = false}, },
          { ngx_log_buffer_size = { type = "number", default = 4012 }, },
    }, }, },
  },
}
