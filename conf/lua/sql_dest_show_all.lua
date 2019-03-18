local sql = require 'ljsqlite3'
local cjson = require "cjson"

local conn = sql.open("/data/db/proxy.db", 'rwc')

local function show_all_record(conn)
    local data_json = {}
    local all_json = {}
    local map_json = {}

    local stmt = conn:prepare("SELECT * FROM proxy_tbl") 
    local row, names = stmt:step({}, {})
    if row == nil then
            ngx.say(cjson.encode(all_json))
        return
    end

    local domain, container = unpack(row)
    map_json["domain"] = domain
    map_json["container"] = container
    table.insert(data_json, map_json)

    while stmt:step(row) do
        local map_json = {}
        local domain, container = unpack(row)
        map_json["domain"] = domain
        map_json["container"] = container
        table.insert(data_json, map_json)
    end

    all_json["data"] = data_json
    ngx.header.content_type = "application/json; charset=utf-8"
    ngx.say(cjson.encode(all_json))
end

show_all_record(conn)
