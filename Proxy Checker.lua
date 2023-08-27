function log(text) 
    if CONFIG.Input_Txt then
        file = io.open("Proxy.txt", "a")
        file:write(text.."\n")
        file:close()        
    end
    sleep(150)
end
function web(description)
    local script = [[
        $webHookUrl = "]]..CONFIG.Input_Webhook.Url..[["
        $content = "]]..description..[["
        $payload = @{
            content = $content 
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
    ]]
    if CONFIG.Input_Webhook.Enable then
        local pipe = io.popen("powershell -command -", "w")
        pipe:write(script)
        pipe:close()        
    end
    sleep(100)
end
for i = 1,#CONFIG.Proxy do
    addBot(CONFIG.Growid,CONFIG.Password,CONFIG.Proxy[i])
    sleep(math.random(2500,3999))
    setBool('Auto Reconnect',false)
    sleep(50)
    if getBot().status == 'offline' then
        for j = 1,10 do
            if getBot().status == 'offline' then
                connect()
                sleep(math.random(4999,5999))
            else
                break 
            end
        end
        if getBot().status == 'offline' or getBot().status == 'ercon' then
            web('`'..CONFIG.Proxy[i]..' | OFFLINE`')
        elseif getBot().status == 'wrong password' or getBot().status == 'suspended' or getBot().status == 'banned' or getBot().status == 'invalid email' or getBot().status == 'aap detected' then
            web('`'..CONFIG.Proxy[i]..'|| ONLINE`')
        end
        log(CONFIG.Proxy[i]..' | '..getBot().status:upper())
        removeBot(getBot().name)
        sleep(math.random(9999,11999))
    else
        web('`'..CONFIG.Proxy[i]..' | ONLINE`')
        log(CONFIG.Proxy[i]..' | '..getBot().status:upper())
        removeBot(getBot().name)
        sleep(math.random(9999,11999))
    end
end
