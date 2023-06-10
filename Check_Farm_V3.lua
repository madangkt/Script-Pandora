--[ M A D S | Check Farm ]--
local function scanTree(itemid)
    local count = 0
    for _, tile in pairs(getTiles()) do
        if tile.fg == itemid and tile.ready then
            count = count + 1
        end
    end
    return count
end

local function scanUnready(itemid)
    local count = 0
    for _, tile in pairs(getTiles()) do
        if tile.fg == itemid and not tile.ready then
            count = count + 1
        end
    end
    return count
end

local function scanFossil()
    local count = 0
    for _, tile in pairs(getTiles()) do
        if tile.fg == 3918 or tile.bg == 3918 then
            count = count + 1
        end
    end
    return count
end

function webfucki(status)
    local mads = [[
        $webHookUrl = "]]..webfuck..[["
        $content = "]]..status..[["
        $payload = @{
            content = $content
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
    ]]
    local pipe = io.popen("powershell -command -", "w")
    pipe:write(mads)
    pipe:close()
end

local total = 0
local NUKED = false --[ DON'T CHANGE!!! ]--

addHook("onvariant","nuked",function(var)
    if var[0] == "OnConsoleMessage" then
        if string.find(var[1],"inaccessible") then
            NUKED = true
        end
    end
end)

for i = 1, #farmList do
    while getBot().world ~= farmList[i]:upper() and not NUKED do
        sendPacket("action|join_request\nname|"..farmList[i].."\ninvitedWorld|0",3)
        sleep(6000)
        if NUKED then
            NUKED = false
            total = total + 1
            break
        end
    end
    if getBot().world == farmList[i]:upper() and not NUKED then
        webfucki("`"..farmList[i]:upper().." | "..scanTree(tree).." READY | "..scanUnready(tree).." UN-READY | "..scanFossil().." FOSSIL`")
        sleep(1000)
    elseif getBot().world ~= farmList[i]:upper() and NUKED then
        webfucki("`"..farmList[i]:upper().." | NUKED`")
        sleep(1000)
        NUKED = false
    end
end
webfucki("`TOTAL NUKED : "..total.." WORLD`")
removeBot(getBot().name)
