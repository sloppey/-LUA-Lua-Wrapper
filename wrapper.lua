function wrapTable(t)
	local res = {}
	for i,v in pairs(t) do
		table.insert(res, i, Register(v))
	end
	return res
end

function Register(u)
    if type(u) == "userdata" or type(u) == "table" then
    local mt = {}
    mt.Userdata = u
    mt.__index = function(t,k)
    mt.currkey=k
	if type(u[k]) == "function" and getfenv(0)[k] == nil then
	
	local selfres = function(self, ...)
		local ress = mt.Userdata[k](mt.Userdata, ...)
		if type(ress) == "table" then
			return wrapTable(ress)
		end
		return Register(mt.Userdata[k](mt.Userdata, ...))
	end
	
	local s,m = pcall(selfres)
	if s then
		return selfres
	end
	if not s then
		return u[k]
	end
	
	end
	if type(u[k]) == "function" and getfenv(0)[k]  then
		return u[k]
	end
	
        return Register(u[k])
    end
    mt.__tostring = function(t)
        return tostring(u)
    end
    mt.Create = function(self,n,f)
	rawset(mt, n, f)
    end
	mt.Raw = u
    mt.SetProperty = function(self,a,v)
        u[a]=v
    end
	mt.__newindex = function(t,k,v)
	if k ~= "currkey" then
	t.Userdata[k]=v
	end
	end
    setmetatable(mt, {__index = mt.__index, __tostring=mt.__tostring, __newindex = mt.__newindex})
    return mt
    end
    return u
	end
