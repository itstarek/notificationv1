Config = {}

Config.Timeout          = 7500          -- Overridden by the `timeout` param
Config.Position         = GetResourceKvpString("notif_position") or "bottomleft"
Config.Progress         = true          -- Overridden by the `progress` param
Config.Theme            = "default"     -- Overridden by the `theme` param
Config.Queue            = 5             -- No. of notifications to show before queueing
Config.Stacking         = true
Config.ShowStackedCount = true
Config.AnimationIn      = "fadeIn";     -- Enter animation - 'fadeOut', 'fadeOutLeft', 'flipOutX', 'flipOutY', 'bounceOutLeft', 'backOutLeft', 'slideOutLeft', 'zoomOut', 'zoomOutLeft'
Config.AnimationOut     = "fadeOut";    -- Exit animation - 'fadeOut', 'fadeOutLeft', 'flipOutX', 'flipOutY', 'bounceOutLeft', 'backOutLeft', 'slideOutLeft', 'zoomOut', 'zoomOutLeft'
Config.AnimationTime    = 350           -- Entry / exit animation interval
Config.SoundFile        = false --'son.mp3'         -- Sound file stored in ui/audio used for notification sound. Leave as false to disable.
Config.SoundVolume      = 0.1           -- 0.0 - 1.0

Config.Sound = {
    info = 'son.mp3',
    error = 'son.mp3',
    check = 'son.mp3',
    alynia = 'son.mp3',
    message = 'son.mp3',
}

Config.Icons = {
    info = "message.png",
    error = "message.png",
    check = "message.png",
    alynia = "message.png",
    message = "message.png",
}

Config.Pictures = {
    CHAR_ANO  = "CHAR_ANO.png",
    CHAR_TWITTER = "CHAR_TWITTER.png",
    CHAR_BAHAMAS = "CHAR_BAHAMA.png",
    CHAR_CONCESSIONNAIRE = "CHAR_CONCESSIONNAIRE.png",
    CHAR_EMS = "CHAR_EMS.png",
    CHAR_GALAXY = "CHAR_GALAXY.png",
    CHAR_IMMO = "CHAR_IMMO.png",
    CHAR_LSCUSTOM = "CHAR_LSCUSTOM.png",
    CHAR_MECANO = "CHAR_MECANO.png",
    CHAR_TABAC = "CHAR_TABAC.png",
    CHAR_TAXI = "CHAR_TAXI.png",
    CHAR_TEQUILALA = "CHAR_TEQUILALA.png",
    CHAR_UNICORN = "CHAR_UNICORN.png",
    CHAR_VIGNERONS = "CHAR_VIGNERONS.png",
}