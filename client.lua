local lockCam = false
local cameraHeightOffset = 5.0 -- Adjust this value to set the camera higher

Citizen.CreateThread(function()
    while true do
        if lockCam then
            local playerHeading = GetEntityHeading(PlayerId())
            local pitch = GetGameplayCamRelativePitch()
            SetGameplayCamRelativeHeading(playerHeading)
            SetGameplayCamRelativePitch(pitch + cameraHeightOffset, 0.0)
        end
        
        Citizen.Wait(1)
    end
end)

RegisterCommand("lockcam", function(source, args, rawCommand)
    if args[1] then
        local newHeight = tonumber(args[1])
        if newHeight then
            print("Setting new camera height offset:".. newHeight .. " !") -- You can remove this
            cameraHeightOffset = newHeight
        else
            print("Invalid height. Please provide a numeric value!") -- And you can remove this
        end
    end

    if not lockCam then
        lockCam = true
    else
        lockCam = false
    end
end, false)


RegisterKeyMapping('lockcam', 'Lock the Camera', 'keyboard', '+')