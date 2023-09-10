Nuked = false 
Wrong_Door = false
List_Gems = {}

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
        sendPacket(3,"action|join_request\nname|"..world:upper().."\ninvitedWorld|0")
        sleep(5000)
        if aseli == 5 then
            Nuked = true 
        else
            if getBot().world ~= world:upper() then
                aseli = aseli + 1
            end
        end
    end
    if id ~= nil and not Wrong_Door then
        while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 and not Wrong_Door do
            sendPacket(3,"action|join_request\nname|"..world:upper().."|"..id:upper().."\ninvitedWorld|0")
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

function Drop(pack,world,x,y)
    local function cek()
        for _,item in pairs(CONFIG.Pack.List) do
            if findItem(item) > 0 then
                return true
            end
        end
        return false 
    end

    if cek() then
        collectSet(false)
        sleep(50)
        goPos(CONFIG.Storage.Pos_Drop)
        sleep(200)
        while findItem(112) >= CONFIG.Pack.Price do
            sendPacket(2,"action|buy\nitem|"..pack)
            sleep((CONFIG.Delay.BuyPack or 2500))
        end
        for i = 1,#CONFIG.Pack.List do
            if findItem(CONFIG.Pack.List[i]) > 0 then
                while findItem(CONFIG.Pack.List[i]) > 0 do
                    drop(CONFIG.Pack.List[i])
                    sleep((CONFIG.Delay.Drop or 1500))
                    if findItem(CONFIG.Pack.List[i]) > 0 then
                        move(-1,0)
                        sleep((CONFIG.Delay.Move or 1500))
                    end
                end
            end
        end     
        warp(world,CONFIG.Door_Farm)
        local aX = math.floor(getBot().x / 32)
        local aY = math.floor(getBot().y / 32)
        collectSet(true,(CONFIG.Range_Collect or 3))
        sleep(50)
        for i = 1,5 do
            if (math.floor(getBot().x / 32) ~= x and math.floor(getBot().y / 32) ~= y) and 
                (math.floor(getBot().x / 32) == aX and math.floor(getBot().y / 32) == aY) then
                findPath(x,y)
                sleep(500)
            else
                break
            end
        end
    end
end

function cekGems()
    for index,obj in pairs(getObjects()) do
        if obj.id == 112 then
            if getTile(math.floor(obj.x / 32),math.floor(obj.y / 32)).flags == 0 then
                table.insert(
                    List_Gems,
                    {
                        x = math.floor(obj.x / 32),
                        y = math.floor(obj.y / 32)
                    }
                )                
            end
        end
    end
end

say("`cSCRIPT MADE By `4Madang.EXE#6264")
sleep(1000)
for index,world in pairs(CONFIG.Farm_List) do
    List_Gems = {}
    warp(world,CONFIG.Door_Farm)
    if not Nuked then
        if not Wrong_Door then
            if scanfloat(112) >= CONFIG.Minimum_Gems then
                cekGems()
                collectSet(true,(CONFIG.Range_Collect or 3))
                sleep(100)
                for index,tile in pairs(List_Gems) do
                    if getTile(tile.x,tile.y).flags == 0 then
                        findPath(tile.x,tile.y)
                        sleep(CONFIG.Delay.FindPath)
                        local aX = math.floor(getBot().x / 32)
                        local aY = math.floor(getBot().y / 32)
                        Drop(CONFIG.Pack.Debug,world,aX,aY)
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
end
