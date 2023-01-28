rednet.close("bottom")
sleep(1)
rednet.open("bottom")

mon = peripheral.wrap("back")
monX, monY = mon.getSize()

function monClear()
	mon.setBackgroundColor(colors.black)
	mon.clear()
	mon.setCursorPos(1, 1)
end

function monDrawText(x, y, text, color_text, color_bg)
	mon.setBackgroundColor(color_bg)
	mon.setTextColor(color_text)
	mon.setCursorPos(x, y)
	mon.write(text)
end

function monDrawLine(x, y, length, size, color_bar)
	for yPos = y, y+size-1 do
		mon.setBackgroundColor(color_bar)
		mon.setCursorPos(x, yPos)
		mon.write(string.rep(" ", length))
	end
end

function monDrawProg(x, y, name, length, size, minVal, maxVal, color_bar, color_bg)
	monDrawLine(x, y, length, size, color_bg)
	local barSize = math.floor((minVal/maxVal)*length)
	monDrawLine(x, y, barSize, size, color_bar)
	local text = name.." "..math.floor((minVal/maxVal)*100).."%"
	monDrawText(monX/2, y+size/2, text, colors.black, colors.green)
end

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
	
	print(msg)
	
	state = l[8]
	
	if state == "start" then
		monClear()
		monDrawLine(0, 0, monX+1, 2, colors.gray)
		monDrawText(monX-4, 1, "Start", 2, colors.yellow, colors.white) 
	elseif state == "playing" then
		monClear()
		monDrawLine(0, 0, monX+1, 2, colors.gray)
		monDrawText(monX-6, 1, "Playing", 2, colors.green, colors.gray)
		monDrawText(1, 1, l[7], 2, colors.white, colors.gray)
		--monDrawProg(0, monY, "Played", monX+1, 1, l[5], l[6], colors.green, colors.gray)
		monDrawProg(0, 2, "Played", monX+1, 1, l[5], l[6], colors.green, colors.gray)
	elseif state == "stop" then
		monClear()
		monDrawLine(0, 0, monX+1, 2, colors.gray)
		monDrawText(monX-3, 1, "Stop", 2, colors.red, colors.white)
	end
end

monClear()
monDrawLine(0, 0, monX+1, 2, colors.gray)
monDrawText(monX-4, 1, "Ready", 2, colors.lime, colors.white)

while true do
    run()
end
