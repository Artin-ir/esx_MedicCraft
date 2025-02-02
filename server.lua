ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('MCraft:remove')
AddEventHandler('MCraft:remove', function(itemName,itemCount)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(itemName, itemCount)
end)

RegisterServerEvent('MCraft:additem')
AddEventHandler('MCraft:additem', function(itemName,itemCount)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(itemName) == "string" then
        if itemName == "bandage" then
			xPlayer.addInventoryItem(itemName, itemCount)

        elseif itemName == "medikit" then
			xPlayer.addInventoryItem(itemName, itemCount)
        end

	else

		print(tostring(GetPlayerName(source)) .. ' tried to use lua injector')

	end

end)


