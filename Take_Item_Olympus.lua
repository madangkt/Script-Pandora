dropx = CONFIG.Storage.Drop_X
dropy = CONFIG.Storage.Drop_Y
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

function Drop()
    collectSet(false)
    sleep(50)
    while math.floor(getBot().x / 32) ~= dropx and math.floor(getBot().y / 32) ~= dropy do
        if getTile(dropx,dropy).flags == 0 then
            findPath(dropx,dropy)
            sleep(500)
        else
            dropy = dropy - 1
        end
    end
    for i = 1,#CONFIG.Storage.List_Drop do
        if findItem(CONFIG.Storage.List_Drop[i]) > 0 then
            local waduh = 0
            while findItem(CONFIG.Storage.List_Drop[i]) > 0 do
                drop(CONFIG.Storage.List_Drop[i])
                sleep(CONFIG.Delay.Drop)
                if waduh == 5 then
                    move(-1,0)
                    sleep(CONFIG.Delay.Move)
                    waduh = 0
                    dropx = math.floor(getBot().x / 32)
                    dropy = math.floor(getBot().y / 32)
                else
                    if findItem(CONFIG.Storage.List_Drop[i]) > 0 then
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
            if scanfloat(CONFIG.Storage.Id) > CONFIG.Minimum_Item then
                collectSet(true,CONFIG.Range_Collect)
                sleep(50)
                for _,obj in pairs(getObject()) do
                    if obj.id == CONFIG.Storage.Id then
                        if scanfloat(CONFIG.Storage.Id) > 0 then
                            if getTile(math.floor(obj.x / 32),math.floor(obj.y / 32)).flags == 0 then
                                for i = 1,#CONFIG.Storage.List_Drop do
                                    if findItem(CONFIG.Storage.List_Drop[i]) >= CONFIG.Storage.Maximum then
                                        warp(CONFIG.Storage.Name,CONFIG.Storage.Door)
                                        Drop()
                                        goto join
                                    end
                                end
                            end
                            findPath(math.floor(obj.x / 32),math.floor(obj.y / 32))
                            sleep(CONFIG.Delay.FindPath)
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
