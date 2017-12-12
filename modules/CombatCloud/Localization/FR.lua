CombatCloudLocalization = {
---------------------------------------------------------------------------------------------------------------------------------------
    --//PANEL TITLES//--
---------------------------------------------------------------------------------------------------------------------------------------
    panelTitles = {
        CombatCloud_Outgoing                = "Événements sortants",
        CombatCloud_Incoming                = "Événements entrants",
        CombatCloud_Point                   = "Points",
        CombatCloud_Alert                   = "Alertes",
        CombatCloud_Resource                = "Ressources"
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//MAIN//--
---------------------------------------------------------------------------------------------------------------------------------------
        combatCloudOptions                  = "Options de Combat Cloud",
        unlock                              = "Déverrouiller",
        unlockTooltip                       = "Déverrouille les panneaux pour les déplacer",
---------------------------------------------------------------------------------------------------------------------------------------
    --//TOGGLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonToggleIncoming                = "Événements entrants",
        buttonToggleOutgoing                = "Événements sortants",
        buttonToggleNotification            = "Notifications",
        headerToggleIncomingDamageHealing   = "Dégâts et soins entrants",
        headerToggleIncomingMitigation      = "Mitigations entrantes",
        headerToggleIncomingCrowdControl    = "Contrôles des foules entrants",
        headerToggleOutgoingDamageHealing   = "Dégâts et soins sortants",
        headerToggleOutgoingMitigation      = "Mitigations sortantes",
        headerToggleOutgoingCrowdControl    = "Contrôles des foules sortants",
        headerToggleCombatState             = "États de combat",
        headerToggleAlert                   = "Alertes de combat",
        headerTogglePoint                   = "Points",
        headerToggleResource                = "Ressources",
        descriptionAlert                    = "Activez les aides de combat pour toujours les afficher dans les options de l'interface",
    --General
        inCombatOnly                        = "Seulement en combat",
    --Combat State
        combatState                         = "État de combat",
        inCombat                            = "En combat",
        outCombat                           = "Hors combat",
    --Damage & Healing
        damage                              = "Dégât",
        healing                             = "Soin",
        energize                            = "Gain",
        ultimateEnergize                    = "Gain d'ultime",
        drain                               = "Drain",
        tick                                = "Dégât et soin sur la durée",
        dot                                 = "Dégât sur la durée",
        hot                                 = "Soin sur la durée",
        critical                            = "Critique",
    --Mitigation
        mitigation                          = "Mitigation",
        miss                                = "Manqué",
        immune                              = "Insensible",
        parried                             = "Paré",
        reflected                           = "Renvoyé",
        damageShield                        = "Absorbé",
        dodged                              = "Esquivé",
        blocked                             = "Bloqué",
        interrupted                         = "Interrompu",
    --Crowd Control
        crowdControl                        = "Contrôle de foule",
        disoriented                         = "Désorienté",
        feared                              = "Effrayé",
        offBalanced                         = "Déséquilibré",
        silenced                            = "Réduit au silence",
        stunned                             = "Étourdi",
    --Alerts
        alert                               = "Alertes de combat",
        alertCleanse                        = "Purge",
        alertBlock                          = "Bloque",
        alertExploit                        = "Exploite",
        alertInterrupt                      = "Interrompt",
        alertDodge                          = "Esquive",
        alertExecute                        = "Exécution",
        executeThreshold                    = "Seuil d'exécution",
        executeFrequency                    = "Fréquence d'exécution",
        ingameTips                          = "Masquer les aides au combat par défaut",
    --Points
        point                               = "Points d'alliance, d'expérience et vétéran",
        pointsAlliance                      = "Points d'alliance",
        pointsExperience                    = "Points d'experience",
        pointsChampion                       = "Points de vétéran",
    --Resources
        resource                            = "Ressources",
        formatResource                      = "Ressources faibles",
        lowHealth                           = "Santé faible",
        lowMagicka                          = "Magie faible",
        lowStamina                          = "Vigueur faible",
        ultimateReady                       = "Ultime disponible",
        potionReady                         = "Potion prêt",
        warningSound                        = "Avertissement sonore",
        warningThresholdHealth              = "Seuil d'avertissement Santé",
        warningThresholdMagicka             = "Seuil d'avertissement Magie",
        warningThresholdStamina             = "Seuil d'avertissement Vigueur",
    --Tooltips General
        tooltipInCombatOnly                 = "Affiche les nombres entrants et sortants qu'en combat",
    --Tooltips Incoming
        --Damage & Healing
        tooltipIncomingDamage               = "Affiche les dégâts entrants",
        tooltipIncomingHealing              = "Affiche les soins instantanés entrants",
        tooltipIncomingEnergize             = "Affiche les gains de magie/vigueur entrants",
        tooltipIncomingUltimateEnergize     = "Affiche les gains d'ultime entrants",
        tooltipIncomingDrain                = "Affiche les pertes de magie/vigueur entrantes",
        tooltipIncomingDot                  = "Affiche les 'dégâts sur la durée' entrants",
        tooltipIncomingHot                  = "Affiche les 'soins sur la durée' entrants",
        --Mitigation
        tooltipIncomingMiss                 = "Affiche les attaques ennemies manquées",
        tooltipIncomingImmune               = "Affiche les attaques ennemies dont vous êtes insensible",
        tooltipIncomingParried              = "Affiche les attaques ennemies parées",
        tooltipIncomingReflected            = "Affiche les attaques ennemies renvoyées",
        tooltipIncomingDamageShield         = "Affiche les attaques ennemies absorbées par votre bouclier",
        tooltipIncomingDodge                = "Affiche les attaques ennemies évitées",
        tooltipIncomingBlocked              = "Affiche les attaques ennemies bloquées",
        tooltipIncomingInterrupted          = "Affiche les attaques ennemies interrompues",
        --Crowd Control
        tooltipIncomingDisoriented          = "Affiche si vous êtes désorienté",
        tooltipIncomingFeared               = "Affiche si vous êtes effrayé",
        tooltipIncomingOffBalanced          = "Affiche si vous êtes déséquilibré",
        tooltipIncomingSilenced             = "Affiche si vous êtes réduit au silence",
        tooltipIncomingStunned              = "Affiche si vous êtes étourdi",
    --Tooltips Outgoing
        --Damage & Healing
        tooltipOutgoingDamage               = "Affiche les dégâts sortants",
        tooltipOutgoingHealing              = "Affiche les soins instantanés sortants",
        tooltipOutgoingEnergize             = "Affiche les gains de magie/vigueur sortants",
        tooltipOutgoingUltimateEnergize     = "Affiche les gains d'ultime sortants",
        tooltipOutgoingDrain                = "Affiche les pertes de magie/vigueur sortantes",
        tooltipOutgoingDot                  = "Affiche les 'dégâts sur la durée' sortant",
        tooltipOutgoingHot                  = "Affiche les 'soins sur la durée' sortant",
        --Mitigation
        tooltipOutgoingMiss                 = "Affiche les attaques manquées sur l'ennemi",
        tooltipOutgoingImmune               = "Affiche si l'ennemi est insensible à votre attaque",
        tooltipOutgoingParried              = "Affiche si l'ennemi pare votre attaque",
        tooltipOutgoingReflected            = "Affiche si l'ennemi renvoie votre attaque",      
        tooltipOutgoingDamageShield         = "Affiche si le bouclier de l'ennemi absorbe votre attaque",
        tooltipOutgoingDodge                = "Affiche si l'ennemi évite votre attaque",
        tooltipOutgoingBlocked              = "Affiche si l'ennemi bloque votre attaque",
        tooltipOutgoingInterrupted          = "Affiche si l'ennemi interrompt votre attaque",
        --Crowd Control
        tooltipOutgoingDisoriented          = "Affiche si vous avez désorienté l'ennemi",
        tooltipOutgoingFeared               = "Affiche si vous avez effrayé l'ennemi",
        tooltipOutgoingOffBalanced          = "Affiche si vous avez déséquilibré l'ennemi",
        tooltipOutgoingSilenced             = "Affiche si vous avez réduit au silence l'ennemi",
        tooltipOutgoingStunned              = "Affiche si vous avez étourdi l'ennemi",
    --Tooltips Combat State
        tooltipInCombat                     = "Affiche une notification à l'entrée en combat",
        tooltipOutCombat                    = "Affiche une notification à la sortie du combat",
    --Tooltips Alerts
        tooltipAlertsCleanse                = "Affiche une alerte lorsque vous avez besoin de purger",
        tooltipAlertsBlock                  = "Affiche une alerte lorsque vous pouvez bloquer une attaque spéciale",
        tooltipAlertsExploit                = "Affiche une alerte lorsque vous pouvez exploiter la cible",
        tooltipAlertsInterrupt              = "Affiche une alerte lorsque vous pouvez interrompre une attaque spéciale",
        tooltipAlertsDodge                  = "Affiche une alerte lorsque vous pouvez esquiver une attaque spéciale",
        tooltipAlertsExecute                = "Affiche une alerte lorsque votre cible est basse en vie. ",
        tooltipExecuteThreshold             = "Le seuil à partir duquel l'alerte pour l'exécution se déclenche. Par défaut il s'affichera si la vie de votre cible est à 20% ou moins.",
        tooltipExecuteFrequency             = "La fréquence d'affichage de l'alerte pour l'exécution d'une même cible. Par défaut l'alerte se répète toutes les 8 secondes.",
        tooltipIngameTips                   = "Masque les aides au combat par défaut",
    --Tooltips Points
        tooltipPointsAlliance               = "Affiche le gain de points d'alliance",
        tooltipPointsExperience             = "Affiche le gain de points d'expérience",
        tooltipPointsChampion                = "Affiche le gain de points de vétéran",
    --Tooltips Resources
        tooltipLowHealth                    = "Affiche un avertissement lorsque le seuil de votre santé est atteint",
        tooltipLowMagicka                   = "Affiche un avertissement lorsque le seuil de votre magie est atteint",
        tooltipLowStamina                   = "Affiche un avertissement lorsque le seuil de votre vigueur est atteint",
        tooltipUltimateReady                = "Affiche une notification lorsque votre compétence ultime est disponible",
        tooltipPotionReady                  = "Affiche une notification lorsque potion est prêt à l'emploi",
        tooltipWarningSound                 = "Joue un son lorsque le seuil de la resource est atteint",
        tooltipWarningThresholdHealth       = "Le seuil à partir duquel les avertissements sont déclenchés",
        tooltipWarningThresholdMagicka      = "Le seuil à partir duquel les avertissements sont déclenchés",
        tooltipWarningThresholdStamina      = "Le seuil à partir duquel les avertissements sont déclenchés",
---------------------------------------------------------------------------------------------------------------------------------------
    --//FONT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonFont                          = "Options de police",
        buttonFontCombat                    = "Taille des polices des événements de combat",
        buttonFontNotification              = "Taille des polices des notifications",
    --General Fonts
        fontFace                            = "Police",
        fontOutline                         = "Contour",
        fontTest                            = "Tester la police",
        gainLoss                            = "Gain et drain",
    --Tooltips Fonts
        tooltipFontFace                     = "Définit la police à utiliser",
        tooltipFontOutline                  = "Définit l'option de contour à utiliser",
        tooltipFontTest                     = "Affiche un échantillon de nombres pour tester la police",
    --Tooltips Fonts Combat
        tooltipFontDamage                   = "Taille de la police des dégâts",
        tooltipFontHealing                  = "Taille de la police des soins instantanés",
        tooltipFontGainLoss                 = "Taille de la police des gains et pertes",
        tooltipFontTick                     = "Taille de la police des dégâts et soins sur la durée",
        tooltipFontCritical                 = "Taille de la police des critiques",
        tooltipFontMitigation               = "Taille de la police des mitigations",
        tooltipFontCrowdControl             = "Taille de la police des alertes de contrôle de foule",
    --Tooltips Fonts Combat State, Alerts, Points, Resources
        tooltipFontCombatState              = "Taille de la police des notifications lorsque vous entrez ou sortez de combat",
        tooltipFontAlert                    = "Taille de la police des alertes de combat",
        tooltipFontPoint                    = "Taille de la police des gains de point",
        tooltipFontResource                 = "Taille de la police des avertissements de ressource",
---------------------------------------------------------------------------------------------------------------------------------------
    --//COLOR OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonColorCombat                   = "Options de couleur des événements de combat",
        buttonColorNotification             = "Options de couleur des notifications",
        headerColorDamageHealing            = "Couleurs des dégâts et soins",
        headerColorMitigation               = "Couleurs des mitigations",
        headerColorCrowdControl             = "Couleurs des contrôles des foules",
        headerColorCombatState              = "Couleurs des états de combat",
        headerColorAlert                    = "Couleurs des alertes de combat",
        headerColorPoint                    = "Couleurs des gains de points",
        headerColorResource                 = "Couleurs des ressources",
    --Damage & Healing
        energizeMagicka                     = "Gain de magie",
        energizeStamina                     = "Gain de vigueur",
        energizeUltimate                    = "Gain d'ultime",
        drainMagicka                        = "Drain de magie",
        drainStamina                        = "Drain de vigueur",
        colorCriticalDamage                 = "Remplacer la couleur des dégâts critiques",
        colorCriticalHealing                = "Remplacer la couleur des soins critiques",
        damageType = {
            [DAMAGE_TYPE_NONE]              = "Aucun",
            [DAMAGE_TYPE_GENERIC]           = "Générique",
            [DAMAGE_TYPE_PHYSICAL]          = "Physique",
            [DAMAGE_TYPE_FIRE]              = "Feu",
            [DAMAGE_TYPE_SHOCK]             = "Foudre",
            [DAMAGE_TYPE_OBLIVION]          = "Oblivion",
            [DAMAGE_TYPE_COLD]              = "Glace",
            [DAMAGE_TYPE_EARTH]             = "Terre",
            [DAMAGE_TYPE_MAGIC]             = "Magie",
            [DAMAGE_TYPE_DROWN]             = "Noyade",
            [DAMAGE_TYPE_DISEASE]           = "Maladie",
            [DAMAGE_TYPE_POISON]            = "Poison",
        },
    --Tooltips damage & healing
        tooltipColorHealing                 = "Couleur pour tous les soins",
        tooltipColorEnergizeMagicka         = "Couleur des gains de magie",
        tooltipColorEnergizeStamina         = "Couleur des gains de vigueur",
        tooltipColorEnergizeUltimate        = "Couleur des gains d'ultime",
        tooltipColorDrainMagicka            = "Couleur des pertes de magie",
        tooltipColorDrainStamina            = "Couleur des pertes de vigueur",
        tooltipColorCriticalDamage          = "Remplace la couleur des dégâts critiques, peu importe le type de dégâts",
        tooltipColorCriticalHealing         = "Remplace la couleur des soins critiques",
        tooltipCriticalDamageOverride       = "Affiche la couleur de remplacement des dégâts critiques",
        tooltipCriticalHealingOverride      = "Affiche la couleur de remplacement des soins critiques",
        tooltipDamageType = {
            [DAMAGE_TYPE_NONE]              = "Couleur des dégâts sans type",
            [DAMAGE_TYPE_GENERIC]           = "Couleur des dégâts de type 'générique'",
            [DAMAGE_TYPE_PHYSICAL]          = "Couleur des dégâts de type 'physique'",
            [DAMAGE_TYPE_FIRE]              = "Couleur des dégâts de type 'feu'",
            [DAMAGE_TYPE_SHOCK]             = "Couleur des dégâts de type 'foudre'",
            [DAMAGE_TYPE_OBLIVION]          = "Couleur des dégâts de type 'oblivion'",
            [DAMAGE_TYPE_COLD]              = "Couleur des dégâts de type 'glace'",
            [DAMAGE_TYPE_EARTH]             = "Couleur des dégâts de type 'terre'",
            [DAMAGE_TYPE_MAGIC]             = "Couleur des dégâts de type 'magie'",
            [DAMAGE_TYPE_DROWN]             = "Couleur des dégâts de type 'noyade'",
            [DAMAGE_TYPE_DISEASE]           = "Couleur des dégâts de type 'maladie'",
            [DAMAGE_TYPE_POISON]            = "Couleur des dégâts de type 'poison'",
        },
    --Tooltips Mitigation
        tooltipColorMiss                    = "Couleur des attaques manquées",
        tooltipColorImmune                  = "Couleur pour l'insensibilité aux attaques",
        tooltipColorParried                 = "Couleur des attaques parées",
        tooltipColorReflected               = "Couleur des attaques renvoyées",
        tooltipColorDamageShield            = "Couleur des attaques absorbées par les boucliers",
        tooltipColorDodge                   = "Couleur des attaques esquivées",
        tooltipColorBlocked                 = "Couleur des attaques bloquées",
        tooltipColorInterrupted             = "Couleur des attaques interrompues",
    --Tooltips Crowd Control
        tooltipColorDisoriented             = "Couleur des notifications si désorienté",
        tooltipColorFeared                  = "Couleur des notifications si effrayé",
        tooltipColorOffBalanced             = "Couleur des notifications si déséquilibré",
        tooltipColorSilenced                = "Couleur des notifications si réduit au silence",
        tooltipColorStunned                 = "Couleur des notifications si étourdi",
    --Tooltips Alerts
        tooltipColorAlertsCleanse           = "Couleur des alertes de purge",
        tooltipColorAlertsBlock             = "Couleur des alertes de blocage",
        tooltipColorAlertsExploit           = "Couleur des alertes d'exploitation",
        tooltipColorAlertsInterrupt         = "Couleur des alertes d'interruption",
        tooltipColorAlertsDodge             = "Couleur des alertes d'esquive",
        tooltipColorAlertsExecute           = "Couleur des alertes d'exécution",
    --Tooltips Points
        tooltipColorPointsAlliance          = "Couleur des gains de points d'alliance",
        tooltipColorPointsExperience        = "Couleur des gains de points d'expérience",
        tooltipColorPointsChampion           = "Couleur des gains de points de vétéran",
    --Tooltips Resources
        tooltipColorLowHealth               = "Couleur des avertissements de santé faible",
        tooltipColorLowMagicka              = "Couleur des avertissements de magie faible",
        tooltipColorLowStamina              = "Couleur des avertissements de vigueur faible",
        tooltipColorUltimateReady           = "Couleur des notifications quand la compétence ultime est disponible",
        tooltipColorPotionReady             = "Couleur des notifications lorsque potion est prêt à l'emploi",
    --Tooltips Combat State
        tooltipColorInCombat                = "Couleur des notifications lors de l'entrée en combat",
        tooltipColorOutCombat               = "Couleur des notifications lors de la sortie de combat",
---------------------------------------------------------------------------------------------------------------------------------------
    --//FORMAT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        descriptionFormat                   = "Permet de modifier le format de texte; renseignez un texte libre et/ou utilisez les variables suivantes:\n %t Nom de la compétence\n %a Valeur\n %r Type de ressource",
        buttonFormatCombat                  = "Options de format des événements de combat",
        buttonFormatNotification            = "Options de format des notifications",
        headerFormatDamageHealing           = "Formats de texte des dégâts et des soins",
        headerFormatMitigation              = "Formats de texte des mitigations",
        headerFormatCrowdControl            = "Formats de texte des contrôles des foules",
        headerFormatCombatState             = "Formats de texte des états de combat",
        headerFormatAlert                   = "Formats de texte des alertes de combat",
        headerFormatPoint                   = "Formats de texte des gains de points",
        headerFormatResource                = "Formats de texte des ressources",
    --Tooltips Damage & Healing
        tooltipFormatDamage                 = "Format de texte des dégâts",
        tooltipFormatHealing                = "Format de texte des soins instantanés",
        tooltipFormatEnergize               = "Format de texte des gains de magie/vigueur",
        tooltipFormatUltimateEnergize       = "Format de texte des gains d'ultime",
        tooltipFormatDrain                  = "Format de texte des pertes de magie/vigueur",
        tooltipFormatDot                    = "Format de texte des 'dégâts sur la durée'",
        tooltipFormatHot                    = "Format de texte des 'soins sur la durée'",
        tooltipFormatCritical               = "Format de texte des critiques",
    --Tooltips Mitigation
        tooltipFormatMiss                   = "Format de texte des attaques manquées",
        tooltipFormatImmune                 = "Format de texte des insensibilités aux attaques",
        tooltipFormatParried                = "Format de texte des attaques parées",
        tooltipFormatReflected              = "Format de texte des attaques renvoyées",
        tooltipFormatDamageShield           = "Format de texte des attaques absorbées par les boucliers",
        tooltipFormatDodged                 = "Format de texte des attaques esquivées",
        tooltipFormatBlocked                = "Format de texte des attaques bloquées",
        tooltipFormatInterrupted            = "Format de texte des attaques interrompues",
    --Tooltips Crowd Control
        tooltipFormatDisoriented            = "Format de texte des notifications si désorienté",
        tooltipFormatFeared                 = "Format de texte des notifications si effrayé",
        tooltipFormatOffBalanced            = "Format de texte des notifications si déséquilibré",
        tooltipFormatSilenced               = "Format de texte des notifications si réduit au silence",
        tooltipFormatStunned                = "Format de texte des notifications si étourdi",
    --Tooltips Alerts
        tooltipFormatAlertsCleanse          = "Format de texte des alertes de purge",
        tooltipFormatAlertsBlock            = "Format de texte des alertes de blocage",
        tooltipFormatAlertsExploit          = "Format de texte des alertes d'exploitation",
        tooltipFormatAlertsInterrupt        = "Format de texte des alertes d'interruption",
        tooltipFormatAlertsDodge            = "Format de texte des alertes d'esquive",
        tooltipFormatAlertsExecute          = "Format de texte des alertes d'exécution",
    --Tooltips Points
        tooltipFormatPointsAlliance         = "Format de texte des gains de points d'alliance",
        tooltipFormatPointsExperience       = "Format de texte des gains de points d'expérience",
        tooltipFormatPointsChampion          = "Format de texte des gains de points de vétéran",
    --Tooltips Resources
        tooltipFormatResource               = "Format de texte des avertissements lorsque les ressources sont faibles",
        tooltipFormatUltimateReady          = "Format de texte des notifications lorsque la compétence utlime est disponible",
        tooltipFormatPotionReady            = "Format de texte des notifications lorsque potion est prête à l'emploi",
    --Tooltips Combat State
        tooltipFormatInCombat               = "Format de texte des notifications lors de l'entrée en combat",
        tooltipFormatOutCombat              = "Format de texte des notifications lors de la sortie de combat",
---------------------------------------------------------------------------------------------------------------------------------------
    --//ANIMATION OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonAnimation                     = "Options d'animation",
    --General
        animationType                       = "Type d'animation",
        outgoingDirection                   = "Sens des événements sortants",
        incomingDirection                   = "Sens des événements entrants",
        animationTest                       = "Tester l'animation",
        outgoingIcon                        = "Position des icones sortants",
        incomingIcon                        = "Position des icones entrants",
    --Tooltips
        tooltipAnimationType                = "Définit le type d'animation à utiliser",
        tooltipAnimationIncomingDirection   = "Définit le sens des événements entrants à utiliser",
        tooltipAnimationOutgoingDirection   = "Définit le sens des événements sortants à utiliser",
        tooltipAnimationTest                = "Affiche un échantillon de dégâts entrants et sortants",
        tooltipAnimationOutgoingIcon        = "Définit la position des icones pour les événements sortants",
        tooltipAnimationIncomingIcon        = "Définit la position des icones pour les événements entrants",
---------------------------------------------------------------------------------------------------------------------------------------
    --//THROTTLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonThrottle                      = "Options de regroupements",
    --General
        descriptionThrottle                 = "Regroupe plusieurs coups en un; utilisez le curseur pour ajuster le délai en millisecondes. Les critiques ne sont jamais regroupés",
        showThrottleTrailer                 = "Activer le regroupement",
    --Tooltips
        tooltipThrottleDamage               = "Définit le délai du regroupement des dégâts",
        tooltipThrottleHealing              = "Définit le délai du regroupement des soins instantanés",
        tooltipThrottleDot                  = "Définit le délai du regroupement des 'dégâts sur la durée'",
        tooltipThrottleHot                  = "Définit le délai du regroupement des 'soins sur la durée'",
        tooltipThrottleTrailer              = "Affiche plusieurs coups non critique en un",
        tooltipThrottleCritical             = "Permettre d'étranglement pour coups critiques",
}