--[ MAIN CODE ]--
local letter = 7
local char_set  = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"

function webfucki(status)
    local wh = {}
    wh.url = webfuck
    wh.username = "M A D S | Take Clothes"
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

function acakbang(banyak_huruf, karakter_yg_mau_di_acak)
    local hasil = {}
    for i = 1,banyak_huruf do
        local index = math.random(#karakter_yg_mau_di_acak)
        hasil[i] = karakter_yg_mau_di_acak:sub(index , index)
    end
    return table.concat(hasil)
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
    while getBot().world ~= world:upper() do
        sendPacket(3,"action|join_request\nname|"..world:upper().."\ninvitedWorld|0")
        sleep(5000)
    end
    if id ~= "" then
        while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 do
            sendPacket(3,"action|join_request\nname|"..world:upper().."|"..id:upper().."\ninvitedWorld|0")
            sleep(1000)
         end
    end
end

function joinK(world)
    while getBot().world ~= world:upper() do
        sendPacket(3,"action|join_request\nname|"..world:upper().."\ninvitedWorld|0")
        sleep(5000)
    end
end

local totalTake = 0
local totalUse = 0

webfucki("@everyone `SCRIPT TAKE & USE CLOTHES MADE By` <@895235665980194816>")

for i = 1,#botList do
    addBot(botList[i],password)
    sleep(5000)
    setBool("Auto Reconnect",false)
    while getBot().status == "offline" or getBot().status == "login fail" do
        connect()
        sleep(delayReconnect)
    end
    if getBot().status == "banned" then 
        webfucki("`"..getBot().name:upper().." BANNED`")
        removeBot(getBot().name)
    elseif getBot().status == "suspended" then
        webfucki("`"..getBot().name:upper().." SUSPENDED`")
        removeBot(getBot().name)
    elseif getBot().status == "invalid email" then
        webfucki("`"..getBot().name:upper().." INVALID EMAIL`")
        removeBot(getBot().name)
    elseif getBot().status == "aap detected" then
        webfucki("`"..getBot().name:upper().." AAP DETECTED`")
        removeBot(getBot().name)
    elseif getBot().status == "online" then
        while getBot().world ~= worldTake:upper() do
            join(worldTake,doorTake)
            sleep(500)
        end
        if findItem(clothes) > 0 and not findClothes(clothes) then
            while not findClothes(clothes) do
                wear(clothes)
                sleep(1000)
            end
            if findClothes(clothes) and findItem(clothes) > 1 then
                collectSet(false,3)
                sleep(500)
                while findItem(clothes) ~= 1 do
                    drop(clothes,(findItem(clothes)-1))
                    sleep(1000)
                end
                joinK(acakbang(letter,char_set))
                sleep(1000)
                webfucki("`"..getBot().name:upper().." DONE USE CLOTHES`")
                totalTake = totalTake + 1
                removeBot(getBot().name)
                sleep(500)
            elseif findClothes(clothes) and findItem(clothes) == 1 then
                joinK(acakbang(letter,char_set))
                sleep(1000)
                webfucki("`"..getBot().name:upper().." DONE USE CLOTHES`")
                totalTake = totalTake + 1
                removeBot(getBot().name)
                sleep(500)
            end
        elseif findItem(clothes) > 0 and findClothes(clothes) then
            joinK(acakbang(letter,char_set))
            sleep(1000)
            webfucki("`"..getBot().name:upper().." ALREADY USING CLOTHES`")
            totalUse = totalUse + 1
            removeBot(getBot().name)
        elseif findItem(clothes) == 0 and not findClothes(clothes) then
            if scanFloat(clothes) > 0 then
                goFloat(clothes)
                sleep(500)
                if findItem(clothes) > 1 then
                    collectSet(false,3)
                    sleep(1000)
                    while findItem(clothes) ~= 1 do
                        move(-1,0)
                        sleep(1000)
                        drop(clothes,(findItem(clothes)-1))
                        sleep(900)
                    end
                    while not findClothes(clothes) do
                        wear(clothes)
                        sleep(1000)
                    end
                    if findClothes(clothes) then
                        joinK(acakbang(letter,char_set))
                        sleep(500)
                        webfucki("`"..getBot().name:upper().." DONE USE CLOTHES`")
                        totalTake = totalTake + 1
                        removeBot(getBot().name)
                        sleep(500)
                    end
                elseif findItem(clothes) == 1 and not findClothes(clothes) then
                    joinK(acakbang(letter,char_set))
                    sleep(1000)
                    while not findClothes(clothes) do
                        wear(clothes)
                        sleep(1000)
                    end
                    if findClothes(clothes) then
                        webfucki("`"..getBot().name:upper().." DONE USE CLOTHES`")
                        totalTake = totalTake + 1
                        sleep(500)
                        removeBot(getBot().name)
                    end
                end
            elseif scanFloat(clothes) == 0 then
                webfucki("`"..getBot().name:upper().." NO CLOTHES AT : "..getBot().world:upper().."`")
                removeBot(getBot().name)
            end
        end
    end
end
webfucki(totalTake.." BOT TAKE & USE CLOTHES")
webfucki(totalUse.." BOT ALREADY USE CLOTHES")
