local kong = kong
local KongTxDebugger = {}

KongTxDebugger.PRIORITY = 99999
KongTxDebugger.VERSION = "1.0.1"

--Help break request and response bodies into loggable chunks(seems actually ~4096 byte limitation)
local function splitByChunk(text, chunkSize)
    local s = {}
    for i=1, #text, chunkSize do
        s[#s+1] = text:sub(i,i+chunkSize - 1)
    end
    return s
end

function KongTxDebugger:access(conf)
  if conf.log_request_body then
    kong.ctx.plugin.request_body = kong.request.get_raw_body()
  end
end

function KongTxDebugger:body_filter(conf)
  if conf.log_response_body and conf.max_response_body_size > 0 then
   local chunk = ngx.arg[1]
   local res_body = (kong.ctx.plugin.response_body or "") .. (chunk or "")
   kong.ctx.plugin.response_body = string.sub(res_body, 0, conf.max_response_body_size)
  end
end

--Plugin assumes right now a single header key:value pair is less than the ngx error buffer size limit(2048 bytes) otherwise ngx will truncate.
function KongTxDebugger:log(conf)
  if conf.log_on_response_status == nil or tonumber(conf.log_on_response_status) == kong.response.get_status() then
    kong.log("-------- START OF LOGGED TX --------") 

    if conf.log_request_headers then
      local i = 1
      for k,v in pairs(kong.request.get_headers(1000)) do 
        kong.log("Request Header #",tostring(i)," ", k," : ",v)
        i = i + 1
      end
    end

    if conf.log_request_query_params then
      local i = 1
      for k,v in pairs(kong.request.get_query(1000)) do 
        kong.log("Query Parameter #",tostring(i)," ", k," : ",v)
        i = i + 1
      end
    end

    if kong.ctx.plugin.request_body then
      if conf.ngx_log_buffer_size - 14 < string.len(kong.ctx.plugin.request_body) then
        kong.log("-------- START OF LARGE REQUEST BODY TX --------")
        local i = 1
        local request_body_array = splitByChunk(kong.ctx.plugin.request_body, conf.ngx_log_buffer_size - 25)
        for _,v in ipairs(request_body_array) do
           kong.log("Request Body Chunk #",tostring(i)," : ",v)
           i = i + 1
        end
        kong.log("-------- END OF LARGE REQUEST BODY TX --------")
      else
        kong.log("Request Body: ", kong.ctx.plugin.request_body)
      end
    end

    if conf.log_response_headers then
      local i = 1
      for k,v in pairs(kong.response.get_headers(1000)) do 
        kong.log("Response Header #",tostring(i)," ", k," : ",v)
        i = i + 1
      end
    end

    if kong.ctx.plugin.response_body then
      if conf.ngx_log_buffer_size - 15 < string.len(kong.ctx.plugin.response_body) then
        kong.log("-------- START OF LARGE RESPONSE BODY TX --------")
        local i = 1
        local response_body_array = splitByChunk(kong.ctx.plugin.response_body, conf.ngx_log_buffer_size - 26)
        for _,v in ipairs(response_body_array) do
           kong.log("Response Body Chunk #",tostring(i)," : ",v)
           i = i + 1
        end
        kong.log("-------- END OF LARGE RESPONSE BODY TX --------")
      else
        kong.log("Response Body: ", kong.ctx.plugin.response_body)
      end
    end
    kong.log("-------- END OF LOGGED TX --------")    
  end
end

return KongTxDebugger
