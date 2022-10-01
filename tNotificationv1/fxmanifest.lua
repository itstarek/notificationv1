fx_version 'adamant'
game 'gta5'
----------------------
author 'Tarek'
description 'This Script Is Created For AtlantisRP'
version '1.0'
----------------------
client_scripts {
    'config.lua',
    'bulletin.lua'
}
--------------------------
ui_page 'ui/ui.html'
--------------------------
files {
    'ui/ui.html',
    'ui/images/*/*.gif',
    'ui/images/*/*.png',
    'ui/images/*',
    'ui/icons/*',
    'ui/audio/*.ogg',
    'ui/audio/*.mp3',
    'ui/audio/*.wav',
    'ui/fonts/*.ttf',
    'ui/css/*.css',
    'ui/js/*.js'
}
--------------------------
exports {
    'Send',
    'SendAdvanced',
    'SendSuccess',
    'SendInfo',
    'SendWarning',
    'SendError',
    'SendPinned',
    'Unpin'
}
--------------------------