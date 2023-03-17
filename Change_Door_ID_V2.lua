--[ API ]--
farm = Bot[getBot().name:upper()].farm
oldDoorID = Bot[getBot().name:upper()].oldDoorID
newDoorID = Bot[getBot().name:upper()].newDoorID
webfuck = Bot[getBot().name:upper()].webfuck

--[KM MW? AK JG MW]--
say("`cSCRIPT MADE By `4Madang.EXE#6264")
sleep(1000)
function webfucki(text)
    local wh = {}
    wh.url = webfuck
    wh.username = "M A D S | NIGGA"
    wh.content = text
    webhook(wh)
end

function change(id,newID)
    for i = 1,#farm do
        sendPacket(3,"action|join_request\nname|"..farm[i].."\ninvitedWorld|0")
        sleep(5000)
            while getTile(math.floor(getBot().x / 32),math.floor(getBot().y / 32)).fg == 6 do
                sendPacket(3,"action|join_request\nname|"..farm[i].."|"..id.."\ninvitedWorld|0")
                sleep(2000)
            end
        wrench(0,0)
        sleep(2500)
        sendPacket(2,"action|dialog_return\ndialog_name|door_edit\ntilex|"..math.floor(getBot().x/32).."|\ntiley|"..math.floor(getBot().y/32).."|\ndoor_name|mm\ndoor_target|\ndoor_id|"..newID.."\ncheckbox_locked|0")
        sleep(2500)
        webfucki(" **"..getBot().name:upper().."** IN ||"..getBot().world:upper().."|| CHANGE **"..oldDoorID.."** TO ||["..newDoorID.."]||")
    end
    removeBot(getBot().name)
end

change(oldDoorID,newDoorID)
