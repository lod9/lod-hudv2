local alarmset = false

local function convertToPercentage(value)
    return math.ceil(value * 10000 - 2001) / 80
    --99,9875
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(90) -- düştükçe daha hızlı tepki verir 
        local person = PlayerPedId()
        if IsPauseMenuActive() then
            SendNUIMessage({
                carhud = 'indi';
            })
		elseif IsPedInAnyVehicle(person) then
            local car = GetVehiclePedIsUsing(person)
            local fuel = GetVehicleFuelLevel(car)
            local vites = GetVehicleCurrentGear(car)
            local hiz = (GetEntitySpeed(car)*3.6) 
            local rpm = GetVehicleCurrentRpm(car)
            local rpmmath = convertToPercentage(rpm)
            local hasar = GetVehicleEngineHealth(car)
            local _, kisa, uzun = GetVehicleLightsState(car)
            local farseviye
            if (kisa == 1 and uzun == 0) then
                farseviye = 1;
            elseif (kisa == 1 and uzun == 1) or (kisa == 0 and uzun == 1) then
                farseviye = 2;
            else
                farseviye = 0;
            end
        
            if fuel < 20 then
                TriggerEvent("benzinuyari")
            else
                if fuel < 10 then
                    TriggerEvent("benzinuyari")
                end
            end
            
            SendNUIMessage({
                carhud = 'arabada';
                rpm = rpmmath;
                fuel = fuel;
                motor = hasar;
                far = farseviye;
                gear = vites;
                speed = hiz;

            })
        else
            SendNUIMessage({
                carhud = 'indi';
            })
        end
	end
end)

RegisterNetEvent("benzinuyari")
AddEventHandler("benzinuyari",function()
    if not alarmset then
        alarmset = true
        local i = 5
        TriggerEvent("DoLongHudText", "Low fuel.",1)
        while i > 0 do
            PlaySound(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
            i = i - 1
            Citizen.Wait(300)
        end
        Citizen.Wait(60000)
        alarmset = false
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(10000)
    while true do
        local ped = PlayerPedId()
        local sleepThread = 500

        local radarEnabled = IsRadarEnabled()

        if not IsPedInAnyVehicle(ped) and radarEnabled then
            DisplayRadar(false)
        elseif IsPedInAnyVehicle(ped) and not radarEnabled then
            DisplayRadar(true)
        end

        Citizen.Wait(sleepThread)
    end
end)