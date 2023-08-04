--] M A D S | Check Bot [--
World_Locked = false
Nuked = false
List_Lock = {202,204,206,242,1796,7188,9640,4802,5814,8470,5980,2950,5260,4482,2408,10410,11550,11586}
function pshell(status)
    local mads = [[
        $webHookUrl = "]]..MADS.Webhook..[["
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
function Random_Text(banyak_huruf, karakter_yg_mau_di_acak)
    local hasil = {}
    for i = 1,banyak_huruf do
        local index = math.random(#karakter_yg_mau_di_acak)
        hasil[i] = karakter_yg_mau_di_acak:sub(index , index)
    end
    return table.concat(hasil)
end
function warp(world)
    local negro = 0
    while getBot().world ~= world:upper() and not Nuked do
        sendPacket("action|join_request\nname|"..world:upper().."\ninvitedWorld|0",3)
        sleep(3500)
        if negro == 5 then
            Nuked = true
        else
            negro = negro + 1
        end
    end
end

function log(text) 
    file = io.open("BOT STATUS.txt", "a")
    file:write(text.."\n")
    file:close()
end

for index,bot in pairs(MADS.Bot) do
    for _, tuyul in pairs(bot.Growid) do
        if string.len(bot.Proxy) > 0 then
            addBot(tuyul,bot.Password,bot.Proxy)
            sleep(3000)
        else
            addBot(tuyul,bot.Password)
            sleep(3000)
        end

        while getBot().status == 'login fail' or getBot().status == 'offline' do
            connect()
            sleep(MADS.DelayConnect)
        end

        if getBot().status == 'temporary banned' then
            goto skip
        elseif getBot().status == 'banned' or 
                getBot().status == 'suspended' or 
                getBot().status == 'invalid email' or 
                getBot().status == 'aap detected' then
            log(getBot().name:upper()..' | '..getBot().status:upper())
            pshell('`'..getBot().name:upper()..' | '..getBot().status:upper()..'`')
            sleep(1500)
            removeBot(getBot().name)
            sleep(2000)
        elseif getBot().status == 'online' then
            if MADS.RandomWorld then
                ::join::
                warp(Random_Text(7,'ABCDEFGHIJKLMNOPQRSTUVWXYZ01234567890'))
                if not Nuked then
                    for _,tile in pairs(getTiles()) do
                        if not World_Locked then
                            for _,lock in pairs(List_Lock) do
                                if tile.fg == lock then
                                    World_Locked = true
                                    goto join
                                    World_Locked = false
                                end
                            end   
                        else
                            break                         
                        end
                    end

                    if not World_Locked then
                        log(getBot().name:upper()..' | '..getBot().status:upper())
                        pshell('`'..getBot().name:upper()..' | '..getBot().status:upper()..' | '..getBot().world:upper()..'`')
                        sleep(1500)
                    end
                else
                    Nuked = false
                    goto join
                end
            else
                log(getBot().name:upper()..' | '..getBot().status:upper())
                pshell('`'..getBot().name:upper()..' | '..getBot().status:upper()..' | '..getBot().world:upper()..'`')
                sleep(1500)
            end
            removeBot(getBot().name)
            sleep(2000)
        end
    end
    ::skip::
end

