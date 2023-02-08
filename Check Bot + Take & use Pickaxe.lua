--//SCRIPT CHECK BOT MOKAD OR HIDUP AND TAKE + USE PICKAXE
--//SCRIPT MADE BY Madang.EXE#6264
--//DONT RESELL THIS SCRIPT 
--//MAKE SURE YOU HAVE LOTS OF PICKAXE
--//PUT THE PICKAXE RIGHT SIDE OF THE DOOR
--//CAN BYPASS AAP (delayReconnect = 10000+)

botList = {"BOT1","BOT2","BOT3"} --// UNLIMITED BOT OMG
password = "P@ssw0rd" --/ BOT PASSWORD
Wpx = "YOUR WORLD" --// WORLD TAKE PICKAXE
IDpx = "DOOR ID" --ID DOOR
delayReconnect = 7000 --// PUT 10000 IF U WANT TO BYPASS AAP!

--// BANG UDAH BANG
function log(text) 
    file = io.open("BOT STATUS.txt", "a")
    file:write(text.."\n")
    file:close()
end

function summontuyul(world,id,itemid)
    for i, lojin in ipairs(botList) do
    addBot(lojin,password)
    sleep(8000)
        while getBot().status == "login fail" or getBot().status == "offline" do
            setBool("Auto Reconnect", false)
            connect()
            sleep(delayReconnect)
        end
    if getBot().status == "suspended" then
        log(getBot().name.." | SUSPENDED")
        removeBot(getBot().name)
        sleep(1500)
    elseif getBot().status == "banned" then
        log(getBot().name.." | BANNED")
        removeBot(getBot().name)
        sleep(1500)
    elseif getBot().status == "online" then       
            sendPacket(3,"action|join_request\nname|" ..world.."\ninvitedWorld|0")
            sleep(5000)
            sendPacket(3,"action|join_request\nname|" ..world.."|"..id.."\ninvitedWorld|0")
            sleep(3000)
            if findItem(itemid) ~= 1 then
                collectSet(true, 2)
                sleep(1000)
            while findItem(itemid) ~= 1 do
                collectSet(false, 2)
                sendPacket(2,"action|drop\nitemID|"..itemid)
                sleep(2000)
                sendPacket(2,"action|dialog_return\ndialog_name|drop_item\nitemID|"..itemid.."|\ncount|"..(findItem(itemid)-1))
                sleep(500)
            end
                while not findClothes(itemid) do
                    wear(itemid)
                    sleep(500)
                    log(getBot().name.." | ALIVE | LEVEL "..getBot().level.." | GEMS "..findItem(112).." | DONE USE PICKAXE")
                end                    
                removeBot(getBot().name)
                sleep(1000)
            end
        end
    end
end


summontuyul(Wpx,IDpx,98)
