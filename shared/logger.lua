local format = "%Y-%m-%d"
local ANSI = {
    Reset = "\027[0m",
    Red = "\027[31m",
    Yellow = "\027[33m",
}

Logger = {
    info = function(...)
        print("[INFO] ", ...)
    end,
    error = function(...)
        print("[ERROR] ", ...)
    end
}
