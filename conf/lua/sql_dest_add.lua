local sql = require 'ljsqlite3'
local cjson = require "cjson"

local conn = sql.open("/data/db/proxy.db", 'rwc')

local function replace_record(conn, domain, container)

    local sqlstr = "REPLACE INTO proxy_tbl VALUES('"..domain.."', '"..container.."');"
    local res, nrow = conn:exec(sqlstr)
    -- if success res is nil and nrow is 0
    if nrow == 0 then
        code = "succeed" 
    else
        code = "fail"
    end
    ngx.header.content_type = "application/json; charset=utf-8"
    ngx.say(cjson.encode({ code = code }))
end

replace_record(conn, ngx.var.arg_domain, ngx.var.arg_container)

