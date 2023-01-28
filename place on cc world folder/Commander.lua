print("initializing network...")
rednet.close("back")
sleep(1)
rednet.open("back")
print("initialized")

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

while true do
    command = read()
    if command == "exit" then
        break
    end

    send(command)
end

print("Finished")