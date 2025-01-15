# **Blutspende-Skript für QBCore**

Ein umfassendes Skript für **FiveM** auf Basis von **QBCore**, das die Simulation von Blutspenden und die Verabreichung von Blutkonserven sowie NaCl-Beuteln ermöglicht.

---

## **Funktionen**
- **Blutspende:**
  - Mediziner kann einen **leeren Blutbeutel** verwenden, um eine Blutspende zu starten.
  - Der leere Blutbeutel wird dem **Blutspender** übergeben.
  - Der **Blutspender** erhält eine Progressbar, die den Vorgang der Blutspende anzeigt.
  - Nach Abschluss der Spende erhält der Blutspender einen **vollen Blutbeutel**.
  
- **Verabreichung von Blutkonserve/NaCl:**
  - Der Mediziner kann eine **Blutkonserve** oder einen **NaCl-Beutel** verwenden, um sie einem Patienten zu verabreichen.
  - Der Patient sieht eine Progressbar während der Behandlung.
  - Nach Abschluss erhält der Patient eine Bestätigung.

- **Benachrichtigungen:**
  - Vollständig konfigurierbare **Notifications** für jeden Schritt des Prozesses.

---

## **Installation**

### **1. Dateien kopieren**
Kopiere die folgenden Dateien in dein Ressourcenverzeichnis:
- `fxmanifest.lua`
- `config.lua`
- `server/main.lua`
- `client/main.lua`

### **2. Abhängigkeiten**
Stelle sicher, dass folgende Ressourcen installiert sind:
- [QBCore Framework](https://github.com/qbcore-framework)
- `qb-inventory`
- `qb-core`

### **3. Items hinzufügen**
Ergänze die folgenden Items in `qb-core/shared/items.lua`:

```lua
['empty_blood_bag'] = {
    ['name'] = 'empty_blood_bag',
    ['label'] = 'Leerer Blutbeutel',
    ['weight'] = 100,
    ['type'] = 'item',
    ['image'] = 'empty_blood_bag.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'Ein leerer Beutel, bereit für eine Blutspende.',
},
['full_blood_bag'] = {
    ['name'] = 'full_blood_bag',
    ['label'] = 'Voller Blutbeutel',
    ['weight'] = 150,
    ['type'] = 'item',
    ['image'] = 'full_blood_bag.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'Ein voller Blutbeutel nach einer Spende.',
},
['nacl_bag'] = {
    ['name'] = 'nacl_bag',
    ['label'] = 'NaCl-Beutel',
    ['weight'] = 100,
    ['type'] = 'item',
    ['image'] = 'nacl_bag.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'Ein Beutel mit NaCl-Lösung zur Behandlung.',
},
```
Kopiere die zugehörigen Bilder (empty_blood_bag.png, full_blood_bag.png, nacl_bag.png) in den Ordner qb-inventory/html/images.

### **Konfiguration**
Alle Einstellungen befinden sich in der Datei config.lua. Hier kannst du:

Die Dauer der Vorgänge (Config.DonationDuration) anpassen.
Die Items definieren (Config.Items).
Die Benachrichtigungen anpassen (Config.Notifications).

### **Verwendung**

1. Blutspende starten
Mediziner verwendet den leeren Blutbeutel in der Nähe eines Spielers.
Der Blutspender sieht eine Progressbar.
Nach Abschluss erhält der Blutspender einen vollen Blutbeutel.

2. Blutkonserve/NaCl verabreichen
Mediziner verwendet einen vollen Blutbeutel oder einen NaCl-Beutel in der Nähe eines Patienten.
Der Patient sieht eine Progressbar während der Behandlung.
Nach Abschluss wird die Behandlung erfolgreich abgeschlossen.
Zukünftige Erweiterungen
Möglichkeit, den Prozess mit zusätzlichen Animationen zu versehen.
Konfigurierbare Cooldowns oder Einschränkungen pro Spieler.

### **Support**
Für Fragen oder Unterstützung, erstelle ein Issue.
