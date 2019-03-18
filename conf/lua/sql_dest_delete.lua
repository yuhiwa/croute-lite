local sql = require 'ljsqlite3'
local cjson = require "cjson"

local conn = sql.open("/data/db/proxy.db", 'rwc')

local function delete_record(conn, domain)

    local res_json = {}
    local selectstr = "SELECT * FROM proxy_tbl WHERE domain = '"..domain.."';"
    local domain, container = conn:rowexec(selectstr)
    if container == nil then
        res_json["code"] = false
        res_json["message"] = "data not found"
        ngx.header.content_type = "application/json; charset=utf-8"
        ngx.say(cjson.encode(res_json))
        return
    end

    local deletestr = "DELETE FROM proxy_tbl WHERE domain = '"..domain.."';"
    local res, nrow = conn:exec(deletestr)
    if nrow == 0 then
        res_json["code"] = true
        res_json["message"] = "succeed"
    else
        res_json["code"] = false
        res_json["message"] = "unknown error"
    end
    ngx.header.content_type = "application/json; charset=utf-8"
    ngx.say(cjson.encode(res_json))
end

delete_record(conn, ngx.var.arg_domain, ngx.var.arg_container)

