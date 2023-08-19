if Application:lower() == 'olympus' then
    indexProxy = 1
    indexBot = 0
    if Proxy_List.Enable then
        for accType, accList in pairs(Bot_List) do
            if accType:lower() == 'guest' then
                for index, bot in ipairs(accList) do
                    if indexBot >= Proxy_List.Max_Bot then
                        indexProxy = indexProxy + 1
                        if indexProxy > #Proxy_List.List then
                            goto skip
                        end
                        indexBot = 0
                    else
                        addBot(bot.Growid,true,Proxy_List.List[indexProxy])
                        setRid(bot.Rid)
                        setMac(bot.Mac)
                        sleep(3000)
                        indexBot = indexBot + 1
                    end
                end
            elseif accType:lower() == 'cid' then
                for index,bot in ipairs(accList) do
                    if indexBot >= Proxy_List.Max_Bot then
                        indexProxy = indexProxy + 1
                        if indexProxy > #Proxy_List.List then
                            goto skip
                        end
                        indexBot = 0
                    else
                        addBot(bot.Growid,bot.Password,Proxy_List.List[indexProxy])
                        sleep(3000)
                        indexBot = indexBot + 1
                    end
                end
            elseif accType:lower() == 'ubisoft' then
                for index,bot in ipairs(accList) do
                    addBot(bot.Email,bot.Password)
                    getUbisoftData()
                    sleep(3000)
    
                end
            end
        end
    else
        for accType,accList in pairs(Bot_List) do
            if accType:lower() == 'guest' then
                for index,bot in ipairs(accList) do
                    addBot(bot.Growid)
                    setRid(bot.Rid)
                    setMac(bot.Mac)
                    sleep(3000)
                end
            elseif accType:lower() == 'cid' then
                for index,bot in ipairs(accList) do
                    addBot(bot.Growid,bot.Password)
                    sleep(3000)
                end
            elseif accType:lower() == 'ubisoft' then
                for index,bot in ipairs(accList) do
                    addBot(bot.Email,bot.Password)
                    getUbisoftData()
                    sleep(3000)
                end
            end
        end
    end
end


::skip::
