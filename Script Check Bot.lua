--//SCRIPT CHECK BOT ALIVE/SUSPENDED/BANNED
--//SCRIPT MADE BY Madang.EXE#6264
--//DONT RESELL THIS SCRIPT
--//BYPASS AAP (delayreconnect = 10000+)


botList = {"","","","",""} --// UNLIMITED BOT 
password = "@mbatukam1" --// YOUR BOT PASSWORD
delayreconnect = 7000 --// PUT 10000 IF U WANT TO BYPASS AAP

--// BANG UDAH BANG
function log(text) 
    file = io.open("BOT STATUS.txt", "a")
    file:write(text.."\n")
    file:close()
end

function summontuyul()
    for i, lojin in ipairs(botList) do
    addBot(lojin,password)
    sleep(5000)
    setBool("Auto Reconnect", false)
        while getBot().status == "login fail" or getBot().status == "offline" do
        connect()
        sleep(delayreconnect)
        end
    if getBot().status == "suspended" then
        log(getBot().name.." | SUSPENDED")
        removeBot(getBot().name)
        sleep(1000)
 elseif getBot().status == "banned" then
        log(getBot().name.." | BANNED")
        removeBot(getBot().name)
        sleep(1000)
 elseif getBot().status == "online" then
        log(getBot().name.." | ALIVE | LEVEL "..getBot().level.." | GEMS "..findItem(112))
        sleep(500)
        removeBot(getBot().name)
        sleep(1000)
    end
end
end

summontuyul(Wbot)
