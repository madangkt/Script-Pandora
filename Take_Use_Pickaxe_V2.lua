--[ MAIN CODE ]--
function webfucki(status)
    local wh = {}
    wh.url = webfuck
    wh.username = "M A D S | Take Pickaxe"
    wh.content = status
    webhook(wh)
end

function scanFloat(itemid)
    local count = 0
    for _, obj in pairs(getObjects()) do
        if obj.id == itemid then
            count = count + obj.count
        end
    end
    return count
end

function goFloat(id)
    for _, obj in pairs(getObjects()) do
        if obj.id == id then
            collectSet(true,3)           
            if (getTile(math.floor((obj.x+10)/32),math.floor((obj.y+10)/32)).flags == 0 or 
                getTile(math.floor((obj.x+10)/32),math.floor((obj.y+10)/32)).flags == 2) then
                findPath(math.floor((obj.x+10)/32),math.floor((obj.y+10)/32))
                sleep(1000)
                return true
            end
        end
    end
  return false
end

function join(world,id)
    sendPacket(3,"action|join_request\nname|"..world:upper().."\ninvitedWorld|0")
    sleep(5000)
    while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 do
        sendPacket(3,"action|join_request\nname|"..world:upper().."|"..id:upper().."\ninvitedWorld|0")
        sleep(1000)
    end
end

for i = 1,#botList do
    addBot(botList[i],password)
    sleep(5000)
    while getBot().status == "offline" or getBot().status == "login fail" do
    connect()
    sleep(15000)
    end
    if getBot().status == "online" then
        if findItem(98) > 0 and not findClothes(98) then
            join(worldPX,doorPX)
            sleep(1000)
            if not findClothes(98) then
                while not findClothes(98) do
                    wear(98)
                    sleep(1000)
                end
            end
            if findClothes(98) then
                webfucki("`"..getBot().name:upper().." DONE USE PICKAXE`")
                sleep(500)
                removeBot(getBot().name)
            end
        elseif findItem(98) > 0 and findClothes(98) then
            webfucki("`"..getBot().name:upper().." ALREADY USING PICKAXE`")
            sleep(500)
            removeBot(getBot().name)
        elseif findItem(98) == 0 then 
            join(worldPX,doorPX)
            sleep(1000)
            if scanFloat(98) > 0 then
                goFloat(98)
                sleep(1000)
                if findItem(98) ~= 1 then
                    collectSet(false,3)
                    while findItem(98) ~= 1 do
                        drop(98,(findItem(98)-1))
                        sleep(1000)
                    end
                    while not findClothes(98) do
                        wear(98)
                        sleep(900)
                    end
                    if findClothes(98) then
                        webfucki("`"..getBot().name:upper().." DONE USE PICKAXE`")
                        sleep(500)
                        removeBot(getBot().name)
                    end
                end
            end
        end
    end
end
