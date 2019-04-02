--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- LUIE namespace
LUIE             = {}
LUIE.name        = "LuiExtended"
LUIE.author      = "ArtOfShred, psypanda & SpellBuilder"
LUIE.version     = "5.8.1"
LUIE.website     = "http://www.esoui.com/downloads/info818-LuiExtended.html"
LUIE.github      = "https://github.com/ArtOfShred/LuiExtended"

-- Saved variables options
LUIE.SV          = nil
LUIE.SVVer       = 2
LUIE.SVName      = "LUIESV"

-- Default Settings
LUIE.D = {
    CharacterSpecificSV         = false,
    StartupInfo                 = false,
    HideXPBar                   = false,
    TempAlertHome               = false,
    TempAlertCampaign           = false,
    TempAlertOutfit             = false,
    WelcomeVersion              = 0,

    -- Modules
    UnitFrames_Enabled          = true,
    InfoPanel_Enabled           = true,
    CombatInfo_Enabled          = true,
    CombatText_Enabled          = true,
    SpellCastBuff_Enable        = true,
    ChatAnnouncements_Enable    = true,
    SlashCommands_Enable        = true,
}

-- Global fonts table to use in other parts of this addon
LUIE.Fonts = {
    ["ProseAntique"]            = ZoFontBookPaper:GetFontInfo(),
    ["Consolas"]                = "/EsoUI/Common/Fonts/consola.ttf",
    ["Futura Condensed"]        = "/EsoUI/Common/Fonts/FTN57.otf",
    ["Futura Condensed Bold"]   = "/EsoUI/Common/Fonts/FTN87.otf",
    ["Futura Condensed Light"]  = "/EsoUI/Common/Fonts/FTN47.otf",
    ["Skyrim Handwritten"]      = ZoFontBookLetter:GetFontInfo(),
    ["Trajan Pro"]              = ZoFontBookTablet:GetFontInfo(),
    ["Univers 55"]              = "/EsoUI/Common/Fonts/univers55.otf",
    ["Univers 57"]              = ZoFontGame:GetFontInfo(),
    ["Univers 67"]              = ZoFontWinH1:GetFontInfo(),
    ["Fontin Bold"]             = "/LuiExtended/media/fonts/Fontin/fontin_sans_b.otf",
    ["Fontin Italic"]           = "/LuiExtended/media/fonts/Fontin/fontin_sans_i.otf",
    ["Fontin Regular"]          = "/LuiExtended/media/fonts/Fontin/fontin_sans_r.otf",
    ["Fontin SmallCaps"]        = "/LuiExtended/media/fonts/Fontin/fontin_sans_sc.otf",
    ["Trajan Pro Bold"]         = "/LuiExtended/media/fonts/TrajanPro/TrajanProBold.otf",
    ["EnigmaReg"]               = "/LuiExtended/media/fonts/Enigma/EnigmaReg.ttf",
    ["EnigmaBold"]              = "/LuiExtended/media/fonts/Enigma/EnigmaBold.ttf",
    ["Adventure"]               = "/LuiExtended/media/fonts/Adventure/adventure.ttf",
    ["Bazooka"]                 = "/LuiExtended/media/fonts/Bazooka/bazooka.ttf",
    ["Cooline"]                 = "/LuiExtended/media/fonts/Cooline/cooline.ttf",
    ["Diogenes"]                = "/LuiExtended/media/fonts/Diogenes/diogenes.ttf",
    ["Ginko"]                   = "/LuiExtended/media/fonts/Ginko/ginko.ttf",
    ["Heroic"]                  = "/LuiExtended/media/fonts/Heroic/heroic.ttf",
    ["Metamorphous"]            = "/LuiExtended/media/fonts/Metamorphous/metamorphous.otf",
    ["Porky"]                   = "/LuiExtended/media/fonts/Porky/porky.ttf",
    ["Roboto Bold"]             = "/LuiExtended/media/fonts/Roboto/Roboto-Bold.ttf",
    ["Roboto Bold Italic"]      = "/LuiExtended/media/fonts/Roboto/Roboto-BoldItalic.ttf",
    ["Talisman"]                = "/LuiExtended/media/fonts/Talisman/talisman.ttf",
    ["Transformers"]            = "/LuiExtended/media/fonts/Transformers/transformers.ttf",
    ["Yellowjacket"]            = "/LuiExtended/media/fonts/Yellowjacket/yellowjacket.ttf",
    ["ProFontWindows"]          = "/LuiExtended/media/fonts/ProFontWindows/ProFontWindows.ttf",
}

LUIE.Sounds = {
    ["Death Recap Killing Blow"]  = SOUNDS.DEATH_RECAP_KILLING_BLOW_SHOWN,
}

LUIE.StatusbarTextures = {
    ["Aluminium"]               = "/LuiExtended/media/unitframes/textures/Aluminium.dds",
    ["Elder Scrolls Gradient"]  = "/LuiExtended/media/unitframes/textures/ElderScrollsGrad.dds",
    ["Glass"]                   = "/LuiExtended/media/unitframes/textures/Glass.dds",
    ["Glaze"]                   = "/LuiExtended/media/unitframes/textures/Glaze.dds",
    ["Horizontal Gradient 1"]   = "/LuiExtended/media/unitframes/textures/HorizontalGrad.dds",
    ["Horizontal Gradient 2"]   = "/LuiExtended/media/unitframes/textures/HorizontalGradV2.dds",
    ["Inner Glow"]              = "/LuiExtended/media/unitframes/textures/InnerGlow.dds",
    ["Inner Shadow"]            = "/LuiExtended/media/unitframes/textures/InnerShadow.dds",
    ["Inner Shadow Glossy"]     = "/LuiExtended/media/unitframes/textures/InnerShadowGloss.dds",
    ["Minimalistic"]            = "/LuiExtended/media/unitframes/textures/Minimalistic.dds",
    ["Round"]                   = "/LuiExtended/media/unitframes/textures/Round.dds",
    ["Sand Paper 1"]            = "/LuiExtended/media/unitframes/textures/SandPaper.dds",
    ["Sand Paper 2"]            = "/LuiExtended/media/unitframes/textures/SandPaperV2.dds",
    ["Shadow"]                  = "/LuiExtended/media/unitframes/textures/Shadow.dds",
    ["Smooth"]                  = "/LuiExtended/media/unitframes/textures/Smooth.dds",
    ["Plain"]                   = "/LuiExtended/media/unitframes/textures/Plain.dds",
}
