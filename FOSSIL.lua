--[ WOI HITAM ]--
farmList     = Bot[getBot().name:upper()].farmList
doorFarm     = Bot[getBot().name:upper()].doorFarm
webfuck      = Bot[getBot().name:upper()].webfuck
maxFossilBP  = Bot[getBot().name:upper()].maxFossilBP
maxBrushBP   = Bot[getBot().name:upper()].maxBrushBP
maxRockBP    = Bot[getBot().name:upper()].maxRockBP

--[ KETIBAN FUCKTA ]-- 
local hammer = 3932 --[ DON'T CHANGE! ]--
local chisel = 3934 --[ DON'T CHANGE! ]--
local rock   = 10   --[ DON'T CHANGE! ]--
local brush  = 4132 --[ DON'T CHANGE! ]--
local poli   = 4134 --[ DON'T CHANGE! ]--

local function webfucki(status)
    local wh = {}
    wh.url = webfuck
    wh.username = "M A D S | TAKE FOSSIL"
    wh.content = status
    webhook(wh)
end

local gebuk = true

local function hoek(v) 
    if v[0] == "OnTalkBubble" and v[2]:find("I unearthed a Fossil") then 
        gebuk = false 
        sleep(1000)
    end 
end 

addHook("w",hoek)

local function join(world,id)
    sendPacket(3,"action|join_request\nname|"..world:upper().."\ninvitedWorld|0")
    sleep(5000)
    while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 do
        sendPacket(3,"action|join_request\nname|"..world:upper().."|"..id:upper().."\ninvitedWorld|0")
        sleep(1000)
    end
end

local function goPos(pos) 
    for _, tile in pairs(getTiles()) do
        if tile.fg == pos or tile.bg == pos then
            findPath(tile.x - 1,tile.y)
            sleep(700)
        end
    end
end

local function scanFloat(itemid)
    local count = 0
    for _, obj in pairs(getObjects()) do
        if obj.id == itemid then
            count = count + obj.count
        end
    end
    return count
end

local function scanFossil()
    local count = 0
    for _, tile in pairs(getTiles()) do
        if tile.fg == 3918 then
            count = count + 1
        end
    end
    return count
end


local function dropeh(world,id,itemid)
    join(world,id)
    sleep(1000)
    goPos(posFossil)
    sleep(1000)
    collectSet(false,3)
    sleep(500)
    while findItem(itemid) ~= 0 do
        drop(itemid)
        sleep(1000)
        move(-1,0)
        sleep(800)
    end
end

local function dropAll()
    collectSet(false,3)
    sleep(500)
    if findItem(hammer) ~= 0 or findItem(chisel) ~= 0 then
        goPos(posTool)
        sleep(800)
        while findItem(hammer) ~= 0 do
            drop(hammer)
            sleep(500)
        end
        while findItem(chisel) ~= 0 do 
            drop(chisel)
            sleep(800)
        end
    end
    if findItem(brush) ~= 0 then
        goPos(posBrush)
        sleep(800)
        while findItem(brush) ~= 0 do
            drop(brush)
            sleep(900)
        end
    end
    if findItem(rock) ~= 0 then
        goPos(posRock) 
        sleep(900)
        while findItem(rock) ~= 0 do
            drop(rock)
            sleep(900)
        end
    end
    if findItem(poli) ~= 0 then
        goPos(posPoli) 
        sleep(900)
        while findItem(poli) ~= 0 do
            drop(poli)
            sleep(900)
        end
    end
end

local function takeBanh(world,id)
    join(world,id)
    sleep(1000)
    if findItem(hammer) == 0 or findItem(chisel) == 0 then
        collectSet(true,3)
        goPos(posTool)
        sleep(800)
        if findItem(hammer) ~= 1 then
            collectSet(false,3)
            sleep(500)
            drop(hammer,(findItem(hammer)-1))
            sleep(800)
        end
        if findItem(chisel) ~= 1 then
            collectSet(false,3)
            sleep(500)
            drop(chisel,(findItem(chisel)-1))
            sleep(800)
        end
    end
    ::jiak::
    sleep(1000)
    if scanFloat(brush) == 0 then
        webfucki(" @everyone NO FOSSIL BRUSH IN STORAGE. GO REMOVE YOUR BOT IF YOU NOT HAVE MORE BRUSH")
        repeat
            if scanFloat(brush) > 0 then
                goto jiak
            else
                webfucki("@everyone FROM **"..getBot().name:upper().."** SAY : COME HERE! ADD MORE BRUSH OR REMOVE ME")
                sleep(15000)
            end
        until scanFloat(brush) > 0
    elseif scanFloat ~= 0 then
        goPos(posBrush)
        sleep(800)
        collectSet(true,3)
        sleep(1000)
        if findItem(brush) > maxBrushBP then
            collectSet(false,3)
            drop(brush,(findItem(brush) - maxBrushBP))
            sleep(800)
        end
    end
    ::rok::
    sleep(1000)
    if scanFloat(rock) == 0 then
        webfucki("NO ROCK IN STORAGE. GO REMOVE YOUR BOT IF YOU NOT HAVE MORE ROCK!")
        repeat
            if scanFloat(rock) > 0 then
                goto rok
            else
                webfucki("@everyone FROM **"..getBot().name:upper().."** SAY : COME HERE! ADD MORE ROCK OR REMOVE ME")
                sleep(15000)
            end
        until scanFloat(rock) > 0
    elseif scanFloat(rock) > 0 then
        goPos(posRock)
        sleep(1000)
        collectSet(true,3)
        sleep(1000)
        if findItem(rock) > maxRockBP then
            collectSet(false,3)
            drop(rock,(findItem(rock) - maxRockBP))
            sleep(800)
        end
    end
    collectSet(false,3)
end

say("`cSCRIPT MADE BY `4Madang.EXE#6264")
sleep(1500)
local nFarms = 1
::etdah::
for nFarm = nFarms,#farmList do
    ::join::
    join(farmList[nFarm],doorFarm)
    sleep(1000)
    ::lagi::
    if scanFossil() == 0 then
        webfucki("||"..farmList[nFarm]:upper().."|| NO FOSSIL")
        sleep(500)
        if nFarms == #farmList then
        end
        nFarms = nFarms + 1
        goto etdah
    elseif scanFossil() > 0 then
        webfucki("||"..farmList[nFarm]:upper().."|| "..scanFossil().." FOSSIL LEFT")
        sleep(500)
        for _, tile in pairs(getTiles()) do 
            if tile.fg == 3918 then
                if findItem(hammer) == 0 or findItem(chisel) == 0 or findItem(brush) == 0 or findItem(rock) == 0 then
                    takeBanh(storageWorld,doorStorage)
                    sleep(1000)
                    goto join
                end
                findPath(tile.x,tile.y-1)
                sleep(800)
                if not findClothes(hammer) then
                    wear(hammer)
                    sleep(500)
                end
                while getTile(math.floor(getBot().x/32),math.floor(getBot().y/32)+1).fg == 3918 and gebuk do
                    for i = 1,10 do
                        punch(0,1)
                        sleep(5500)
                        if not gebuk then
                            break
                        end
                    end
                end
                wear(chisel)
                sleep(1000)
                while getTile(math.floor(getBot().x/32),math.floor(getBot().y/32)+1).fg == 3918 do
                    punch(0,1) 
                    sleep(180)
                end
                sleep(1000)
                place(brush,0,1)
                sleep(1500)
                collectSet(true,3)
                sleep(800)
                place(rock,0,1)
                sleep(2000)
                collectSet(false,3)
                gebuk = true
            end
        end
        if findItem(poli) >= maxFossilBP then
            dropeh(storageWorld,doorStorage,poli)
            sleep(1500)
            goto etdah
        else
            goto lagi
        end
    end
end
if findItem(hammer) ~= 0 or findItem(chisel) ~= 0 or findItem(brush) ~= 0 or findItem(poli) ~= 0 then
    join(storageWorld,doorStorage)
    dropAll()
    webfucki("**TOTAL FOSSIL AT STORAGE** "..scanFloat(poli))
    say("`cALL FOSSILS IN THE FARM HAVE BEEN TAKEN")
    sleep(1000)
    say("`4REMOVE BOT")
    removeBot(getBot().name)
end
