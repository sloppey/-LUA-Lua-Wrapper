# -LUA-Lua-Wrapper
A lua wrapper in lua



example usage:
```lua
local Instance = Register(Instance)
	Instance:Create("new", function(a1,a2)
		if a1 == "RedPart" then
			local r = Instance.Raw.new("Part")
      r.BrickColor = BrickColor.Red()
			r.Parent=a2
			return r
		end
		return Instance.Raw.new(a1,a2)
	end)
```
