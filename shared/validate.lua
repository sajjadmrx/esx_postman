Validate = {
    --- check player job
    ---@param xPlayer any
    ---@return boolean
    Job = function(xPlayer)
        if xPlayer and xPlayer.job and xPlayer.job.name == Config.jobKey then
            return true
        else
            return false
        end
    end
}
