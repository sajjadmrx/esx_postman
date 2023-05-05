Customers = {
    list = {}
}

--- Creating an object
---@param o any
---@param list table
---@return any
function Customers:new(o, list)
    o = o or {}
    setmetatable(o, self)
    self.__index = self;
    self.list = list

    return o
end

---get All Customers
---@return table
function Customers:find()
    return self.list
end

--- clear All Customers
function Customers:clear()
    self.list = {}
end

--- get a customer
---@return vector3 | nil
function Customers:get()
    return self.list[1] or nil
end

--- set Customers list
---@param list table
function Customers:set(list)
    self.list = list
end

--- Delete a customer
---@param customer vector3
---@return boolean
function Customers:pick(customer)
    for i, c in ipairs(self.list) do
        if c.x == customer.x and c.y == customer.y and c.z == customer.z then
            table.remove(self.list, i)
            return true
        end
    end
    return false
end

---comment
---@param customer vector3
---@return boolean
function Customers:has(customer)
    for _, v in ipairs(self.list) do
        if v == customer then
            return true
        end
    end
    return false
end
