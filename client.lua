

local function convertToPercentage(value)
    return math.ceil(value * 10000 - 2001) / 80
    --99,9875
end

-- CreateThread(function()
--   while true do
--     if nuiReady and ESX.PlayerLoaded then
--       local ped = PlayerPedId()

--       local curHealth = GetEntityHealth(ped)
--       if curHealth ~= lastHealth then
--         SendMessage('setHealth', { current = curHealth, max = GetEntityMaxHealth(ped) })
--         lastHealth = curHealth
--       end

--       local curArmour = GetPedArmour(ped)
--       if curArmour ~= lastArmour then
--         SendMessage('setArmour', curArmour)
--         lastArmour = curArmour
--       end

--       if cfg.stamina then
--         local curStamina = GetPlayerStamina(playerId)
--         local maxStamina = GetPlayerMaxStamina(playerId)
--         if curStamina < maxStamina then
--           SendMessage('setStamina', {
--             current = curStamina,
--             max = maxStamina
--           })
--           isResting = false
--         elseif not isResting then
--           SendMessage('setStamina', false)
--           isResting = true
--         end
--       end

--       while not maxUnderwaterTime and IsPedSwimmingUnderWater(ped) do
--         ESX.ShowHelpNotification('Initializating HUD... please stay on surface at least 5 seconds!', true)
--         Citizen.Wait(0)
--       end

--       if maxUnderwaterTime then
--         local curUnderwaterTime = GetPlayerUnderwaterTimeRemaining(playerId)
--         if curUnderwaterTime < maxUnderwaterTime then
--           SendMessage('setOxygen', {
--             current = curUnderwaterTime,
--             max = maxUnderwaterTime
--           })
--           onSurface = false
--         elseif not onSurface then
--           SendMessage('setOxygen', false)
--           onSurface = true
--         end
--       end

--       local inVehicle = IsPedInAnyVehicle(ped, false)
--       if inVehicle then
--         local curVehicle = GetVehiclePedIsUsing(ped, false)
--         SendMessage('setVehicle', {
--           speed = {
--             current = GetEntitySpeed(curVehicle),
--             max = GetVehicleModelMaxSpeed(GetEntityModel(curVehicle))
--           },
--           unitsMultiplier = cfg.metricSystem and 3.6 or 2.236936,
--           fuel = cfg.fuel and GetVehicleFuelLevel(curVehicle),
--         })
--         offVehicle = false
--       elseif not offVehicle then
--         SendMessage('setVehicle', false)
--         offVehicle = true
--       end
--     end
--     Citizen.Wait(cfg.refreshRates.base)
--   end
-- end)



local alarmset = false


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
