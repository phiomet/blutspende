local QBCore = exports['qb-core']:GetCoreObject()

-- Funktion: Spieler in der Nähe finden
function GetClosestPlayer()
    local players = GetActivePlayers()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local closestDistance = -1
    local closestPlayer = -1

    for _, playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= ped then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(coords - targetCoords)
            if closestDistance == -1 or distance < closestDistance then
                closestDistance = distance
                closestPlayer = playerId
            end
        end
    end

    return closestPlayer, closestDistance
end

-- Funktion: Prüfen, ob Spieler berechtigt ist
function IsAllowed()
    local PlayerData = QBCore.Functions.GetPlayerData()
    return PlayerData.job.name == Config.AllowedJob and PlayerData.job.onduty
end

-- Event: Benutzen des leeren Blutbeutels
RegisterNetEvent('blooddonation:useEmptyBloodBag', function()
    if not IsAllowed() then
        TriggerEvent('QBCore:Notify', Config.Notifications.NotAllowed.text, Config.Notifications.NotAllowed.type)
        return
    end

    local closestPlayer, distance = GetClosestPlayer()
    if closestPlayer ~= -1 and distance <= Config.NearbyDistance then
        local targetServerId = GetPlayerServerId(closestPlayer)
        -- Trigger an den Server senden, um die Spende zu starten
        TriggerServerEvent('blooddonation:startDonationProcess', targetServerId)
    else
        TriggerEvent('QBCore:Notify', Config.Notifications.NoPlayerNearby.text, Config.Notifications.NoPlayerNearby.type)
    end
end)

-- Event: Timer für den Blutspender starten
RegisterNetEvent('blooddonation:startTimerForDonor', function()
    QBCore.Functions.Progressbar("blood_donation", Config.Notifications.DonationStarted.text, Config.DonationDuration, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        -- Nach Abschluss den Server benachrichtigen
        TriggerServerEvent('blooddonation:finishDonation')
    end, function()
        -- Bei Abbruch
        TriggerEvent('QBCore:Notify', Config.Notifications.DonationCancelled.text, Config.Notifications.DonationCancelled.type)
    end)
end)

-- Event: Zeige Progressbar beim Empfänger
RegisterNetEvent('blooddonation:showReceiverProgress', function(item)
    local label = item == Config.Items.FullBloodBag and Config.Notifications.TreatmentInProgress.text or Config.Notifications.TreatmentInProgress.text

    QBCore.Functions.Progressbar("receiver_progress", label, Config.DonationDuration, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = false,
    }, {}, {}, {}, function()
        -- Erfolgreicher Abschluss
        TriggerEvent('QBCore:Notify', Config.Notifications.TreatmentCompleted.text, Config.Notifications.TreatmentCompleted.type)
    end, function()
        -- Abbruch
        TriggerEvent('QBCore:Notify', Config.Notifications.TreatmentCancelled.text, Config.Notifications.TreatmentCancelled.type)
    end)
end)

-- Event: Benutzen der vollen Blutkonserve
RegisterNetEvent('blooddonation:useFullBloodBag', function()
    if not IsAllowed() then
        TriggerEvent('QBCore:Notify', Config.Notifications.NotAllowed.text, Config.Notifications.NotAllowed.type)
        return
    end

    local closestPlayer, distance = GetClosestPlayer()
    if closestPlayer ~= -1 and distance <= Config.NearbyDistance then
        local targetServerId = GetPlayerServerId(closestPlayer)
        TriggerServerEvent('blooddonation:useBloodBag', targetServerId)
    else
        TriggerEvent('QBCore:Notify', Config.Notifications.NoPlayerNearby.text, Config.Notifications.NoPlayerNearby.type)
    end
end)

-- Event: Benutzen des NaCl-Beutels
RegisterNetEvent('blooddonation:useNaClBag', function()
    if not IsAllowed() then
        TriggerEvent('QBCore:Notify', Config.Notifications.NotAllowed.text, Config.Notifications.NotAllowed.type)
        return
    end

    local closestPlayer, distance = GetClosestPlayer()
    if closestPlayer ~= -1 and distance <= Config.NearbyDistance then
        local targetServerId = GetPlayerServerId(closestPlayer)
        TriggerServerEvent('blooddonation:useNaCl', targetServerId)
    else
        TriggerEvent('QBCore:Notify', Config.Notifications.NoPlayerNearby.text, Config.Notifications.NoPlayerNearby.type)
    end
end)
