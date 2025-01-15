Config = {}

-- Dauer der Blutspende in Millisekunden
Config.DonationDuration = 300000

-- Items, die benötigt und ausgegeben werden
Config.Items = {
    EmptyBloodBag = 'empty_blood_bag', -- Leerer Blutbeutel
    FullBloodBag = 'full_blood_bag',   -- Voller Blutbeutel
    NaClBag = 'nacl_bag'               -- Beutel NaCl
}

-- Distanz in Metern, in der ein Spieler als "nah" gilt
Config.NearbyDistance = 2.0

-- Zulässiger Job
Config.AllowedJob = "ambulance" -- Nur Spieler mit diesem Job können die Funktion nutzen

-- Notifications
Config.Notifications = {
    NoPlayerNearby = {text = 'Kein Spieler in der Nähe!', type = 'error'},
    NoEmptyBag = {text = 'Du hast keinen leeren Blutbeutel!', type = 'error'},
    DonationStarted = {text = 'Blutspende wird gestartet...', type = 'info'},
    DonationSuccess = {text = 'Blutspende abgeschlossen!', type = 'success'},
    DonationReceived = {text = 'Du hast einen vollen Blutbeutel erhalten!', type = 'success'},
    DonationCancelled = {text = 'Blutspende abgebrochen.', type = 'error'},
    BloodApplied = {text = 'Blutkonserve wird erfolgreich verabreicht!', type = 'success'},
    NaClApplied = {text = 'NaCl wird erfolgreich verabreicht!', type = 'success'},
    NoBloodBag = {text = 'Du hast keine Blutkonserve!', type = 'error'},
    NoNaClBag = {text = 'Du hast keinen NaCl-Beutel!', type = 'error'},
    TreatmentInProgress = {text = 'Behandlung läuft...', type = 'info'},
    TreatmentCancelled = {text = 'Behandlung wurde abgebrochen!', type = 'error'},
    TreatmentCompleted = {text = 'Behandlung erfolgreich abgeschlossen!', type = 'success'}
}
