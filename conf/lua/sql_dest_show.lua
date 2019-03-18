local sql = require 'ljsqlite3'
local cjson = require "cjson"

local conn = sql.open("/data/db/proxy.db", 'rwc')

local function show_record(conn, arg_domain)

    local map_json = {}

    local sqlstr = "SELECT * FROM proxy_tbl WHERE domain = '"..arg_domain.."';"
    local domain, container = conn:rowexec(sqlstr)

    if container == nil then
        local regex = "\\w+"
        local m = ngx.re.match(arg_domain, regex)
        container = m[0]   
    end
    map_json["domain"] = arg_domain
    map_json["container"] = container

    ngx.header.content_type = "application/json; charset=utf-8"
    ngx.say(cjson.encode(map_json))


end

show_record(conn, ngx.var.arg_domain)

