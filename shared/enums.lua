JobKey               = Config.jobKey

ServerCallBackEvents = {
    SpawnVehicle = "esx_" .. JobKey .. ":SpawnVehicle",
    FetchDutyJob = "esx_" .. JobKey .. ":FetchDutyJob",
    SetCustomers = "esx_" .. JobKey .. ":SetCustomers",
    GetCustomers = "esx_" .. JobKey .. ":GetCustomers",
    UpadateCustomers = "esx_" .. JobKey .. ":UpadateCustomers",
}
ServerEvents         = {
    ToggleDutyJob = "esx_" .. JobKey .. ":ToggleDutyJob",
}
