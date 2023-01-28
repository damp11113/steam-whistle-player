rednet.close("bottom")
sleep(1)
rednet.open("bottom")

function spilt(line)
    list = {}

    for token in string.gmatch(line, "[^%s]+") do
        table.insert(list, token)
    end
    return list
end

function run()
    id , msg, pro = rednet.receive()

    -- l = spilt(msg)
	
	print(msg)
	
	
end

while true do
    run()
end
