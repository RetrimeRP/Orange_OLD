module("DarkRP", package.seeall)

MetaName = "DarkRP"

local stubs = {}
local hookStubs = {}

hooks = {}

local delayedCalls = {}

local returnsLayout, isreturns
local parameterLayout, isparameters
local isdeprecated
local checkStub
local hookLayout
local realm

isreturns = function(tbl)

	if not istable(tbl) then return false end

	for _, v in pairs(tbl) do
		if not checkStub(v, returnsLayout) then return false end
	end

	return true

end

isparameters = function(tbl)

	if not istable(tbl) then return false end

	for _, v in pairs(tbl) do
		if not checkStub(v, parameterLayout) then return false end
	end

	return true

end

isdeprecated = function(val)

	return val == nil or isstring(val)

end

local stubLayout = {

	name = isstring,
	description = isstring,
	deprecated = isdeprecated,
	parameters = isparameters,
	returns = isreturns,
	metatable = istable

}

hookLayout = {

	name = isstring,
	description = isstring,
	deprecated = isdeprecated,
	parameters = isreturns,
	returns = isreturns

}

returnsLayout = {

	name = isstring,
	description = isstring,
	type = isstring

}

parameterLayout = {

	name = isstring,
	description = isstring,
	type = isstring,
	optional = isbool

}

checkStub = function(tbl, stub)

	if not istable(tbl) then return false, "table" end

	for name, check in pairs(stub) do
		if not check(tbl[name]) then return false, name end
	end

	return true

end

local function notImplemented(name, args, thisFunc)

	if stubs[name] and stubs[name].metatable[name] ~= thisFunc then return stubs[name].metatable[name](unpack(args)) end

	table.insert(delayedCalls, {
		name = name,
		args = args
	})

	return nil

end

function stub(tbl)

	local isStub, field = checkStub(tbl, stubLayout)

	if not isStub then
		error("Invalid DarkRP method stub! Field \"" .. field .. "\" is invalid!", 2)
	end

	tbl.realm = tbl.realm or realm
	stubs[tbl.name] = tbl

	local function retNotImpl(...)
		return notImplemented(tbl.name, {...}, retNotImpl)
	end

	return retNotImpl

end

function hookStub(tbl)

	local isStub, field = checkStub(tbl, hookLayout)

	if not isStub then
		error("Invalid DarkRP hook! Field \"" .. field .. "\" is invalid!", 2)
	end

	tbl.realm = tbl.realm or realm
	hookStubs[tbl.name] = tbl

end

function getStubs()

	return table.Copy(stubs)

end

function getHooks()

	return table.Copy(hookStubs)

end

function finish()

	local calls = table.Copy(delayedCalls)

	for _, tbl in ipairs(calls) do
		local name = tbl.name

		if not stubs[name] then
			ErrorNoHalt("Calling non-existing stub \"" .. name .. "\"")
			continue
		end

		stubs[name].metatable[name](unpack(tbl.args))
	end

	delayedCalls = {}

end

local function loadInterfaces()

	local root = GM.FolderName .. "/gamemode/core"
	local _, folders = file.Find(root .. "/*", "LUA")

	ENTITY = FindMetaTable("Entity")
	PLAYER = FindMetaTable("Player")
	VECTOR = FindMetaTable("Vector")

	for _, folder in SortedPairs(folders, true) do
		local interfacefile = string.format("%s/%s/%s_interface.lua", root, folder, "%s")
		local client = string.format(interfacefile, "cl")
		local shared = string.format(interfacefile, "sh")
		local server = string.format(interfacefile, "sv")

		if file.Exists(shared, "LUA") then
			if SERVER then
				AddCSLuaFile(shared)
			end

			realm = "Shared"
			include(shared)
		end

		if SERVER and file.Exists(client, "LUA") then
			AddCSLuaFile(client)
		end

		if SERVER and file.Exists(server, "LUA") then
			realm = "Server"
			include(server)
		end

		if CLIENT and file.Exists(client, "LUA") then
			realm = "Client"
			include(client)
		end
	end

	ENTITY, PLAYER, VECTOR = nil, nil, nil

end

loadInterfaces()