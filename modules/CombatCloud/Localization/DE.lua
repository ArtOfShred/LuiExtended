CombatCloudLocalization = {
---------------------------------------------------------------------------------------------------------------------------------------
    --//PANEL TITLES//--
---------------------------------------------------------------------------------------------------------------------------------------
    panelTitles = {
        CombatCloud_Outgoing                = "Ausgehend",
        CombatCloud_Incoming                = "Eingehend",
        CombatCloud_Point                   = "Punkte",
        CombatCloud_Alert                   = "Warnungen",
        CombatCloud_Resource                = "Ressourcen"
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//MAIN//--
---------------------------------------------------------------------------------------------------------------------------------------
        combatCloudOptions                  = "Combat Cloud Optionen",
        unlock                              = "Entsperren",
        unlockTooltip                       = "Die Anzeigeelmente entsperren um sie zu bewegen.",
---------------------------------------------------------------------------------------------------------------------------------------
    --//TOGGLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonToggleIncoming                = "Ereignisse eingehend",
        buttonToggleOutgoing                = "Ereignisse ausgehend",
        buttonToggleNotification            = "Ereignis Hinweise",
        headerToggleIncomingDamageHealing   = "Schaden & Heilung (eingehend)",
        headerToggleIncomingMitigation      = "Schadensminderung (eingehend)",
        headerToggleIncomingCrowdControl    = "Kontrolleffekte (eingehend)",
        headerToggleOutgoingDamageHealing   = "Schaden & Heilung (ausgehend)",
        headerToggleOutgoingMitigation      = "Schadensminderung (ausgehend)",
        headerToggleOutgoingCrowdControl    = "Kontrolleffekte (ausgehend)",
        headerToggleCombatState             = "Kampfstatus",
        headerToggleAlert                   = "Tipps im Kampf",
        headerTogglePoint                   = "Punktegewinne",
        headerToggleResource                = "Ressourcen",
        descriptionAlert                    = "Setze 'Tipps im Kampf' unter Einstellungen / Oberfläche auf 'immer anzeigen'",
    --General
        inCombatOnly                        = "nur im Kampf",
    --Combat State
        combatState                         = "Kampfstatus",
        inCombat                            = "Kampfbeginn",
        outCombat                           = "Kampfende",
    --Damage & Healing
        damage                              = "Schaden",
        healing                             = "Heilung",
        energize                            = "Aufladen",
        ultimateEnergize                    = "Ultimate Aufladung",
        drain                               = "Auszehren",
        tick                                = "DoT & HoT",
        dot                                 = "Schaden über Zeit ('Dot')",
        hot                                 = "Heilung über Zeit ('Hot')",
        critical                            = "Kritisch",
    --Mitigation
        mitigation                          = "Schadensminderung",
        miss                                = "Verfehlt",
        immune                              = "Immun",
        parried                             = "Pariert",
        reflected                           = "Reflektiert",
        damageShield                        = "Abgeschirmt",
        dodged                              = "Ausgewichen",
        blocked                             = "Geblockt",
        interrupted                         = "Unterbrochen",
    --Crowd Control
        crowdControl                        = "Kontrolliert",
        disoriented                         = "Desorientiert",
        feared                              = "Verängstigt",
        offBalanced                         = "Gestrauchelt",
        silenced                            = "Verstummt",
        stunned                             = "Benommen",
    --Alerts
        alert                               = "Tipps im Kampf",
        alertCleanse                        = "Jetzt reinigen",
        alertBlock                          = "Jetzt blocken",
        alertExploit                        = "Jetzt ausnutzen",
        alertInterrupt                      = "Jetzt unterbrechen",
        alertDodge                          = "Jetzt ausweichen",
        alertExecute                        = "Jetzt hinrichten",
        executeThreshold                    = "Hinrichten Schwelle",
        executeFrequency                    = "Hinrichtenfrequenz",
        ingameTips                          = "Tipps im Kampf ausblenden",
    --Points
        point                               = "Punkte (AP, EP & CP)",
        pointsAlliance                      = "Allianzpunkte",
        pointsExperience                    = "Erfahrungspunkte",
        pointsChampion                       = "Championenpunkte",
    --Resources
        resource                            = "Ressourcen",
        formatResource                      = "Niedrige Ressourcen",
        lowHealth                           = "Leben niedrig",
        lowMagicka                          = "Magicka niedrig",
        lowStamina                          = "Ausdauer niedrig",
        ultimateReady                       = "Ultimative Fähigkeit bereit",
        potionReady                         = "Trank bereit",
        warningSound                        = "Warnton",
        warningThresholdHealth              = "Schwellenwert für Warnungen (Leben)",
        warningThresholdMagicka             = "Schwellenwert für Warnungen (Magicka)",
        warningThresholdStamina             = "Schwellenwert für Warnungen (Ausdauer)",
    --Tooltips General
        tooltipInCombatOnly                 = "Ein- und ausgehende Werte werden nur im Kampf angezeigt",
    --Tooltips Incoming
        --Damage & Healing
        tooltipIncomingDamage               = "Zeige eingehenden Schaden",
        tooltipIncomingHealing              = "Zeige eingehende Heilung",
        tooltipIncomingEnergize             = "Zeige eingehenden Magicka- / Ausdauerzugewinn",
        tooltipIncomingUltimateEnergize     = "Zeige eingehende Ultimate-Punkte",
        tooltipIncomingDrain                = "Zeige eingehenden Magicka- / Ausdauerverlust",
        tooltipIncomingDot                  = "Zeige eingehenden Schaden über Zeit 'DoT'",
        tooltipIncomingHot                  = "Zeige eingehende Heilung über Zeit 'HoT''",
        --Mitigation
        tooltipIncomingMiss                 = "Zeige verfehlte Schläge des Gegners",
        tooltipIncomingImmune               = "Zeige Immunität gegen Angriffe des Gegners",
        tooltipIncomingParried              = "Zeige erfolgreiches Parieren von gegnerischen Angriffen",
        tooltipIncomingReflected            = "Zeige erfolgreich reflektierte Angriffe des Gegners",
        tooltipIncomingDamageShield         = "Zeige mit Hilfe eines Schadensschilds absorbierte Angriffe des Gegners",
        tooltipIncomingDodge                = "Zeige erfolgreiches Ausweichen vor gegnerischen Angriffen",
        tooltipIncomingBlocked              = "Zeige erfolgreiches Blocken von gegnerischen Angriffen",
        tooltipIncomingInterrupted          = "Zeige unterbrochene Angriffe",
        --Crowd Control
        tooltipIncomingDisoriented          = "Zeige den auf den Spieler gewirkten Effekt 'desorientiert'",
        tooltipIncomingFeared               = "Zeige den auf den Spieler gewirkten Effekt 'verängstigt'",
        tooltipIncomingOffBalanced          = "Zeige den auf den Spieler gewirkten Effekt 'gestrauchelt'",
        tooltipIncomingSilenced             = "Zeige den auf den Spieler gewirkten Effekt 'verstummt'",
        tooltipIncomingStunned              = "Zeige den auf den Spieler gewirkten Effekt 'benommen'",
    --Tooltips Outgoing
        --Damage & Healing
        tooltipOutgoingDamage               = "Zeige ausgehenden Schaden",
        tooltipOutgoingHealing              = "Zeige ausgehende Heilung",
        tooltipOutgoingEnergize             = "Zeige ausgehenden Magicka- / Ausdauerzugewinn",
        tooltipOutgoingUltimateEnergize     = "Zeige ausgehende Ultimate-Punkte",
        tooltipOutgoingDrain                = "Zeige ausgehenden Magicka- / Ausdauerverlust",
        tooltipOutgoingDot                  = "Zeige ausgehenden Schaden über Zeit 'DoT'",
        tooltipOutgoingHot                  = "Zeige ausgehende Heilung über Zeit 'HoT''",
        --Mitigation
        tooltipOutgoingMiss                 = "Zeige verfehlte Schläge des Spielers",
        tooltipOutgoingImmune               = "Zeige Immunität gegen Angriffe des Spielers",
        tooltipOutgoingParried              = "Zeige erfolgreiches Parieren des Gegners",
        tooltipOutgoingReflected            = "Zeige ob der Angriff reflektiert wurde",
        tooltipOutgoingDamageShield         = "Zeige mit Hilfe eines Schadensschilds absorbierte Angriffe des Spielers",
        tooltipOutgoingDodge                = "Zeige erfolgreiches Ausweichen des Gegners",
        tooltipOutgoingBlocked              = "Zeige erfolgreiches Blocken des Gegners",
        tooltipOutgoingInterrupted          = "Zeige ob der Gegner den Angriff unterbrochen hat",
        --Crowd Control
        tooltipOutgoingDisoriented          = "Zeige den auf Gegner gewirkten Effekt 'desorientiert'",
        tooltipOutgoingFeared               = "Zeige den auf Gegner gewirkten Effekt 'verängstigt'",
        tooltipOutgoingOffBalanced          = "Zeige den auf Gegner gewirkten Effekt 'gestrauchelt'",
        tooltipOutgoingSilenced             = "Zeige den auf Gegner gewirkten Effekt 'verstummt'",
        tooltipOutgoingStunned              = "Zeige den auf Gegner gewirkten Effekt 'benommen'",
    --Tooltips Combat State
        tooltipInCombat                     = "Zeige eine Hinweis bei Kampfbegin / Kampfbeitritt",
        tooltipOutCombat                    = "Zeige eine Hinweis bei Kampfende",
    --Tooltips Alerts
        tooltipAlertsCleanse                = "Zeige Warnhinweis sobald Reinigen erforderlich ist",
        tooltipAlertsBlock                  = "Zeige Warnhinweis sobald ein Spezialangriff geblockt werden kann",
        tooltipAlertsExploit                = "Zeige Warnhinweis sobald eine Schwäche des Ziels ausgenutzt werden kann",
        tooltipAlertsInterrupt              = "Zeige Warnhinweis sobald ein Spezialangriff unterbrochen werden kann",
        tooltipAlertsDodge                  = "Zeige Warnhinweis sobald einem Spezialangriff ausgewichen werden kann",
        tooltipAlertsExecute                = "Hinweis anzeigen wenn das Ziel wenig Leben hat",
        tooltipExecuteThreshold             = "Schwellenwert bei dessen erreichen eine Warnung zur Hinrichtung ausgelöst wird. Die Standardeinstellung für eine Warnung liegt hierbei auf 20%",
        tooltipExecuteFrequency             = "Die Frequenz mit der der Hinrichtungs Hinweis für das selbe Ziel ausgelöst wird. Standard ist 8 Sekunden.",
        tooltipIngameTips                   = "Aktiver Kampf-Tips Standard Fenster verstecken",
    --Tooltips Points
        tooltipPointsAlliance               = "Zeige summierte Allianzpunkte",
        tooltipPointsExperience             = "Zeige summierte Erfahrungspunkte",
        tooltipPointsChampion                = "Zeige summierte Championenpunkte",
    --Tooltips Resources
        tooltipLowHealth                    = "Zeige Warnung sobald der Schwellenwert für 'Leben' unterschritten wird",
        tooltipLowMagicka                   = "Zeige Warnung sobald der Schwellenwert für 'Magicka' unterschritten wird",
        tooltipLowStamina                   = "Zeige Warnung sobald der Schwellenwert für 'Ausdauer' unterschritten wird",
        tooltipUltimateReady                = "Zeige Hinweis sobald die aktuell ausgerüstete ultimative Fähigkeit ausgelöst werden kann",
        tooltipPotionReady                  = "Zeige Hinweis sobald Trank ist einsatzbereit",
        tooltipWarningSound                 = "Warnton abspielen sobald der Schwellenwert für eine Ressource unterschritten wird",
        tooltipWarningThresholdHealth       = "Schwellenwert bei dessen erreichen eine Warnung ausgelöst wird. Die Standardeinstellung für eine Warnung liegt hierbei auf 35%",
        tooltipWarningThresholdMagicka      = "Schwellenwert bei dessen erreichen eine Warnung ausgelöst wird. Die Standardeinstellung für eine Warnung liegt hierbei auf 35%",
        tooltipWarningThresholdStamina      = "Schwellenwert bei dessen erreichen eine Warnung ausgelöst wird. Die Standardeinstellung für eine Warnung liegt hierbei auf 35%",
---------------------------------------------------------------------------------------------------------------------------------------
    --//FONT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonFont                          = "Schrifteinstellungen",
        buttonFontCombat                    = "Schriftgröße [Kampf]",
        buttonFontNotification              = "Schriftgröße [Hinweise]",
    --General Fonts
        fontFace                            = "Schriftart",
        fontOutline                         = "Schriftumrandung",
        fontTest                            = "testen",
        gainLoss                            = "Aufladen & Auszehren",
    --Tooltips Fonts
        tooltipFontFace                     = "Wähle eine Schriftart",
        tooltipFontOutline                  = "Wähle eine Schriftumrandung",
        tooltipFontTest                     = "Zeigt zufällige Zahlenwerte um die Schrifteinstellungen zu testen",
    --Tooltips Fonts Combat
        tooltipFontDamage                   = "Schriftgröße für Schaden, Standard 26",
        tooltipFontHealing                  = "Schriftgröße für direkte Heilungen und Aufladen, Standard 26",
        tooltipFontGainLoss                 = "Schriftgröße für Aufladen und Auszehren, Standard 18",
        tooltipFontTick                     = "Schriftgröße für Schaden und Heilung über Zeit 'DoT & HoT', Standard 18",
        tooltipFontCritical                 = "Schriftgröße für kritische Treffer, Standard 36",
        tooltipFontMitigation               = "Schriftgröße für Schadensminderung, Standard 30",
        tooltipFontCrowdControl             = "Schriftgröße für Kontrolleffekte, Standard 36",
    --Tooltips Fonts Combat State, Alerts, Points, Resources
        tooltipFontCombatState              = "Hinweis für Kampfbeitritt und Kampfende, Standard 32",
        tooltipFontAlert                    = "Schriftgröße für Tipps im Kampf, Standard 48",
        tooltipFontPoint                    = "Schriftgröße für Allianz-, Erfahrungs- und Championenpunkte, Standard 32",
        tooltipFontResource                 = "Schriftgröße für Magicka-, Lebens- und Ausdauerwarnungen, Standard 48",
---------------------------------------------------------------------------------------------------------------------------------------
    --//COLOR OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonColorCombat                   = "Farbeinstellungen [Kampf]",
        buttonColorNotification             = "Farbeinstellungen [Hinweise]",
        headerColorDamageHealing            = "Farben für Schaden & Heilung",
        headerColorMitigation               = "Farben für Schadensminderung",
        headerColorCrowdControl             = "Farben für Kontrolleffekte",
        headerColorCombatState              = "Farben für Kampfstatus",
        headerColorAlert                    = "Farben für 'Tipps im Kampf'",
        headerColorPoint                    = "Farben für Punktgewinne",
        headerColorResource                 = "Farbe für Ressourcen",
    --Damage & Healing
        energizeMagicka                     = "Aufladen (Magicka)",
        energizeStamina                     = "Aufladen (Ausdauer)",
        energizeUltimate                    = "Energize (Ultimate)",
        drainMagicka                        = "Auszehren (Magicka)",
        drainStamina                        = "Auszehren (Ausdauer)",
        colorCriticalDamage                 = "Übergeordnete Farbe für kritischen Schaden",
        colorCriticalHealing                = "Übergeordnete Farbe für kritische Heilung",
        damageType = {
            [DAMAGE_TYPE_NONE]              = "Keiner",
            [DAMAGE_TYPE_GENERIC]           = "Generisch",
            [DAMAGE_TYPE_PHYSICAL]          = "Physisch",
            [DAMAGE_TYPE_FIRE]              = "Feuer",
            [DAMAGE_TYPE_SHOCK]             = "Blitz",
            [DAMAGE_TYPE_OBLIVION]          = "Vergessen",
            [DAMAGE_TYPE_COLD]              = "Frost",
            [DAMAGE_TYPE_EARTH]             = "Erde",
            [DAMAGE_TYPE_MAGIC]             = "Magisch",
            [DAMAGE_TYPE_DROWN]             = "Ertrinken",
            [DAMAGE_TYPE_DISEASE]           = "Krankheit",
            [DAMAGE_TYPE_POISON]            = "Gift",
        },
    --Tooltips damage & healing
        tooltipColorHealing                 = "Wähle eine Farbe für alle Heilungen",
        tooltipColorEnergizeMagicka         = "Wähle eine Farbe für Magickazugewinn",
        tooltipColorEnergizeStamina         = "Wähle eine Farbe für Ausdauerzugewinn",
        tooltipColorEnergizeUltimate        = "Wähle eine Farbe für Ultimategewinn",
        tooltipColorDrainMagicka            = "Wähle eine Farbe für Magickaverlust",
        tooltipColorDrainStamina            = "Wähle eine Farbe für Ausdauerverlust",
        tooltipColorCriticalDamage          = "Ersetzt die Farbe für kritischen Schaden unabhängig von der Schadensart und deren Farbeinstellung",
        tooltipColorCriticalHealing         = "Ersetzt die Farbe für kritische Heilung unabhängig von der Heilungsart und deren Farbeinstellung",
        tooltipCriticalDamageOverride       = "Zeige die übergeordnete Farbe für kritischen Schaden",
        tooltipCriticalHealingOverride      = "Zeige die übergeordnete Farbe für kritische Heilung",
        tooltipDamageType = {
            [DAMAGE_TYPE_NONE]              = "Wähle eine Farbe für Schaden ohne spezifische Zuordnung 'Keiner'",
            [DAMAGE_TYPE_GENERIC]           = "Wähle eine Farbe für Schaden mit der Zuordnung 'Generisch'",
            [DAMAGE_TYPE_PHYSICAL]          = "Wähle eine Farbe für Schaden mit der Zuordnung 'Physisch'",
            [DAMAGE_TYPE_FIRE]              = "Wähle eine Farbe für Schaden mit der Zuordnung 'Feuer'",
            [DAMAGE_TYPE_SHOCK]             = "Wähle eine Farbe für Schaden mit der Zuordnung 'Blitz'",
            [DAMAGE_TYPE_OBLIVION]          = "Wähle eine Farbe für Schaden mit der Zuordnung 'Vergessen (Oblivion)'",
            [DAMAGE_TYPE_COLD]              = "Wähle eine Farbe für Schaden mit der Zuordnung 'Frost'",
            [DAMAGE_TYPE_EARTH]             = "Wähle eine Farbe für Schaden mit der Zuordnung 'Erde'",
            [DAMAGE_TYPE_MAGIC]             = "Wähle eine Farbe für Schaden mit der Zuordnung 'Magisch'",
            [DAMAGE_TYPE_DROWN]             = "Wähle eine Farbe für Schaden mit der Zuordnung 'Ertrinken'",
            [DAMAGE_TYPE_DISEASE]           = "Wähle eine Farbe für Schaden mit der Zuordnung 'Krankheit'",
            [DAMAGE_TYPE_POISON]            = "Wähle eine Farbe für Schaden mit der Zuordnung 'Gift'",
        },
    --Tooltips Mitigation
        tooltipColorMiss                    = "Wähle eine Farbe für verfehlte Angriffe",
        tooltipColorImmune                  = "Wähle eine Farbe für Immunität gegen Angriffe",
        tooltipColorParried                 = "Wähle eine Farbe für parierte Angriffe",
        tooltipColorReflected               = "Wähle eine Farbe für reflektierte Angriffe",
        tooltipColorDamageShield            = "Wähle eine Farbe für Schadensschildabsorptionen",
        tooltipColorDodge                   = "Wähle eine Farbe für durch Ausweichen vermiedene Angriffe",
        tooltipColorBlocked                 = "Wähle eine Farbe für geblockte Angriffe",
        tooltipColorInterrupted             = "Wähle eine Farbe für unterbrochene Angriffe",
    --Tooltips Crowd Control
        tooltipColorDisoriented             = "Wähle eine Farbe für den Hinweis: 'desorientiert'",
        tooltipColorFeared                  = "Wähle eine Farbe für den Hinweis: 'verängstigt'",
        tooltipColorOffBalanced             = "Wähle eine Farbe für den Hinweis: 'gestrauchelt'",
        tooltipColorSilenced                = "Wähle eine Farbe für den Hinweis: 'verstummt'",
        tooltipColorStunned                 = "Wähle eine Farbe für den Hinweis: 'benommen'",
    --Tooltips Alerts
        tooltipColorAlertsCleanse           = "Wähle eine Farbe für die Warnung: 'Jetzt reinigen'",
        tooltipColorAlertsBlock             = "Wähle eine Farbe für die Warnung: 'Jetzt blocken'",
        tooltipColorAlertsExploit           = "Wähle eine Farbe für die Warnung: 'Jetzt ausnutzen'",
        tooltipColorAlertsInterrupt         = "Wähle eine Farbe für die Warnung: 'Jetzt unterbrechen'",
        tooltipColorAlertsDodge             = "Wähle eine Farbe für die Warnung: 'Jetzt ausweichen'",
        tooltipColorAlertsExecute           = "Wähle eine Farbe für die Warnung: 'Jetzt hinrichten'",
    --Tooltips Points
        tooltipColorPointsAlliance          = "Wähle eine Farbe für Allianzpunkte (kurz aufeinanderfolgende Punktgewinne werden aufsummiert)",
        tooltipColorPointsExperience        = "Wähle eine Farbe für Erfahrungspunkte (kurz aufeinanderfolgende Punktgewinne werden aufsummiert)",
        tooltipColorPointsChampion           = "Wähle eine Farbe für Championenpunkte (kurz aufeinanderfolgende Punktgewinne werden aufsummiert)",
    --Tooltips Resources
        tooltipColorLowHealth               = "Wähle eine Farbe für die Warnung: Leben niedrig",
        tooltipColorLowMagicka              = "Wähle eine Farbe für die Warnung: Magicka niedrig",
        tooltipColorLowStamina              = "Wähle eine Farbe für die Warnung: Ausdauer niedrig",
        tooltipColorUltimateReady           = "Wähle eine Farbe für den Hinweis: Ultimative Fähigkeit bereit",
        tooltipColorPotionReady             = "Wähle eine Farbe für den Hinweis: Trank bereit",
    --Tooltips Combat State
        tooltipColorInCombat                = "Wähle eine Farbe für den Hinweis bei Kampfbeitritt",
        tooltipColorOutCombat               = "Wähle eine Farbe für den Hinweis bei Kampfende",
---------------------------------------------------------------------------------------------------------------------------------------
    --//FORMAT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        descriptionFormat                   = "Erlaubt Änderungen der Textausgabe. Gib einen beliebigen Text oder eine Variable für spezielle Anzeigen ein\n %t Fähigkeitsname, Lokalisierung\n %a Menge, Wert\n %r Power type, resource",
        buttonFormatCombat                  = "Formateinstellungen [Kampf]",
        buttonFormatNotification            = "Formateinstellungen [Hinweise]",
        headerFormatDamageHealing           = "Textformat für Schaden und Heilung",
        headerFormatMitigation              = "Textformat für Schadensminderung",
        headerFormatCrowdControl            = "Textformat für Kontrolleffekte",
        headerFormatCombatState             = "Textformat für Kampfstatus",
        headerFormatAlert                   = "Textformat für Tipps im Kampf",
        headerFormatPoint                   = "Textformat für Punktgewinne",
        headerFormatResource                = "Textformat für Ressourcen",
    --Tooltips Damage & Healing
        tooltipFormatDamage                 = "Textformat für Schadenswerte",
        tooltipFormatHealing                = "Textformat für direkte Heilungen",
        tooltipFormatEnergize               = "Textformat für Magicka- / Ausdauerzugewinn",
        tooltipFormatUltimateEnergize       = "Textformat für Ultimategewinn",
        tooltipFormatDrain                  = "Textformat für Magicka- / Ausdauerverlust",
        tooltipFormatDot                    = "Textformat für Schaden über Zeit 'DoT'",
        tooltipFormatHot                    = "Textformat für Heilung über Zeit 'HoT'",
        tooltipFormatCritical               = "Textformat für kritische Schadenswerte",
    --Tooltips Mitigation
        tooltipFormatMiss                   = "Textformat für verfehlte Angriffe",
        tooltipFormatImmune                 = "Textformat für Immunität gegen Angriffe",
        tooltipFormatParried                = "Textformat für parierte Angriffe",
        tooltipFormatReflected              = "Textformat für reflektierte Angriffe",
        tooltipFormatDamageShield           = "Textformat für Schadensschildabsorbtionen",
        tooltipFormatDodged                 = "Textformat für durch Ausweichen vermiedene Angriffe",
        tooltipFormatBlocked                = "Textformat für geblockte Angriffe",
        tooltipFormatInterrupted            = "Textformat für unterbrochene Angriffe",
    --Tooltips Crowd Control
        tooltipFormatDisoriented            = "Textformat für den Hinweis: 'desorientiert'",
        tooltipFormatFeared                 = "Textformat für den Hinweis: 'verängstigt'",
        tooltipFormatOffBalanced            = "Textformat für den Hinweis: 'gestrauchelt'",
        tooltipFormatSilenced               = "Textformat für den Hinweis: 'verstummt'",
        tooltipFormatStunned                = "Textformat für den Hinweis: 'benommen'",
    --Tooltips Alerts
        tooltipFormatAlertsCleanse          = "Textformat für die Warnung: 'Jetzt reinigen'",
        tooltipFormatAlertsBlock            = "Textformat für die Warnung: 'Jetzt blocken'",
        tooltipFormatAlertsExploit          = "Textformat für die Warnung: 'Jetzt ausnutzen'",
        tooltipFormatAlertsInterrupt        = "Textformat für die Warnung: 'Jetzt unterbrechen'",
        tooltipFormatAlertsDodge            = "Textformat für die Warnung: 'Jetzt ausweichen'",
        tooltipFormatAlertsExecute          = "Textformat für die Warnung: 'Jetzt hinrichten'",
    --Tooltips Points
        tooltipFormatPointsAlliance         = "Textformat für summierte Allianzpunkte",
        tooltipFormatPointsExperience       = "Textformat für summierte Erfahrungspunkte",
        tooltipFormatPointsChampion          = "Textformat für summierte Championenpunkte",
    --Tooltips Resources
        tooltipFormatResource               = "Textformat für Warnungen bei niedrigen Ressourcen (Magicka, Leben, Ausdauer)",
        tooltipFormatUltimateReady          = "Textformat für die Hinweise bei einsatzbereiter ultimativer Fähigkeit",
        tooltipFormatPotionReady            = "Textformat für die Hinweise bei einsatzbereiter Trank",
    --Tooltips Combat State
        tooltipFormatInCombat               = "Textformat für Hinweise bei Kampfbeitritt",
        tooltipFormatOutCombat              = "Textformat für Hinweise bei Kampfende",
---------------------------------------------------------------------------------------------------------------------------------------
    --//ANIMATION OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonAnimation                     = "Animationseinstellungen",
    --General
        animationType                       = "Animationsart",
        outgoingDirection                   = "Richtung ausgehend",
        incomingDirection                   = "Richtung eingehend",
        animationTest                       = "Testanimation",
        outgoingIcon                        = "Position des Ausgehend Icons",
        incomingIcon                        = "Position des Eingehend Icons",
    --Tooltips
        tooltipAnimationType                = "Wähle die Animationsart",
        tooltipAnimationIncomingDirection   = "Wähle die Richtung für eingehenden Schaden",
        tooltipAnimationOutgoingDirection   = "Wähle die Richtung für ausgehenden Schaden",
        tooltipAnimationTest                = "Teste die Animationen für eingehenden und ausgehenden Schaden",
        tooltipAnimationOutgoingIcon        = "Lege die Position für das ausgehende Ereignisse Icon fest",
        tooltipAnimationIncomingIcon        = "Lege die Position für das eingehende Ereignisse Icon fest",
---------------------------------------------------------------------------------------------------------------------------------------
    --//THROTTLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonThrottle                      = "Genauigkeitseinstellung",
    --General
        descriptionThrottle                 = "Fast mehrere schnell aufeinender folgende Treffer zu einem zusammen. Der Schieberegler bestimmt den zusammenzufassenden Zeitraum in Millisekunden. Kritische Treffer werden nie zusammengefasst.\n",
        showThrottleTrailer                 = "Zeige Vorschau", -- probably not 100% fitting
    --Tooltips
        tooltipThrottleDamage               = "Wähle die Genauigkeit für Schadenswerte",
        tooltipThrottleHealing              = "Wähle die Genauigkeit für Heilungen",
        tooltipThrottleDot                  = "Wähle die Genauigkeit für Schaden über Zeit 'DoT'",
        tooltipThrottleHot                  = "Wähle die Genauigkeit für Heilung über Zeit 'HoT'",
        tooltipThrottleTrailer              = "Aktiviert die Vorschaufunktion der Genauigkeitseinstellung 'Enable throttle trailer'", -- probably not 100% fitting
        tooltipThrottleCritical             = "Aktiviert die Genauigkeit für kritische Treffer",
}