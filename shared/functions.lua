--- table to string
---@param tbl table
---@return string | nil
function TableSerialize(tbl)
    if tbl == nil or tbl == "nil" then
        return ""
    end
    local str = "{"
    for k, v in pairs(tbl) do
        local key = type(k) == "number" and "[" .. k .. "]" or k
        local val = type(v) == "table" and TableSerialize(v) or tostring(v)
        str = str .. key .. "=" .. val .. ","
    end
    return str .. "}"
end

--- string to table
---@param str string
---@return table
function TableDeserialize(str)
    if str == nil or str == "nil" then
        return {}
    end
    return load("return " .. str)()
end
