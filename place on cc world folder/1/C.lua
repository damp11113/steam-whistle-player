rednet.close("back")
sleep(1)
rednet.open("back")

function spilt(line)
    list = {}

    for token in string.gmatch(line, "[^%s]+") do
        table.insert(list, token)
    end
    return list
end

function run()
    id , msg, pro = rednet.receive()

    l = spilt(msg)
	
	if l[2] == "1" then
		if l[3] == "C" then
			if l[1] == "note_on" then
				redstone.setOutput("top", true)
			elseif l[1] == 'note_off' then
				redstone.setOutput("top", false)
			end
		end
    end
end

while true do
    run()
end