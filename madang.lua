
function bilang(text)
    say(text)
end
function tulis(text)
    print(text)
end
function turu(int)
    sleep(int)
end
function geser(x,y)
    move(x,y)
end
function telePort(x,y)
    findPath(x,y)
end
function cariBarang(int)
    findItem(int)
end
function cariBaju(int)
    findClothes(int)
end
function pukul(x,y)
    punch(x,y)
end
function taro(barang,x,y)
    place(barang,x,y)
end
function kunci(x,y)
    wrench(x,y)
end
function buang(id,amount)
    if amount ~= nil then
        drop(id)
    elseif amount == nil then 
        drop(id,amount)
    end
end
function masuk()
    enter()
end
function ambil(range,ignore)
    if ignore ~= nil then
        collect(range,ignore)
    elseif ignore == nil then 
        collect(range)
    end
end
function ambilCok(range,bool)
    if bool ~= nil then
        collectSet(range,bool)
    else
        collectSet(range)
    end
end
function kirimPaket(type,paket)
    sendPacket(paket,type)
end
function iniBot()
    tableBot = {}
    tableBot.nama = getBot().name
    tableBot.kota = getBot().world
    tableBot.tahta = getBot().status   
    tableBot.x = getBot().x  
    tableBot.y = getBot().y    
    tableBot.level = getBot().level   
    tableBot.bp = getBot().slots 
    tableBot.puzzle = getBot().captcha
    tableBot.vpn = getBot().proxy
    tableBot.vpnStatus = getBot().proxyStatus
    tableBot.gems = findItem(112)
    return tableBot
end
function iniKotak(ex,ye)
    tableKotak = {}
    tableKotak.porgron  = getTile(ex,ye).fg
    tableKotak.bekgron  = getTile(ex,ye).bg
    tableKotak.siap     = getTile(ex,ye).ready
    tableKotak.flags    = getTile(ex,ye).flags
    tableKotak.x        = getTile(ex,ye).x
    tableKotak.y        = getTile(ex,ye).y
    tableKotak.rillFlags= getTile(ex,ye).extraFlags
    return tableKotak
end
function iniKotaks(ex,ye)
    tableKotaks = {}
    tableKotaks.porgron   = getTiles(ex,ye).fg
    tableKotaks.bekgron   = getTiles(ex,ye).bg
    tableKotaks.siap      = getTiles(ex,ye).ready
    tableKotaks.flags     = getTiles(ex,ye).flags
    tableKotaks.x         = getTiles(ex,ye).x
    tableKotaks.y         = getTiles(ex,ye).y
    tableKotaks.rillFlags = getTiles(ex,ye).extraFlags
    return tableKotaks
end
function iniFloat(ex,ye)
    tableFloat = {}
    tableFloat.tanda = getObjects(ex,ye).id
    tableFloat.jumlah = getObjects(ex,ye).count
    tableFloat.x = getObjects(ex,ye).x
    tableFloat.y = getObjects(ex,ye).y
    tableFloat.oid = getObjects(ex,ye).oid
    return tableFloat
end
function iniOrangs()
    tableOrangs = {}
    tableOrangs.nama = getPlayers().name
    tableOrangs.netTanda = getPlayers().netid
    tableOrangs.ktp = getPlayers().userif
    tableOrangs.negara = getPlayers().country
    tableOrangs.x = getPlayers().x
    tableOrangs.y = getPlayers().y
    return tableOrangs
end
function iniTas()
    tableTas = {}
    tableTas.nama = getInventory().name
    tableTas.tanda = getInventory().id
    tableTas.jumlah = getInventory().count
    return tableTas
end
function iniPakaian()
    tablePakaian = {}
    tablePakaian.nama = getClothes().name
    tablePakaian.tanda = getClothes().id
    return tablePakaian
end
