local QBCore = exports["qb-core"]:GetCoreObject()
local ServerObjects = {}

RegisterNetEvent("ps-objectspawner:server:CreateNewObject", function(model, coords, objecttype, options, objectname)
    local src = source
    if model and coords then
        local data = MySQL.query.await("INSERT INTO objects (model, coords, type, options, name) VALUES (?, ?, ?, ?)", { model, json.encode(coords), objecttype, json.encode(options), objectname })
        ServerObjects[data.insertId] = {id = data.insertId, model = model, coords = json.encode(coords), type = objecttype, name = objectname, options = json.encode(options)}
        TriggerClientEvent("ps-objectspawner:client:AddObject", -1, {id = data.insertId, model = model, coords = json.encode(coords), type = objecttype, options = json.encode(options)})
    else 
        print("[PS-OBJECTSPAWNER]: Object or coords was invalid")
    end
end)

CreateThread(function()
    local results = MySQL.query.await('SELECT * FROM objects', {})
    --Wait(5000)
    --TriggerClientEvent("ps-objectspawner:client:UpdateObjectList", -1, ServerObjects)
    for k, v in pairs(results) do
        ServerObjects[v["id"]] = v
    end
end)

QBCore.Functions.CreateCallback("ps-objectspawner:server:RequestObjects", function(source, cb)
    cb(ServerObjects)
end)

local function CreateDataObject(mode, coords, type, options)
    MySQL.query.await("INSERT INTO objects (model, coords, type, options) VALUES (?, ?, ?, ?)", { model, json.encode(coords), type, json.encode(options) })
end

exports("CreateDataObject", CreateDataObject)