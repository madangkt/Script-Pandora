Nuked = false 
Wrong_Door = false

function scanfloat(id)
    local count = 0
    for _, obj in pairs(getObjects()) do
        if obj.id == id then
            count = count + obj.count
        end
    end
    return count
end

function goPos(pos) 
    for _, tile in pairs(getTiles()) do
        if tile.fg == pos or tile.bg == pos then
            findPath(tile.x - 1,tile.y)
            sleep(700)
        end
    end
end

function warp(world,id)
    local aseli = 0
    local aselole = 0
    while getBot().world ~= world:upper() and not Nuked do
        sendPacket("action|join_request\nname|"..world:upper().."\ninvitedWorld|0",3)
        sleep(5000)
        if aseli == 5 then
            Nuked = true 
        else
            if getBot().world ~= world:upper() then
                aseli = aseli + 1
            end
        end
    end
    if id ~= "" and not Wrong_Door then
        while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 and not Wrong_Door do
            sendPacket("action|join_request\nname|"..world:upper().."|"..id:upper().."\ninvitedWorld|0",3)
            sleep(1000)
            if aselole == 5 then
                Wrong_Door = true 
            else
                if getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 then
                    aselole = aselole + 1
                end
            end
        end
    end
end

function Drop(pack)
    collectSet(false)
    sleep(50)
    goPos(CONFIG.Storage.Pos_Drop)
    sleep(200)
    while findItem(112) >= CONFIG.Pack.Price do
        sendPacket("action|buy\nitem|"..pack,2)
        sleep(CONFIG.Delay.BuyPack)
    end
    for i = 1,#CONFIG.Pack.List do
        if findItem(CONFIG.Pack.List[i]) > 0 then
            local waduh = 0 
            while findItem(CONFIG.Pack.List[i]) > 0 do
                drop(CONFIG.Pack.List[i])
                sleep(CONFIG.Delay.Drop)
                if waduh == 5 then
                    move(-1,0)
                    sleep(CONFIG.Delay.Move)
                    waduh = 0
                else
                    if findItem(CONFIG.Pack.List[i]) > 0 then
                        waduh = waduh + 1
                    end
                end
            end
        end
    end
end

say("`cSCRIPT MADE By `4Madang.EXE#6264")
sleep(1000)
for index,world in pairs(CONFIG.Farm_List) do
    ::join::
    warp(world,CONFIG.Door_Farm)
    if not Nuked then
        if not Wrong_Door then
            if scanfloat(112) >= CONFIG.Minimum_Gems then
                collectSet(true,CONFIG.Range_Collect)
                sleep(100)
                for _,obj in pairs(getObjects()) do
                    if obj.id == 112 then
                        if scanfloat(112) >= CONFIG.Minimum_Gems then
                            if getTile(math.floor(obj.x / 32),math.floor(obj.y / 32)).flags == 0 then
                                if findItem(112) >= CONFIG.Pack.Trigger and CONFIG.Pack.Buy then
                                    warp(CONFIG.Storage.Name,CONFIG.Storage.Door)
                                    Drop(CONFIG.Pack.Debug)
                                    sleep(100)
                                    goto join
                                end
                                findPath(math.floor(obj.x / 32),math.floor(obj.y / 32))
                                sleep(CONFIG.Delay.FindPath)
                            end
                        end
                    end
                end
            end
        else
            print(world:upper()..' Have Wrong Door id!') 
            Wrong_Door = false
        end
    else
        print(world:upper()..' Has Been Nuked!')
        Nuked = false
    end
end

if findItem(112) >= CONFIG.Pack.Price and CONFIG.Pack.Buy then
    warp(CONFIG.Storage.Name,CONFIG.Storage.Door)
    Drop(CONFIG.Pack.Debug)
    sleep(100)
end
if CONFIG.Remove_Bot then
    removeBot(getBot().name)
    error()
end

