JobKey = Config.jobKey

EventsEnum = {
    EnteredMarker = "esx_" .. JobKey .. ":hasEnteredMarker",
    ExitedMarker = "esx_" .. JobKey .. ":hasExitedMarker",
    VehicleSpawner = "esx_" .. JobKey .. ":vehicleSpawner",
}

Actions = {
    VehicleSpawner = "vehicle_spawner",
    VehicleDeleter = "vehicle_deleter",
    ChangeClothes = "ChangeClothes",
    PickUpBoxes = "PickUpBoxes"
}
