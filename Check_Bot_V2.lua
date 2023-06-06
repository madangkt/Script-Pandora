--] M A D S | Check Bot [--
function pshell(status)
    local mads = [[
        $webHookUrl = "]]..wefuck..[["
        $content = "]]..status..[["
        $payload = {
            content = $content 
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
    ]]
    local pipe = io.popen("powershell -command -","w")
    pipe:write(mads)
    pipe:close()
end

function log(text) 
    file = io.open("BOT STATUS.txt", "a")
    file:write(text.."\n")
    file:close()
end

for i = 1,#botList do
    addBot(botList[i],password)
    sleep(5000)
    setBool("Auto Reconnect", false)
    while getBot().status == "login fail" or getBot().status == "offline" do
        connect()
        sleep(delayreconnect)
    end
    if getBot().status == "invalid email" then
        log(getBot().name.." | INVALID EMAIL")
        pshell("`"..getBot().name:upper().." | INVALID EMAIL`")
        sleep(800)
        removeBot(getBot().name)
    elseif getBot().status == "aap detected" then 
        log(getBot().name.." | AAP DETECTED")
        pshell("`"..getBot().name:upper().." | AAP DETECTED`")
        sleep(800)
        removeBot(getBot().name)
    elseif getBot().status == "suspended" then
        log(getBot().name.." | SUSPENDED")
        pshell("`"..getBot().name:upper().." | SUSPENDED`")
        sleep(800)
        removeBot(getBot().name)
    elseif getBot().status == "banned" then
        log(getBot().name.." | BANNED")
        pshell("`"..getBot().name:upper().." | BANNED`")
        sleep(800)
        removeBot(getBot().name)
    elseif getBot().status == "online" then
        log(getBot().name.." | ONLINE | LEVEL "..getBot().level.." | GEMS "..findItem(112).." | WORLD "..getBot().world)
        pshell("`"..getBot().name:upper().." | ONLINE | LEVEL "..getBot().level.." | GEMS "..findItem(112).." | WORLD : "..getBot().world:upper().."`")
        sleep(800)
        removeBot(getBot().name)
    end
end
