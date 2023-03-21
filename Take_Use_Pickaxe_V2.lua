--[ MAIN CODE ]--
local letter = 6
local char_set  = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
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

local total = 0
webfucki("@everyone `SCRIPT TAKE & USE PICKAXE MADE By` <@895235665980194816>")
for i = 1,#botList do
    addBot(botList[i],password)
    sleep(5000)
    setBool("Auto Reconnect",false)
    while getBot().status == "offline" or getBot().status == "login fail" do
        connect()
        sleep(5000)
    end
    if getBot().status == "online" then
        if findItem(98) ~= 0 and not findClothes(98) then
            joinK(acakbang(letter,char_set))
            sleep(1000)
            while not findClothes(98) do
                wear(98)
                sleep(1000)
            end
            if findClothes(98) then
                webfucki("`"..getBot().name:upper().." DONE USE PICKAXE`")
                sleep(500)
                total = total + 1
                removeBot(getBot().name)
            end
        elseif findItem(98) ~= 0 and findClothes(98) then
            if findClothes(98) then
                joinK(acakbang(letter,char_set))
                sleep(1000)
                webfucki("`"..getBot().name:upper().." ALREADY USING PICKAXE`")
                sleep(500)
                total = total + 1
                removeBot(getBot().name)
            end
        elseif findItem(98) == 0 then 
            join(worldPX,doorPX)
            sleep(1000)
            if scanFloat(98) > 0 then
                goFloat(98)
                sleep(1000)
                if findItem(98) >= 1 then
                    collectSet(false,3)
                    while findItem(98) ~= 1 do
                        move(-1,0)
                        sleep(1000)
                        drop(98,(findItem(98)-1))
                        sleep(500)
                    end
                    while not findClothes(98) do
                        wear(98)
                        sleep(900)
                    end
                    if findClothes(98) then
                        joinK(acakbang(letter,char_set))
                        sleep(1000)
                        webfucki("`"..getBot().name:upper().." DONE USE PICKAXE`")
                        sleep(500)            
                        removeBot(getBot().name)
                        total = total + 1
                    end
                end
            elseif scanFloat(98) == 0 then
                webfucki("PICKAXE SUDAH HABIS")
                removeBot(getBot().name)
            end
        end
    end
end
webfucki("`TOTAL BOT USING PICKAXE : `"..total)
