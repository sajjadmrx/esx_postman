Customers = {
    {
        x = 293.5,
        y = -590.2,
        z = 42.7
    },
    {
        x = 253.4,
        y = -375.9,
        z = 44.1
    }
}

---get All Customers
---@return table
function GetAllCustomers()
    return Customers
end

--- clear All Customers
function ClearCustomers()
    Customers = {}
end

--- get a customer
---@return vector3 | nil
function GetCustomer()
    return Customers[1] or nil
end

--- set Customers list
---@param list table
function SetCustomers(list)
    Customers = list
end

--- Delete a customer
---@param customer vector3
---@return boolean
function PickCustomer(customer)
    for i, c in ipairs(Customers) do
        if c.x == customer.x and c.y == customer.y and c.z == customer.z then
            table.remove(Customers, i)
            return true
        end
    end
    return false
end

---comment
---@param customer vector3
---@return boolean
function HasCustomer(customer)
    for _, v in ipairs(Customers) do
        if v.x == customer.x and v.y == customer.y and v.z == customer.z then
            return true
        end
    end
    return false
end
