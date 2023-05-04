JobKey               = Config.jobKey

ServerCallBackEvents = {
    SpawnVehicle = "esx_" .. JobKey .. ":SpawnVehicle",
    FetchDutyJob = "esx_" .. JobKey .. ":FetchDutyJob",
}
ServerEvents         = {
    ToggleDutyJob = "esx_" .. JobKey .. ":ToggleDutyJob",
}
