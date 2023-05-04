Config = {
    jobKey = "postman",
    pickUpBoxesTime = 3000,
    Vehicles = {

    },
    Zones = {
        CloakRoom = {
            pos       = vector3(450.1437, -1782.3292, 28.5925),
            Size      = { x = 0.8, y = 0.5, z = 1.0 },
            Color     = { r = 50, g = 200, b = 50 },
            Marker    = {
                type         = 20,
                size         = { x = 1.1, y = 2.7, z = 1.1 },
                color        = { r = 50, g = 200, b = 50, a = 200 },
                drawDistance = 2.5,
                enable       = true
            },
            Blip      = true,
            Name      = "Postman\'s Locker Room",
            Type      = 'cloakroom',
            Hint      = "press [E] to change clothes.",
            BlipInfos = {
                sprite = 389,
                color = 38
            },
        },

        VehiclesSpawner = {
            pos    = vector3(435.8820, -1782.6068, 28.5589),
            Size   = { x = 0.8, y = 0.5, z = 1.0 },
            Color  = { r = 50, g = 200, b = 50 },
            Marker = {
                type         = 36,
                size         = { x = 1.1, y = 0.7, z = 1.1 },
                color        = { r = 20, g = 200, b = 40, a = 200 },
                drawDistance = 2.5,
                enable       = true
            },
            Blip   = false,
            Type   = 'vehiclesSpawner',
            Hint   = "press [E] to spawne vehicle",
        },

        VehicleSpawnPoint = {
            pos = vector3(442.5473, -1781.0958, 28.5609)
        },
        boxes = {
            pos       = vector3(444.9805, -1788.5244, 28.5925),
            Size      = { x = 0.8, y = 0.5, z = 1.0 },
            Color     = { r = 50, g = 200, b = 50 },
            Marker    = {
                type         = 30,
                size         = { x = 1.1, y = 0.7, z = 1.1 },
                color        = { r = 20, g = 200, b = 40, a = 200 },
                drawDistance = 3.5,
                enable       = true
            },
            Blip      = true,
            Name      = "Postman\'s boxes",
            Hint      = "press [E] to pick up boxes",
            Type      = 'boxes',
            BlipInfos = {
                sprite = 478,
                color = 38
            },
        },

    }
}
