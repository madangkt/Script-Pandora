for index,world in pairs(CONFIG.Farm_List) do
    ::join::
    warp(world,CONFIG.Door_Farm)
    if not Nuked then
        if not Wrong_Door then
            if scanfloat(112) >= CONFIG.Minimum_Gems then
                collectSet(true,CONFIG.Range_Collect)
                sleep(100)
                for _,tile in pairs(getTiles()) do 
                    for _,obj in pairs(getObjects()) do
                        if obj.id == 112 and getTile(tile.x,tile.y).flags == 0 then
                            if findItem(112) >= CONFIG.Pack.Trigger and CONFIG.Pack.Buy then
                                warp(CONFIG.Storage.Name,CONFIG.Storage.Door)
                                Drop(CONFIG.Pack.Debug)
                                sleep(100)
                                goto join
                            end
                            findPath(math.floor((obj.x + 10) / 32),math.floor((obj.y + 10) / 32))
                            sleep(CONFIG.Delay.FindPath)
                        end
                    end
                end
            end
        else
            print(world:upper()..' Have Wrong Door id!') 
            Wrong_Door = false
        end
    else
        print(world:upper()..' Has Been Nuked!')
        Nuked = false
    end
end
