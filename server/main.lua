local QBCore = exports['qb-core']:GetCoreObject()

-- Server-Event: Spendenprozess starten
RegisterNetEvent('blooddonation:startDonationProcess', function(targetPlayerId)
    local src = source -- Der Mediziner
    local medicPlayer = QBCore.Functions.GetPlayer(src) -- Der Mediziner
    local donorPlayer = QBCore.Functions.GetPlayer(targetPlayerId) -- Der Blutspender

    if not medicPlayer or not donorPlayer then
        TriggerClientEvent('QBCore:Notify', src, Config.Notifications.NoPlayerNearby.text, Config.Notifications.NoPlayerNearby.type)
        return
    end

    -- Prüfe, ob der Mediziner den leeren Blutbeutel hat
    if medicPlayer.Functions.GetItemByName(Config.Items.EmptyBloodBag) then
        -- Entferne den leeren Blutbeutel vom Mediziner
        if medicPlayer.Functions.RemoveItem(Config.Items.EmptyBloodBag, 1) then
            -- Übergabe des leeren Blutbeutels an den Spender
            donorPlayer.Functions.AddItem(Config.Items.EmptyBloodBag, 1)

            -- Visuelles Feedback
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.EmptyBloodBag], 'remove')
            TriggerClientEvent('inventory:client:ItemBox', targetPlayerId, QBCore.Shared.Items[Config.Items.EmptyBloodBag], 'add')

            -- Trigger für den Blutspender: Starte den Timer
            TriggerClientEvent('blooddonation:startTimerForDonor', targetPlayerId)
            
            -- Benachrichtigung für beide Spieler
            TriggerClientEvent('QBCore:Notify', src, Config.Notifications.DonationStarted.text, Config.Notifications.DonationStarted.type)
            TriggerClientEvent('QBCore:Notify', targetPlayerId, Config.Notifications.DonationStarted.text, Config.Notifications.DonationStarted.type)
        else
            -- Fehler beim Entfernen des leeren Blutbeutels
            TriggerClientEvent('QBCore:Notify', src, Config.Notifications.NoEmptyBag.text, Config.Notifications.NoEmptyBag.type)
        end
    else
        -- Kein leerer Blutbeutel im Inventar des Mediziners
        TriggerClientEvent('QBCore:Notify', src, Config.Notifications.NoEmptyBag.text, Config.Notifications.NoEmptyBag.type)
    end
end)

-- Server-Event: Spendenprozess abschließen
RegisterNetEvent('blooddonation:finishDonation', function()
    local src = source -- Der Blutspender
    local donorPlayer = QBCore.Functions.GetPlayer(src) -- Der Blutspender

    if donorPlayer then
        -- Entferne den leeren Blutbeutel vom Spender
        if donorPlayer.Functions.RemoveItem(Config.Items.EmptyBloodBag, 1) then
            -- Füge dem Spender die volle Blutkonserve hinzu
            donorPlayer.Functions.AddItem(Config.Items.FullBloodBag, 1)

            -- Visuelles Feedback
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.EmptyBloodBag], 'remove')
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Items.FullBloodBag], 'add')

            -- Benachrichtigung
            TriggerClientEvent('QBCore:Notify', src, Config.Notifications.DonationSuccess.text, Config.Notifications.DonationSuccess.type)
        else
            -- Fehler beim Entfernen des leeren Blutbeutels
            TriggerClientEvent('QBCore:Notify', src, 'Es gab ein Problem bei der Verarbeitung der Blutspende.', 'error')
        end
    end
end)

-- Server-Event: Blutkonserve verabreichen
RegisterNetEvent('blooddonation:useBloodBag', function(targetPlayerId)
    local src = source -- Der Mediziner
    local Player = QBCore.Functions.GetPlayer(src) -- Der Mediziner

    if Player.Functions.RemoveItem(Config.Items.FullBloodBag, 1) then
        -- Trigger für den Empfänger, um Progressbar zu zeigen
        TriggerClientEvent('blooddonation:showReceiverProgress', targetPlayerId, Config.Items.FullBloodBag)

        -- Benachrichtigungen
        TriggerClientEvent('QBCore:Notify', src, Config.Notifications.BloodApplied.text, Config.Notifications.BloodApplied.type)
        TriggerClientEvent('QBCore:Notify', targetPlayerId, Config.Notifications.BloodApplied.text, Config.Notifications.BloodApplied.type)
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Notifications.NoBloodBag.text, Config.Notifications.NoBloodBag.type)
    end
end)

-- Server-Event: NaCl verabreichen
RegisterNetEvent('blooddonation:useNaCl', function(targetPlayerId)
    local src = source -- Der Mediziner
    local Player = QBCore.Functions.GetPlayer(src) -- Der Mediziner

    if Player.Functions.RemoveItem(Config.Items.NaClBag, 1) then
        -- Trigger für den Empfänger, um Progressbar zu zeigen
        TriggerClientEvent('blooddonation:showReceiverProgress', targetPlayerId, Config.Items.NaClBag)

        -- Benachrichtigungen
        TriggerClientEvent('QBCore:Notify', src, Config.Notifications.NaClApplied.text, Config.Notifications.NaClApplied.type)
        TriggerClientEvent('QBCore:Notify', targetPlayerId, Config.Notifications.NaClApplied.text, Config.Notifications.NaClApplied.type)
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Notifications.NoNaClBag.text, Config.Notifications.NoNaClBag.type)
    end
end)

-- Leeren Blutbeutel nutzbar machen
QBCore.Functions.CreateUseableItem('empty_blood_bag', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        TriggerClientEvent('blooddonation:useEmptyBloodBag', source)
    end
end)

-- Volle Blutkonserve nutzbar machen
QBCore.Functions.CreateUseableItem('full_blood_bag', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        TriggerClientEvent('blooddonation:useFullBloodBag', source)
    end
end)

-- NaCl-Beutel nutzbar machen
QBCore.Functions.CreateUseableItem('nacl_bag', function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        TriggerClientEvent('blooddonation:useNaClBag', source)
    end
end)
