print("ccmidi File")
local file = read()

print("initializing network...")
rednet.close("back")
sleep(1)
rednet.open("back")
print("initialized")

-- name worktime
--  |    |
-- \/   \/
-- BU   15 = BU 15

local function get_line_count(str)
    local lines = 1
    for i = 1, #str do
        local c = str:sub(i, i)
        if c == '\n' then lines = lines + 1 end
    end

    return lines
end

function spilt(line)
    list = {}

    for token in string.gmatch(line, "[^%s]+") do
        table.insert(list, token)
    end
    return list
end

function send(command)
    l = spilt(command)

    rednet.broadcast(command)
    sleep(tonumber(l[4]))
end 

print("Reading command")

-- command here

local h = fs.open(file, "r")

print("Running command")

for token in string.gmatch(h.readAll(), "([^\n]*)\n?") do
    print(token)
    send(token)
end

-- end

print("Finished")