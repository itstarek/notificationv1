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
    info = "alert.png",
    error = "alert.png",
    check = "alert.png",
    alynia = "alert.png",
    message = "alert.png",
}

Config.Pictures = {
    -- SYSTEM 
        TAREK_ATLANTIS     =     "TAREK_ATLANTIS.PNG",
        TAREK_BOUTIQUE     =     "TAREK_BOUTIQUE.PNG",
        TAREK_ANO          =     "TAREK_ANO.PNG",
        TAREK_TWITTER      =     "TAREK_TWITTER.PNG",
        TAREK_STAFF        =     "TAREK_STAFF.png",
        TAREK_LUCKYWL      =     "TAREK_LUCKYWL.PNG",
    -- JOBS
        TAREK_VIGNERONS    =     "TAREK_VIGNERONS.PNG",
        TAREK_UNICORN      =     "TAREK_UNICORN.PNG",
        TAREK_WEAZELNEWS   =     "TAREK_WEAZELNEWS.PNG",
        TAREK_CARSHOP      =     "TAREK_CARSHOP.png",
        TAREK_LSCUSTOMS    =     "TAREK_LSCUSTOMS.png",
        TAREK_MECANO       =     "TAREK_MECANO.png",
        TAREK_TAXI         =     "TAREK_TAXI.png",
        TAREK_EMS          =     "TAREK_EMS.png",
        TAREK_LSPD         =     "TAREK_LSPD.png",
        TAREK_FBI          =     "TAREK_FBI.png",
        TAREK_LSSD         =     "TAREK_LSSD.png",
        TAREK_TECH         =     "TAREK_TECH.png",
        TAREK_REALSTATE    =     "TAREK_REALSTATE.PNG",
     }