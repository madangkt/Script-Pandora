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
    local wh = {}
    wh.url = webfuck
    wh.username = "M A D S | Check Farm"
    wh.content = status
    webhook(wh)
end

local foundNukedFarm = false --[ DON'T CHANGE!!! ]--

local total = 0
local hah = 0
local NUKED = false --[ DON'T CHANGE!!! ]--
webfucki("@everyone `SCRIPT CHECK FARM MADE By : `<@895235665980194816>")
for i = 1, #farmList do
    while getBot().world ~= farmList[i]:upper() and not NUKED do
        sendPacket(3, "action|join_request\nname|"..farmList[i].."\ninvitedWorld|0")
        sleep(6000)
        if hah == 5 then
            NUKED = true
            total = total + 1
            hah = 0
            break
        else
            hah = hah + 1
        end
    end
    if getBot().world == farmList[i]:upper() and not NUKED then
        webfucki("`"..farmList[i]:upper().." | "..scanTree(tree).." READY | "..scanUnready(tree).." UN-READY | "..scanFossil().." FOSSIL`")
        sleep(1000)
        hah = 0
    elseif getBot().world ~= farmList[i]:upper() and NUKED then
        webfucki("`"..farmList[i]:upper().." | NUKED`")
        sleep(1000)
        NUKED = false
        hah = 0
        foundNukedFarm = true
    end
end
webfucki("`TOTAL NUKED : "..total.." WORLD`")
removeBot(getBot().name)
