--//SCRIPT MADE BY Madang.EXE#6264
--//DONT RESELL THIS SCRIPT
--//MAKE SURE YOUR PICKAXE ALREADY TONS

bot = {"","",""} --//UNLIMITED BOT
password = "P@ssw0rd" --//YOUR BOT PASSWORD
worldPX = "WORLD PICKAXE" --//WORLD PICKAXE
doorPX = "ID DOOR" --//ID DOOR WORLD PICKAXE
delayReconnect = 7000 --//DELAY RECONNECT

function pickaxe(world,id,itemid)
for i = 1,#bot do
addBot(bot[i],password)
sleep(5000)
    while getBot().status == "login fail" or getBot().status == "offline" do
    connect()
    sleep(delayReconnect)
    end
    if getBot().status == "suspended" then
        removeBot(getBot().name)
        sleep(1000)
    if getBot().status == "banned" then
        removeBot(getBot().name)
        sleep(1000)
    elseif getBot().status == "online" then
        sendPacket(3,"action|join_request\nname|" ..world.."\ninvitedWorld|0")
        sleep(5000)
        sendPacket(3,"action|join_request\nname|"..world.."|"..id.."\ninvitedWorld|0")
        sleep(500)
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
                while not findClothes(98) do
                    wear(98)
                    sleep(500)
                end
                removeBot(getBot().name)
                sleep(1000)
                end
            end
        end
    end
end

pickaxe(worldPX,doorPX,98)
