--//SCRIPT CHECK BOT MOKAD OR HIDUP
--//SCRIPT MADE BY Madang.EXE#6264
--//DONT RESELL THIS SCRIPT 


botList = {
    "AMBATUKAM1",
    "AMBATUKAM2",
    "AMBATUKAM3",
}
password = "@mbatukam1"
Wbot = "YOUR WORLD" --// apa aja asal botnya di world itu
delayreconnect = 7000 --// PUT 10000 IF U WANT TO BYPASS AAP

--// BANG UDAH BANG
function log(text) 
    file = io.open("BOT STATUS.txt", "a")
    file:write(text.."\n")
    file:close()
end

function summontuyul(world)
    for i, lojin in ipairs(botList) do
    addBbot(lojin,password)
    sleep(5000)
    setBool("Auto Reconnect", false)
        while getBot().status == "login fail" or getBot().status == "offline" do
        connect()
        sleep(delayreconnect)
        end
    if getBot().status == "suspended" or getBot().status == "banned" then
        log(getBot().name.." | SUSPENDED")
        sleep(5000)
        removeBot(getBot().name)
        sleep(1000)
    elseif getBot().status == "online" then
        log(getBot().name.." | ALIVE")
        sleep(5000)
        while getBot().world ~= world do
            sendPacket(3,"action|join_request\nname|" ..world.."\ninvitedWorld|0")
            sleep(5000)
        end
        removeBot(getBot().name)
        sleep(1000)
    end
end
end
