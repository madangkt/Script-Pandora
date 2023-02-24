--//SCRIPT MOVE WITH LIMIT & COSTOM LIMIT /WORLD
--//SCRIPT MADE By Madang.EXE#6264
--//THIS SCRIPT IT'S WORK BUT IF HAVE BUG JUST DM ME
--//DON'T RESELL THIS SCRIPT

item = 5666 --//ITEM ID
worldTake = "WORLD TAKE"
doorTake  = "DOOR ID WORLD TAKE"
worldDrop = {
    {name = "world1",door = "doorid1",limit = 600}, --//LIMIT ITEM DROP IN WORLD
    {name = "world2",door = "doorid2",limit = 400}  --//LIMIT ITEM DROP IN WORLD
}
patokan = 20    --// FG / BG TO DROP ITEM
                --// JUST USING 1 FG / BG

--//KAMU NIGGA SEGERA MENJAUH
say("`cSCRIPT MADE By `4Madang.EXE#6264")
local nWorld = 1

local function scanFloat(itemid)
    local count = 0
    for _, obj in pairs(getObjects()) do
        if obj.id == itemid then
            count = count + obj.count
        end
    end
    return count
end

local function goFloat(id)
    for _, obj in pairs(getObjects()) do
        if obj.id == id then
            if (getTile(math.floor((obj.x+10)/32),math.floor((obj.y+10)/32)).flags == 0 or 
                getTile(math.floor((obj.x+10)/32),math.floor((obj.y+10)/32)).flags == 2) then
                findPath(math.floor((obj.x+10)/32),math.floor((obj.y+10)/32))
                sleep(500)
                collectSet(true,3)
                sleep(500)
                return true
            end
        end
    end
  return false
end

local function goPos(itemid)
    for _, tile in pairs(getTiles()) do
    if tile.fg == itemid or tile.bg == itemid then
        findPath(tile.x-1,tile.y)
        sleep(500)
        collectSet(false,3)
    end
    end   
end

local function takeBanh(world,id,itemid)
    if getBot().world ~= world:upper() then
        sendPacket(3, "action|join_request\nname|"..world:upper().."\ninvitedWorld|0") 
        sleep(5000)
        while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 do 
            sendPacket(3, "action|join_request\nname|"..world:upper().."|"..id:upper().."\ninvitedWorld|0") 
            sleep(1000) 
        end
        if scanFloat(itemid) == 0 then
            removeBot(getBot().name)
            sleep(1000)
        end
    end    
end


local function joinDrop(world,id)
    while getBot().world ~= world:upper() do 
        sendPacket(3, "action|join_request\nname|"..world:upper().."\ninvitedWorld|0") 
        sleep(5000) 
    end

    if scanFloat(item) < worldDrop[nWorld].limit then
        while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 do 
            sendPacket(3, "action|join_request\nname|"..world:upper().."|"..id:upper().."\ninvitedWorld|0") 
            sleep(1000) 
        end 
    end 
end 

function main()
    while findItem(item) < 200 do 
    takeBanh(worldTake,doorTake,item)
    sleep(1000)
    goFloat(item)
    sleep(500)
        ::anjimeck::
        if findItem(item) > 0 then
            joinDrop(worldDrop[nWorld].name,worldDrop[nWorld].door)
            sleep(500)
            if scanFloat(item) < worldDrop[nWorld].limit then
                goPos(patokan)
                sleep(500)
                while findItem(item) ~= 0 do
                    drop(item)
                    sleep(200)
                    move(-1,0)
                    sleep(500)
                end
            elseif scanFloat(item) >= worldDrop[nWorld].limit then
                if nWorld == #worldDrop then
                end
               nWorld = nWorld +1 
               goto anjimeck
            end
        end 
    end
end

main()
