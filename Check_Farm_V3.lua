Total_Nuked = 0
nuked = false


function warp(world)
    sendPacket("action|join_request\nname|"..world:upper().."\ninvitedWorld|0",3)
    sleep(5000)
end--

function log(text) 
    file = io.open("WORLD STATUS.txt", "a")
    file:write(text.."\n")
    file:close()
end

function Hoak(var)
    if var[0] == "OnConsoleMessage" then
        if var[1]:find("inaccessible") then
            nuked = true
        end
    end
end

addHook("onvariant","cekfarm",Hoak)

function scanFossil()
    local count = 0
    for index,fosil in pairs(getTiles()) do
        if fosil.fg == 3918 then
            count = count + 1
        end
    end
    return count
end

function scanReady(id)
    local count = 0
    for index,tile in pairs(getTiles()) do
        if tile.fg == id and tile.ready then
            count = count + 1
        end
    end
    return count
end

function infokan(description)
    local script = [[
        $webHookUrl = "]]..MADS.Webhook..[["
        $content = "]]..description..[["
        $payload = @{
            content = $content 
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
    ]]
    local pipe = io.popen("powershell -command -", "w")
    pipe:write(script)
    pipe:close()
end 


log("----------------------")
for i = 1,#MADS.FarmList do
    warp(MADS.FarmList[i])
    sleep(100)
    if not nuked then
        log(MADS.FarmList[i]:upper().." SAFE | "..scanReady(MADS.Tree).." Ready | "..scanFossil().." Fossil")
        infokan("`"..MADS.FarmList[i]:upper().." | "..scanReady(MADS.Tree).." Ready | "..scanFossil().." Fossil`")
        sleep(100)
    else
        log(MADS.FarmList[i]:upper().." | NUKED")
        infokan("`"..MADS.FarmList[i]:upper().." | NUKED`")
        sleep(100)
        nuked = false
        Total_Nuked = Total_Nuked + 1
    end
end
infokan("`Total Nuked "..Total_Nuked.." World`")
log("Total Nuked "..Total_Nuked.." World")


