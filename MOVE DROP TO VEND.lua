--//SCRIPT MOVE ITEM DROP TO VEND (OTHER WORLD) 
--//SCRIPT MADE BY Madang.EXE#6264 
--//THIS IS BETA SCRIPT! NOT TESTING IT BEFORE
--//USE VENDING MACHINE NOT DIGIVEND!


itemID = 955 --//ITEM WANT ADD TOO VEND

worldItem = "" --//WORLD WORLD TAKE ITEM
doorItem = ""  --//DOOR WORLD

worldVend = "" --//WORLD VEND
doorVend = ""  --//WORLD VEND

--//DON'T TOUCH
function takeitem(world,id,item)
    if findItem(item) <= 1 then
        sendPacket(3,"action|join_request\nname|" ..world.."\ninvitedWorld|0")
        sleep(6000)
        sendPacket(3,"action|join_request\nname|"..world.."|"..id.."\ninvitedWorld|0")
        sleep(500)
        for _, obj in pairs(getObjects()) do
        if obj.id == item then
            local x = math.floor((obj.x+10)/32)
            local y = math.floor((obj.y+10)/32)
            findPath(x, y)
            sleep(500)
            collect(3)
                if findItem ~= 0 then 
                    vending(worldVend,doorVend,itemID)
                    sleep(2000)
                    break
                end
            end
        end
    end
end

function vending(world,id,item)
    for _, items in pairs(getInventory()) do
        if items.id == item and findItem(item) ~= 0 then
            sendPacket(3,"action|join_request\nname|" ..world.."\ninvitedWorld|0")
            sleep(6000)
            sendPacket(3,"action|join_request\nname|"..world.."|"..id.."\ninvitedWorld|0")
            sleep(500)           
            for _, tile in pairs(getTiles()) do
                if tile.fg == 2978 or tile.bg == 2978 then
                    findPath(tile.x,tile.y)
                    sleep(500)
                    putitem(itemID)
                    sleep(2000)
                    break
                end
            end
        end
    end
end

function putitem(item)
    while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 2978 do
        if findItem(item) ~= 0 then
        wrench(0,0)
        sleep(500)
        sendPacket(2,"action|dialog_return\ndialog_name|vending\ntilex|"..math.floor(getBot().x/32).."|\ntiley|"..math.floor(getBot().y/32).."\nbuttonClicked|addstock\n\nsetprice|0\nchk_peritem|0\nchkperlock|1")
        sleep(2000)
             while getTiles().data >= 4999 do
                move(1,0)
                sleep(500)
            end
        end
    end
    if findItem(item) == 0 or findItem(item) ~= 0 then
        takeitem(worldItem,doorItem,itemID)
        sleep(1500)
    end
end

putitem(itemID)
