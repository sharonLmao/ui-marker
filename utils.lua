function PrintDistanceToTarget(distance)
    if ShouldUseMetricMeasurements() then
        if distance >= 1000 then
            local distanceInKm = distance / 1000
            return string.format("%.2f km", distanceInKm)
        else
            return string.format("%d m", math.floor(distance))
        end
    else
        if distance >= 1609.34 then
            local distanceInMiles = distance / 1609.34
            return string.format("%.2f mi", distanceInMiles)
        else
            local distanceInFeet = distance * 3.28084
            return string.format("%d ft", math.floor(distanceInFeet))
        end
    end
end

function DrawText3D(coords, text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end