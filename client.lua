ESX = nil
local MarkerPos = {301.05,-596.98,43.28}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function checkplayerinventory ()
    local inventory = ESX.GetPlayerData().inventory
     meth = 0
     marijuana = 0
     coca = 0
     medikit = 0
     bandage = 0
    for i=1, #inventory, 1 do
    
        if inventory[i].name == "meth" then
            meth = inventory[i].count
        end
    
        if inventory[i].name == "marijuana" then
            marijuana = inventory[i].count
        end
    
        if inventory[i].name == "coca" then
            coca= inventory[i].count
        end
    
        if inventory[i].name == "medikit" then
            medikit= inventory[i].count
        end

        if inventory[i].name == "bandage" then
            bandage= inventory[i].count
        end
    end

end

CreateThread(function(src)
    
	while true do
        local playerCoords = GetEntityCoords(PlayerPedId(),false)
        local distance = GetDistanceBetweenCoords(MarkerPos[1],MarkerPos[2],MarkerPos[3],playerCoords.x,playerCoords.y,playerCoords.z)
		-- draw every frame 
		Wait(0)

        if distance <= 5.8 then
            checkplayerinventory(src)

            local PlayerData = ESX.GetPlayerData(src)
            local PJob = PlayerData.job.name 
            if PJob == 'ambulance' then
            local pedCoords = GetEntityCoords(PlayerPedId())
            DrawMarker(42, MarkerPos[1],MarkerPos[2],MarkerPos[3], 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 0, 210,255, 50, false, true, 2, nil, nil, false)
            end
            local MarkerVector = vector3(MarkerPos[1],MarkerPos[2],MarkerPos[3])
            if Vdist2(playerCoords,MarkerVector) < 2 * 1.12 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 and PJob =='ambulance'  then
                if IsControlJustReleased(0, 51) then
                    CurrentAction='craft_Medkit'
                        if medikit == 0 and bandage == 0 then
                            if meth >= 25 and marijuana >= 250 and coca >= 150  then
                                TriggerEvent("mythic_progbar:client:progress", {
                                    name = "craft_Medkit",
                                    duration = 10000,
                                    label = "Crafting Medkit",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@idle_a",
                                           anim = "idle_a",
                                        }
                                }, function(status)
                                    if not status then
                        
                                     
                                        TriggerServerEvent('MCraft:remove', "meth",25)
                                        TriggerServerEvent('MCraft:remove', "marijuana",250)
                                        TriggerServerEvent('MCraft:remove', "coca",150)
                                        TriggerServerEvent('MCraft:additem', 'bandage',40)
                                        TriggerServerEvent('MCraft:additem', 'medikit',20)
                                        ClearPedTasksImmediately(GetPlayerPed(-1))
                            
                                    elseif status then
                        
                                        ClearPedTasksImmediately(GetPlayerPed(-1))
                        
                                    end
                                end)
                            else
                                ESX.ShowNotification("You don't have enough items to craft Medikit and Bandage")
                
                            end
    
                            
    
                     
                        
                        else
                    
                            ESX.ShowNotification("You don't have ~r~enough space ~w~to craft Medikit")
                        
                        end
                end
                    ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to craft Medikit')
            end
        end

      
	end
end)


