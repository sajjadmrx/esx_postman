Config = {
    jobKey = "postman",
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
            pos    = vector3(448.7865, -1785.8784, 28.5924),
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
            Hint   = "press [E] to spawne vehicle",
        },
        boxes = {
            pos       = vector3(444.9805, -1788.5244, 28.5925),
            Size      = { x = 0.8, y = 0.5, z = 1.0 },
            Color     = { r = 50, g = 200, b = 50 },
            Marker    = {
                type         = 30,
                size         = { x = 1.1, y = 0.7, z = 1.1 },
                color        = { r = 20, g = 200, b = 40, a = 200 },
                drawDistance = 2.5,
                enable       = true
            },
            Blip      = true,
            Name      = "Postman\'s boxes",
            Type      = 'boxes',
            BlipInfos = {
                sprite = 478,
                color = 38
            },
        }
    }
}
