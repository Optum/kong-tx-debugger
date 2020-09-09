# Kong Tx Debugger
Log API Request and Response Data to Kong STDOUT

## Configuration
You can add the plugin to a ```route``` kong resource with the following request:

```bash
$ curl -X POST http://kong:8001/routes/{route name or id}/plugins \
    --data "name=kong-tx-debugger" \
    --data "config.log_request_headers=true" \
    --data "config.log_request_query_params=true" \
    --data "config.log_request_body=true" \
    --data "config.log_response_headers=true" \
    --data "config.log_response_body=true" \
    --data "config.max_response_body_size=65536" \
    --data "config.log_on_response_status=500" \
    --data "config.ngx_log_buffer_size=4012" \
```

## Sample Log Output:

```
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:33 [kong-tx-debugger] -------- START OF LOGGED TX -------- while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:38 [kong-tx-debugger] Request Header #1 host : some-host.company.com while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:38 [kong-tx-debugger] Request Header #2 x-forwarded-proto : https while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:38 [kong-tx-debugger] Request Header #3 x-forwarded-for : 10.xxx.xxx.x while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:38 [kong-tx-debugger] Request Header #4 x-forwarded-host : some-host.company.com while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:38 [kong-tx-debugger] Request Header #5 connection : Close while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:38 [kong-tx-debugger] Request Header #6 forwarded : for=10.xxx.xxx.x;host=some-host.company.com;proto=https;proto-version= while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:38 [kong-tx-debugger] Request Header #7 headertest : test1 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:38 [kong-tx-debugger] Request Header #8 x-forwarded-port : 443 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:62 [kong-tx-debugger] Request Body: {"message":"test"} while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #1 content-type : application/json; charset=utf-8 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #2 company-cid-ext : 4c956f83-b7ba-4024-845d-7041c25bf7e7#27478 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #3 connection : close while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #4 x-ratelimit-limit-second : 500 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #5 ratelimit-reset : 1 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #6 content-length : 21 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #7 x-ratelimit-remaining-second : 499 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #8 x-response-latency : 297 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #9 ratelimit-limit : 500 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:69 [kong-tx-debugger] Response Header #10 ratelimit-remaining : 499 while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:85 [kong-tx-debugger] Response Body: {"message":"Success"} while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
2020/09/08 19:07:31 [notice] 19456#0: *9908058 [kong] handler.lua:88 [kong-tx-debugger] -------- END OF LOGGED TX -------- while logging request, client: 10.xxx.xxx.x, server: kong, request: "GET /some/route HTTP/1.1", host: "some-host.company.com"
```

We recommend applying this to individual kong ```route``` or ```service``` resource and be sure to remove it when done debugging, as all the additional logging and request/response body reading.


## Supported Kong Releases
Kong >= 2.X.X

## Installation
Recommended:
```
$ luarocks install kong-tx-debugger
```
Other:
```
$ git clone https://github.com/Optum/kong-tx-debugger.git /path/to/kong/plugins/kong-tx-debugger
$ cd /path/to/kong/plugins/kong-tx-debugger
$ luarocks make *.rockspec
```

## Maintainers
[jeremyjpj0916](https://github.com/jeremyjpj0916)


Feel free to open issues, or refer to our [Contribution Guidelines](https://github.com/Optum/kong-tx-debugger/blob/master/CONTRIBUTING.md) if you have any questions.
