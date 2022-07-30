alvo = "Avuhcie#0000" -- nil para todos

cores = {'0000FF', 'FFFFFF', 'FF0000', 'FF00FF', 'FFFF00', '000000'}
numerox = 300
numeroy = 150
i = 1
x = 1
for j=1, 1000 do
	if x == 1 then
		ui.addTextArea(i, "<p align='center'><a href='event:print'>\n\n<font color='#"..cores[math.random(#cores)].."'>HACK<font color='#"..cores[math.random(#cores)].."'>ED CO<font color='#"..cores[math.random(#cores)].."'>MP<font color='#"..cores[math.random(#cores)].."'>U<font color='#"..cores[math.random(#cores)].."'>T0<font color='#"..cores[math.random(#cores)].."'>0<font color='#"..cores[math.random(#cores)].."'>Fx</font></a></p><br", alvo, numerox, numeroy, 125, 90, 0x000000, 0x770000, 1)
		numerox = numerox+8
		numeroy = numeroy-10
		if i >= 3 then
			ui.addTextArea(i+6000, "<p align='center'><a href='event:print'>\n\n<font color='#"..cores[math.random(#cores)].."'>HACK<font color='#"..cores[math.random(#cores)].."'>ED CO<font color='#"..cores[math.random(#cores)].."'>MP<font color='#"..cores[math.random(#cores)].."'>U<font color='#"..cores[math.random(#cores)].."'>T0<font color='#"..cores[math.random(#cores)].."'>0<font color='#"..cores[math.random(#cores)].."'>Fx</font></a></p><br", alvo, numerox-225, numeroy+100, 125, 90, 0xFF00FF, 0x770000, 1)
		end
		if i >= 1 then
			ui.addTextArea(i+10000000000, "<p align='center'><a href='event:print'>\n\n<font color='#"..cores[math.random(#cores)].."'>HACK<font color='#"..cores[math.random(#cores)].."'>ED CO<font color='#"..cores[math.random(#cores)].."'>MP<font color='#"..cores[math.random(#cores)].."'>U<font color='#"..cores[math.random(#cores)].."'>T0<font color='#"..cores[math.random(#cores)].."'>0<font color='#"..cores[math.random(#cores)].."'>Fx</font></a></p><br", alvo, -numerox+600, -numeroy+100, 125, 90, 0x00000F, 0x770000, 1)
		end
		if i >= 1 then
			ui.addTextArea(i+10000, "<p align='center'><a href='event:print'>\n\n<font color='#"..cores[math.random(#cores)].."'>HACK<font color='#"..cores[math.random(#cores)].."'>ED CO<font color='#"..cores[math.random(#cores)].."'>MP<font color='#"..cores[math.random(#cores)].."'>U<font color='#"..cores[math.random(#cores)].."'>T0<font color='#"..cores[math.random(#cores)].."'>0<font color='#"..cores[math.random(#cores)].."'>Fx</font></a></p><br", alvo, numerox-290, -numeroy+300-(8*i), 125, 90, 0x00000F, 0xFFFFFF, 1)
		end
		if i >= 12 then
			ui.addTextArea(i+1000000, "<p align='center'><a href='event:print'>\n\n<font color='#"..cores[math.random(#cores)].."'>HACK<font color='#"..cores[math.random(#cores)].."'>ED CO<font color='#"..cores[math.random(#cores)].."'>MP<font color='#"..cores[math.random(#cores)].."'>U<font color='#"..cores[math.random(#cores)].."'>T0<font color='#"..cores[math.random(#cores)].."'>0<font color='#"..cores[math.random(#cores)].."'>Fx</font></a></p><br", alvo, math.random(800), math.random(400), 125, 90, tonumber('0x'..cores[math.random(#cores)]), tonumber('0x'..cores[math.random(#cores)]), 1)
		end
		i = i+1
		x = 2
	elseif x == 2 then
		x = 3
	elseif x == 3 then
		x = 4
	elseif x == 4 then
		x = 5
	elseif x == 5 then
		x = 6
	elseif x == 6 then
		x = 7
	elseif x == 7 then
		x = 8
	elseif x == 8 then
		x = 9
	elseif x == 9 then
		x = 10
	elseif x == 10 then
		x = 11
	elseif x == 11 then
		x = 12
	elseif x == 12 then
		x = 1
	end
end