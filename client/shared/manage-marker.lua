MarkerManager = {
    Draw = function(type, zonePos, size, color)
        DrawMarker(type, zonePos.x, zonePos.y,
            zonePos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
            size.x, size.y,
            size.z, color.r, color.g,
            color.b, 100, false, false, 2,
            0, nil, nil, false)
    end
}
