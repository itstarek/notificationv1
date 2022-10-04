Notification Tarek V1.

<h1>Cher tout le monde voici mon système de Notification V1</h1>
<p><span>Faut pas oublier de retirer le subtitle sinon vous allez avoir une petite bug</span></p>

<h1> Oubliez pas de remplacez ses ligne dans votre es_extended/Framework client>function.lua</h1>

<span style="color=#3bbdff">function ESX.ShowNotification(msg, hudColorIndex)
    AddTextEntry('esxNotification', msg)
    BeginTextCommandThefeedPost('esxNotification')
    if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
    EndTextCommandThefeedPostTicker(false, true)
end

function ESX.ShowAdvancedNotification(title, subject, msg, icon, iconType, hudColorIndex)
    AddTextEntry('esxAdvancedNotification', msg)
    BeginTextCommandThefeedPost('esxAdvancedNotification')
    if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
    EndTextCommandThefeedPostMessagetext(icon, icon, false, iconType, title, subject)
    EndTextCommandThefeedPostTicker(false, false)
end

function ESX.ShowHelpNotification(msg)
    AddTextEntry('esxHelpNotification', msg)
    BeginTextCommandDisplayHelp('esxHelpNotification')
    EndTextCommandDisplayHelp(0, false, true, -1)
end</span>

<h1>Par se code la.</h1>

<span style="color=#3bbdff">function ESX.ShowNotification(msg, flash, saveToBrief, hudColorIndex, title, subject, icon)
    if title == nil then title = "NOTIFICATION" end
    if subject == nil then subject = "" end
    if icon == nil then icon = "notification" end

    exports.tNotification:Send(msg, nil, nil, true, nil, title, subject, icon)
end 
function ESX.ShowAdvancedNotification(title, subject, msg, banner, timeout, icon)
    if title == nil then title = "NOTIFICATION" end
    if subject == nil then subject = "" end
    if icon == nil then icon = "notification" end

    exports.tNotification:SendAdvanced(msg, subject, title, banner, nil, nil, true, nil, icon)
end

function ESX.ShowHelpNotification(msg)
    AddTextEntry('esxHelpNotification', msg)
    BeginTextCommandDisplayHelp('esxHelpNotification')
    EndTextCommandDisplayHelp(0, false, true, -1)
end</span>

Pour changer l'icône de la notification, allez dans bulletin/ui/icons et vous allez trouver message.png. Remplacez-le par le logo de votre serveur.


<span>Si besoin d'aide venez sur notre </span><a href="https://discord.gg/NzwhVmS9ss">DISCORD SUPPORT</a>
