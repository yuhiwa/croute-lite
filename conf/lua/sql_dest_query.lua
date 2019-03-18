local sql = require 'ljsqlite3'
local string = string

local conn = sql.open("/data/db/proxy.db", 'rwc')

local function query_record(conn, domain)
    local sqlstr = "SELECT * FROM proxy_tbl WHERE domain = '"..domain.."';"
    local domain, container = conn:rowexec(sqlstr)
    if container == nil then
        local regex = "\\w+"
        local m = ngx.re.match(ngx.var.host, regex)
        ngx.var.dest_address = m[0]
    else
        ngx.var.dest_address = container
    end
end

query_record(conn, ngx.var.host)
