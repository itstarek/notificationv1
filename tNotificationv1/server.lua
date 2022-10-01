function getMaximumGrade(jobname)
    local queryDone, queryResult = false, nil

    MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @jobname ORDER BY `grade` DESC ;', {
        ['@jobname'] = jobname
    }, function(result)
        queryDone, queryResult = true, result
    end)

    while not queryDone do
        Wait(10)
    end

    if queryResult[1] then
        return queryResult[1].grade
    end

    return nil
end

function getAdminCommand(name)
    for i = 1, #Config.Admin, 1 do
        if Config.Admin[i].name == name then
            return i
        end
    end

    return false
end

function isAuthorized(index, group)
    for i = 1, #Config.Admin[index].groups, 1 do
        if Config.Admin[index].groups[i] == group then
            return true
        end
    end

    return false
end

function isEmployed(jobName)
    return (jobName ~= "unemployed" and jobName ~= "unemployed2")
end


ESX.RegisterServerCallback('KorioZ-PersonalMenu:Admin_getUsergroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local plyGroup = xPlayer.getGroup()

    if plyGroup ~= nil then
        cb(plyGroup)
    else
        cb('user')
    end
end)

ESX.RegisterServerCallback('Mowgli:getFactures', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bills = {}

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(bills, {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			})
		end

		cb(bills)
	end)
end)

MowgliNetEvent('KorioZ-PersonalMenu:Boss_promouvoirplayer', function(source, target)
    if target == -1 then return end
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
			
	print("Le Joueur " .. GetPlayerName(source) .. " (" .. source .. ") a TriggerServerEvent Boss_promouvoirplayer sur " .. target)

    if (targetXPlayer.job.grade == tonumber(getMaximumGrade(sourceXPlayer.job.name)) - 1) then
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation du ~r~Gouvernement~w~.')
    else
        if source ~= target and sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
            targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) + 1)

            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~promu ' .. targetXPlayer.name .. '~w~.')
            TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~promu par ' .. sourceXPlayer.name .. '~w~.')
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
        end
    end
end)

MowgliNetEvent('KorioZ-PersonalMenu:Boss_destituerplayer', function(source, target)
    if target == -1 then return end
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
			
	print("Le Joueur " .. GetPlayerName(source) .. " (" .. source .. ") a TriggerServerEvent Boss_destituerplayer sur " .. target)

    if (targetXPlayer.job.grade == 0) then
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas ~r~rétrograder~w~ davantage.')
    else
        if source ~= target and sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
            targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) - 1)

            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~r~rétrogradé ' .. targetXPlayer.name .. '~w~.')
            TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~r~rétrogradé par ' .. sourceXPlayer.name .. '~w~.')
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
        end
    end
end)

MowgliNetEvent('KorioZ-PersonalMenu:Boss_recruterplayer', function(source, target, job)
    if target == -1 then return end
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
			
	print("Le Joueur " .. GetPlayerName(source) .. " (" .. source .. ") a TriggerServerEvent Boss_recruterplayer sur " .. target)

    if source ~= target and sourceXPlayer.job.grade_name == 'boss' then
        if not isEmployed(targetXPlayer.job.name) then
            targetXPlayer.setJob(job, 0)
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~recruté ' .. targetXPlayer.name .. '~w~.')
            TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~embauché par ' .. sourceXPlayer.name .. '~w~.')
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas recruter quelqu\'un déjà embauché.')
        end
    end
end)

MowgliNetEvent('KorioZ-PersonalMenu:Boss_virerplayer', function(source, target)
    if target == -1 then return end
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
			
	print("Le Joueur " .. GetPlayerName(source) .. " (" .. source .. ") a TriggerServerEvent Boss_virerplayer sur " .. target)

    if source ~= target and sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
        targetXPlayer.setJob('unemployed', 0)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~r~viré ' .. targetXPlayer.name .. '~w~.')
        TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~viré par ' .. sourceXPlayer.name .. '~w~.')
    else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
    end
end)

MowgliNetEvent('KorioZ-PersonalMenu:Boss_promouvoirplayer2', function(source, target)
    if target == -1 then return end
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
			
	print("Le Joueur " .. GetPlayerName(source) .. " (" .. source .. ") a TriggerServerEvent Boss_promouvoirplayer2 sur " .. target)

    if (targetXPlayer.job2.grade == tonumber(getMaximumGrade(sourceXPlayer.job2.name)) - 1) then
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation du ~r~Gouvernement~w~.')
    else
        if source ~= target and sourceXPlayer.job2.grade_name == 'boss' and sourceXPlayer.job2.name == targetXPlayer.job2.name then
            targetXPlayer.setJob2(targetXPlayer.job2.name, tonumber(targetXPlayer.job2.grade) + 1)

            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~promu ' .. targetXPlayer.name .. '~w~.')
            TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~promu par ' .. sourceXPlayer.name .. '~w~.')
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
        end
    end
end)

MowgliNetEvent('KorioZ-PersonalMenu:Boss_destituerplayer2', function(source, target)
    if target == -1 then return end
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
			
	print("Le Joueur " .. GetPlayerName(source) .. " (" .. source .. ") a TriggerServerEvent Boss_destituerplayer2 sur " .. target)

    if (targetXPlayer.job2.grade == 0) then
        TriggerClientEvent('esx:showNotification', _source, 'Vous ne pouvez pas ~r~rétrograder~w~ davantage.')
    else
        if ssource ~= target and sourceXPlayer.job2.grade_name == 'boss' and sourceXPlayer.job2.name == targetXPlayer.job2.name then
            targetXPlayer.setJob2(targetXPlayer.job2.name, tonumber(targetXPlayer.job2.grade) - 1)

            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~r~rétrogradé ' .. targetXPlayer.name .. '~w~.')
            TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~r~rétrogradé par ' .. sourceXPlayer.name .. '~w~.')
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
        end
    end
end)

MowgliNetEvent('KorioZ-PersonalMenu:Boss_recruterplayer2', function(source, target, job2)
    if target == -1 then return end
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
			
	print("Le Joueur " .. GetPlayerName(source) .. " (" .. source .. ") a TriggerServerEvent Boss_recruterplayer2 sur " .. target)

    if source ~= target and sourceXPlayer.job2.grade_name == 'boss' then
        if not isEmployed(targetXPlayer.job2.name) then
            targetXPlayer.setJob2(job2, 0)
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~g~recruté ' .. targetXPlayer.name .. '~w~.')
            TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~embauché par ' .. sourceXPlayer.name .. '~w~.')
        else
            TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas recruter quelqu\'un déjà embauché.')
        end
    end
end)

MowgliNetEvent('KorioZ-PersonalMenu:Boss_virerplayer2', function(source, target)
    if target == -1 then return end
    local sourceXPlayer = ESX.GetPlayerFromId(source)
    local targetXPlayer = ESX.GetPlayerFromId(target)
			
	print("Le Joueur " .. GetPlayerName(source) .. " (" .. source .. ") a TriggerServerEvent Boss_virerplayer2 sur " .. target)

    if source ~= target and sourceXPlayer.job2.grade_name == 'boss' and sourceXPlayer.job2.name == targetXPlayer.job2.name then
        targetXPlayer.setJob2('unemployed2', 0)
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous avez ~r~viré ' .. targetXPlayer.name .. '~w~.')
        TriggerClientEvent('esx:showNotification', target, 'Vous avez été ~g~viré par ' .. sourceXPlayer.name .. '~w~.')
    else
        TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
    end
end)




RegisterCommand('goto', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()
  
    if playerGroup ~= 'user' then
        if args[1] == nil then 
            TriggerClientEvent('esx:showNotification', source, 'Vous devez spécifier un joueur')
            return
        end
        local ped = GetPlayerPed(args[1])
        local playerCoords = GetEntityCoords(ped)
        TriggerClientEvent('framework:tp', source, playerCoords)
    end
end)
  
RegisterCommand('bring', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerGroup = xPlayer.getGroup()

    if playerGroup ~= 'user' then
        if args[1] == nil then 
            TriggerClientEvent('esx:showNotification', source, 'Vous devez spécifier un joueur')
            return
        end
        local ped = GetPlayerPed(source)
        local playerCoords = GetEntityCoords(ped)
        TriggerClientEvent('framework:tp', args[1], playerCoords)
    end
end)

RegisterNetEvent('Admin:ActionTeleport', function(action, id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getGroup() ~= "user" then 
        if action == "teleportto" then 
            local ped = GetPlayerPed(id)
            local coord = GetEntityCoords(ped)
            TriggerClientEvent("Admin:ActionTeleport", _source, "teleportto", coord)
        elseif action == "teleportme" then 
            local ped = GetPlayerPed(_source)
            local coord = GetEntityCoords(ped)
            TriggerClientEvent("Admin:ActionTeleport", id, "teleportme", coord)
        elseif action == "teleportpc" then
            local coord = vector3(215.76, -810.12, 30.73)
            TriggerClientEvent("Admin:ActionTeleport", id, "teleportpc", coord)
        end
    else
        TriggerEvent("BanSql:ICheatServer", source, "Le Cheat n'est pas autorisé sur notre serveur [téléportation]")
    end
end)

ESX.RegisterServerCallback("ronflex:getradio", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getInventoryItem("radio").count >= 1 then 
        cb(true)
    else
        cb(false)
    end
end)

local isHandsup = {}
RegisterNetEvent('Mowgli:handsup', function(value)
    if not isHandsup[source] then 
        isHandsup[source] = value
    else 
        isHandsup[source] = value
    end
end)

ESX.RegisterServerCallback('KorioZ-PersonalMenu:getHandsUp', function(source, cb, target)
    if isHandsup[target] then 
        cb(isHandsup[target])
    else
        isHandsup[target] = false
        cb(isHandsup[target])
    end
    print(isHandsup[target])
end)

RegisterServerEvent('Twt')
AddEventHandler('Twt', function(message)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local name = xPlayer.getName(_source)
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION', ''..name..': \n'..message..'', 'TAREK_ATLANTIS')
	end
end)


RegisterServerEvent('Entreprise')
AddEventHandler('Entreprise', function(message)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == "ambulance" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - AMBULANCE', ''..message..'', 'TAREK_EMS')

        elseif xPlayer.job.name == "bahamas" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - BAHAMAS', ''..message..'', 'TAREK_BAHAMAS')

        elseif xPlayer.job.name == "carshop" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - CONCESSIONNAIRE', ''..message..'', 'TAREK_CARSHOP')

        elseif xPlayer.job.name == "gouvernement" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - GOUVERNEMENT', ''..message..'', 'TAREK_GOV')

        elseif xPlayer.job.name == "lscustom" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - LS CUSTOMS', ''..message..'', 'TAREK_LSCUSTOMS')

        elseif xPlayer.job.name == "mecano" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - MÉCANO', ''..message..'', 'TAREK_MECANO')

        elseif xPlayer.job.name == "police" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - L.S.P.D.', ''..message..'', 'TAREK_LSPD')

        elseif xPlayer.job.name == "realestateagent" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - AGENCE-IMMO.', ''..message..'', 'TAREK_IMMO')

        elseif xPlayer.job.name == "sheriff" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - L.S.S.D.', ''..message..'', 'TAREK_LSSD')

        elseif xPlayer.job.name == "tabac" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - TABAC', ''..message..'', 'TAREK_TABAC')

        elseif xPlayer.job.name == "taxi" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - TAXI', ''..message..'', 'TAREK_TAXI')

        elseif xPlayer.job.name == "unicorn" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - UNICORN', ''..message..'', 'TAREK_UNICORN')

        elseif xPlayer.job.name == "vigne" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - VIGNERON', ''..message..'', 'TAREK_VIGNERON')

        elseif xPlayer.job.name == "galaxy" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - GALAXY-CLUB', ''..message..'', 'TAREK_GALAXY')

        elseif xPlayer.job.name == "fbi" then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION - FBI', ''..message..'', 'TAREK_FBI')
        end
	end
end)

RegisterServerEvent('Ano')
AddEventHandler('Ano', function(message)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
    if xPlayer.job.name == "police" or xPlayer.job.name == "sheriff" or xPlayer.job.name == "fbi" then
        
    else
        for i = 1, #xPlayers, 1 do
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], '', 'NOTIFICATION', 'MESSAGE CRYPTÉ \n'..message..'', 'TAREK_ANO')
            MowgliServerUtils.webhook(("%s: /Ano %s"):format(GetPlayerName(_source), message), "blue", "https://discord.com/api/webhooks/1014644221476622467/g6wmNdn93G384FgnMWaDYjfLu8lTH_4YcY5_sRAhxpWFbsbKNofF0jpiwoButnVjwK2J")
        end
    end
end)