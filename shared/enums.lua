JobKey               = Config.jobKey

ServerCallBackEvents = {
    SpawnVehicle = "esx_" .. JobKey .. ":SpawnVehicle",
    FetchDutyJob = "esx_" .. JobKey .. ":FetchDutyJob",
    SetCustomers = "esx_" .. JobKey .. ":SetCustomers"
}
ServerEvents         = {
    ToggleDutyJob = "esx_" .. JobKey .. ":ToggleDutyJob",
}
