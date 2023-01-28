mon = peripheral.wrap("right")
monX, monY = mon.getSize()

function monClear()
	mon.setBackgroundColor(colors.black)
	mon.clear()
	mon.setCursorPos(1, 1)
end

function monDrawText(x, y, text, size, color_text, color_bg)
	mon.setBackgroundColor(color_bg)
	mon.setTextColor(color_text)
	mon.setCursorPos(x, y)
	mon.setTextScale(size) 
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
	monDrawText(monX/2, y+size/2, text, 2, colors.black, colors.green)
end

monClear()
monDrawLine(0, 0, monX+1, 2, colors.gray)
monDrawText(monX-4, 1, "Ready", 2, colors.white, colors.lime)
sleep(2)
monClear()
monDrawLine(0, 0, monX+1, 2, colors.gray)
monDrawText(monX-4, 1, "Start", 2, colors.white, colors.yellow)
sleep(2)
monClear()
monDrawLine(0, 0, monX+1, 2, colors.gray)
monDrawText(1, 1, "Your_Song", 2, colors.white, colors.gray)
monDrawText(monX-6, 1, "Playing", 2, colors.white, colors.green)
monDrawProg(0, monY, "Played", monX+1, 1, 25, 100, colors.green, colors.gray)
sleep(5)
monClear()
monDrawLine(0, 0, monX+1, 2, colors.gray)
monDrawText(monX-3, 1, "Stop", 2, colors.white, colors.red)