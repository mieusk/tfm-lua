--[[
inicio em 09/10/2021, por bloonshack
um modelo de "duvideodó" no transformice
--]]
--[[utilidade: 

ui.addTextArea(id, texto, player, x, y, largura, altura, corFundo, corBorda, binarioOpacidade, binarioPos)
function eventTextAreaCallback(id, p, name) end

]]
math.randomseed(os.time())
--mapa 
mapa = [[<C><P /><Z><S><S H="40" L="1600" o="214a25" X="400" c="3" Y="135" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="800" o="214a25" H="60" X="400" N="" Y="370" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S H="3000" L="200" o="6a7495" X="900" c="4" N="" Y="647" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="200" o="6a7495" X="-100" c="4" N="" Y="183" T="12" H="3000" /><S P="0,0,0,0.2,0,0,0,0" L="800" o="6a7495" X="400" c="4" N="" Y="-41" T="12" H="100" /><S P="0,0,0,9999,0,0,0,0" L="10" o="324650" H="265" Y="32" T="12" X="900" /><S L="10" o="324650" H="265" X="-100" Y="32" T="12" P="0,0,0,9999,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="3000" o="3488" X="425" c="2" Y="1501" T="12" m="" H="3000" /></S><D><P C="262626,4a2d10" Y="-1" T="117" X="0" P="0,0" /><P C="7f7f7f" Y="122" T="96" X="393" P="0,0" /><P C="437a46" Y="124" T="34" P="0,0" X="0" /><P X="400" Y="-18" T="112" P="0,0" /><P X="0" Y="148" T="17" P="0,0" /><P P="0,0" Y="148" T="17" X="100" /><P X="200" Y="148" T="17" P="0,0" /><P P="0,0" Y="148" T="17" X="300" /><P C="8a311b" Y="138" T="19" X="50" P="0,0" /><P X="400" Y="148" T="17" P="0,0" /><P C="8a311b" Y="138" T="19" X="190" P="0,0" /><P C="8a311b" Y="138" T="19" P="0,0" X="330" /><P P="0,0" Y="148" T="17" X="500" /><P X="600" Y="148" T="17" P="0,0" /><P C="8a311b" Y="138" T="19" X="470" P="0,0" /><P P="0,0" Y="148" T="17" X="700" /><P C="8a311b" Y="138" T="19" P="0,0" X="610" /><P X="800" Y="148" T="17" P="0,0" /><P C="8a311b" Y="138" T="19" P="0,0" X="750" /><DS Y="87" X="398" /><P P="0,0" Y="148" T="17" X="-100" /><P P="0,0" Y="148" T="17" X="900" /></D><O /></Z></C>]]

--desativa shaman, inicio de jogo, tempo, morte automática
for _, v in next, {'AutoShaman', 'AutoNewGame', 'AutoTimeLeft', 'AfkDeath'} do
    tfm.exec['disable' .. v]()
end

--tabelas do jogo
local vez = 1
modo = 'cadeira' --cadeira, inicio, mao, vez, duvida, fim
local jogadores = {} --{playername, cadeira, mao = {'A', 'Q'}, moedas}
local miniTime1 = {}
local miniTime2 = {}
local minicarta1 = {}
local minicarta2 = {}

--tabelas do baralho
local fundo = '0xFFFFFF' -- cor do fundo
local borda = '000066' -- cor da borda
local p = {'pA', 'p2', 'p3', 'p4', 'pQ'} -- valor de cada naipe Ꝺ 9ߤ  ↋ ↊ ∀
local o = {'oA', 'o2', 'o3', 'o4', 'oQ'}
local c = {'cA', 'c2', 'c3', 'c4', 'cQ'}
local e = {'eA', 'e2', 'e3', 'e4', 'eQ'} --temos agora 24 cartas, 6 de cada naipe: paus, ouros, copas e espadas

--simbolos de cada naipe para exibir no textarea
local size = 20
local pt = "<font color='#000000' size='"..size.."px'>&#9827;" -- preto
local ot = "<font color='#FF2222' size='"..size.."px'>&#9830;" -- vermelho
local ct = "<font color='#FF2222' size='"..size.."px'>&#9829;" -- vermelho
local et = "<font color='#000000' size='"..size.."px'>&#9824;" -- preto
local morto = "<font color='#000000' size='"..size.."px'>&#9760;" --caveira
local naipes = {pt, ot, ct, et}
--tabela
local txtVez = {'<font color="#000000" size="12px">Passar a vez (ganha 1 prata)', naipes[math.random(#naipes)]..'A', naipes[math.random(#naipes)]..'2', naipes[math.random(#naipes)]..'3', naipes[math.random(#naipes)]..'4', naipes[math.random(#naipes)]..'Q'}
--funções úteis
function shuffle(tbl)
	t = {}
	for i, v in ipairs(tbl) do
		local pos = math.random(1, #t+1)
		table.insert(t, pos, v)
	end
	return t
end
function merge(tbl1, tbl2, tbl3, tbl4) --me dá uma dica de como fazer essa mesma função sem encher linguiça
	t = {}
	for i=1, 4 do
		if i==1 then tbl = tbl1 elseif i==2 then tbl = tbl2 elseif i==3 then tbl = tbl3 elseif i==4 then tbl = tbl4 end
		for _,v in ipairs(tbl) do 
    		table.insert(t, v)
    	end
    end
    return t
end
function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end
function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end
function carta(cadeira, carta, posicao, morte)
	for i=1, #jogadores do
		if jogadores[i][2] == cadeira then
			jogador = jogadores[i][1]
		end
	end
	if string.starts(carta, 'p') and posicao == 1 and morte == false then
		carta = string.gsub(carta, 'p', '', 1)
		ui.addTextArea(11, "<a href='event:carta'>"..pt..carta, jogador, 20, 295, 60, 100, fundo, borda, 1, true)
	end
	if string.starts(carta, 'o') and posicao == 1 and morte == false then
		carta = string.gsub(carta, 'o', '', 1)
		ui.addTextArea(11, "<a href='event:carta'>"..ot..carta, jogador, 20, 295, 60, 100, fundo, borda, 1, true)
	end
	if string.starts(carta, 'c') and posicao == 1 and morte == false then
		carta = string.gsub(carta, 'c', '', 1)
		ui.addTextArea(11, "<a href='event:carta'>"..ct..carta, jogador, 20, 295, 60, 100, fundo, borda, 1, true)
	end
	if string.starts(carta, 'e') and posicao == 1 and morte == false then
		carta = string.gsub(carta, 'e', '', 1)
		ui.addTextArea(11, "<a href='event:carta'>"..et..carta, jogador, 20, 295, 60, 100, fundo, borda, 1, true)
	end
	if string.starts(carta, 'p') and posicao == 2 and morte == false then --pos == 2
		carta = string.gsub(carta, 'p', '', 1)
		ui.addTextArea(12, "<a href='event:carta'>"..pt..carta, jogador, 100, 295, 60, 100, fundo, borda, 1, true)
	end
	if string.starts(carta, 'o') and posicao == 2 and morte == false then
		carta = string.gsub(carta, 'o', '', 1)
		ui.addTextArea(12, "<a href='event:carta'>"..ot..carta, jogador, 100, 295, 60, 100, fundo, borda, 1, true)
	end
	if string.starts(carta, 'c') and posicao == 2 and morte == false then
		carta = string.gsub(carta, 'c', '', 1)
		ui.addTextArea(12, "<a href='event:carta'>"..ct..carta, jogador, 100, 295, 60, 100, fundo, borda, 1, true)
	end
	if string.starts(carta, 'e') and posicao == 2 and morte == false then
		carta = string.gsub(carta, 'e', '', 1)
		ui.addTextArea(12, "<a href='event:carta'>"..et..carta, jogador, 100, 295, 60, 100, fundo, borda, 1, true)
	end
	----------------------
	if string.starts(carta, 'p') and posicao == 1 and morte then
		carta = string.gsub(carta, 'p', '', 1)
		ui.addTextArea(11, pt..carta, jogador, 20, 295, 60, 100, 0x8B008B, borda, 1, true)
	end
	if string.starts(carta, 'o') and posicao == 1 and morte then
		carta = string.gsub(carta, 'o', '', 1)
		ui.addTextArea(11, ot..carta, jogador, 20, 295, 60, 100, 0x8B008B, borda, 1, true)
	end
	if string.starts(carta, 'c') and posicao == 1 and morte then
		carta = string.gsub(carta, 'c', '', 1)
		ui.addTextArea(11, ct..carta, jogador, 20, 295, 60, 100, 0x8B008B, borda, 1, true)
	end
	if string.starts(carta, 'e') and posicao == 1 and morte then
		carta = string.gsub(carta, 'e', '', 1)
		ui.addTextArea(11, et..carta, jogador, 20, 295, 60, 100, 0x8B008B, borda, 1, true)
	end
	if string.starts(carta, 'p') and posicao == 2 and morte then --pos == 2
		carta = string.gsub(carta, 'p', '', 1)
		ui.addTextArea(12, pt..carta, jogador, 100, 295, 60, 100, 0x8B008B, borda, 1, true)
	end
	if string.starts(carta, 'o') and posicao == 2 and morte then
		carta = string.gsub(carta, 'o', '', 1)
		ui.addTextArea(12, ot..carta, jogador, 100, 295, 60, 100, 0x8B008B, borda, 1, true)
	end
	if string.starts(carta, 'c') and posicao == 2 and morte then
		carta = string.gsub(carta, 'c', '', 1)
		ui.addTextArea(12, ct..carta, jogador, 100, 295, 60, 100, 0x8B008B, borda, 1, true)
	end
	if string.starts(carta, 'e') and posicao == 2 and morte then
		carta = string.gsub(carta, 'e', '', 1)
		ui.addTextArea(12, et..carta, jogador, 100, 295, 60, 100, 0x8B008B, borda, 1, true)
	end
end
function minicarta(cadeira, carta, posicao, morte) -- retorna a textarea
 	local size = 11 --vacilei
 	local pt = "<font color='#000000' size='10px'>&#9827;" -- preto
	local ot = "<font color='#FF2222' size='"..size.."px'>&#9830;" -- vermelho
	local ct = "<font color='#FF2222' size='9px'>&#9829;" -- vermelho
	local et = "<font color='#000000' size='"..size.."px'>&#9824;" -- preto
	for i=1, #jogadores do
		if jogadores[i][2] == cadeira then
			key = i
		end
	end
	if jogadores[key][3][posicao]:sub(1,1) == 'p' then
		naipe = pt 
	elseif jogadores[key][3][posicao]:sub(1,1) == 'o' then
		naipe = ot
	elseif jogadores[key][3][posicao]:sub(1,1) == 'c' then
		naipe = ct
	elseif jogadores[key][3][posicao]:sub(1,1) == 'e' then
		naipe = et
	end
	if morte then
		minifundo = 0x4B0082
	elseif morte == false then
		minifundo = 0xFFFFFF
	end
	if cadeira == 1 and posicao == 1 then
		ui.addTextArea(20, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 15, 40, 24, 40, minifundo, borda, 1, true)
		return 20
	elseif cadeira == 1 and posicao == 2 then
		ui.addTextArea(21, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 59, 40, 24, 40, minifundo, borda, 1, true)
		return 21
	elseif cadeira == 2 and posicao == 1 then
		ui.addTextArea(22, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 155, 40, 24, 40, minifundo, borda, 1, true)
		return 22
	elseif cadeira == 2 and posicao == 2 then
		ui.addTextArea(23, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 199, 40, 24, 40, minifundo, borda, 1, true)
		return 23
	elseif cadeira == 3 and posicao == 1 then
		ui.addTextArea(24, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 295, 40, 24, 40, minifundo, borda, 1, true)
		return 24
	elseif cadeira == 3 and posicao == 2 then
		ui.addTextArea(25, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 339, 40, 24, 40, minifundo, borda, 1, true)
		return 25
	elseif cadeira == 4 and posicao == 1 then
		ui.addTextArea(26, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 435, 40, 24, 40, minifundo, borda, 1, true)
		return 26
	elseif cadeira == 4 and posicao == 2 then
		ui.addTextArea(27, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 479, 40, 24, 40, minifundo, borda, 1, true)
		return 27
	elseif cadeira == 5 and posicao == 1 then
		ui.addTextArea(28, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 575, 40, 24, 40, minifundo, borda, 1, true)
		return 28
	elseif cadeira == 5 and posicao == 2 then
		ui.addTextArea(29, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 619, 40, 24, 40, minifundo, borda, 1, true)
		return 29
	elseif cadeira == 6 and posicao == 1 then
		ui.addTextArea(30, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 715, 40, 24, 40, minifundo, borda, 1, true)
		return 30
	elseif cadeira == 6 and posicao == 2 then
		ui.addTextArea(31, "<a href='event:carta'><font color='#000000' size='10px'>"..naipe..carta:sub(2,2), nil, 759, 40, 24, 40, minifundo, borda, 1, true)
		return 31
	end
end
function minhavez()
	ui.addTextArea(102, '<a href="event:super">', nil, 0, 0, 800, 400, 0x000011, borda, 0.4)
	do
		for i=1, 6 do
			for j=1, 2 do
				if jogadores[vez][3][j]:sub(1,1) == 'p' then
					naipe1 = pt 
				elseif jogadores[vez][3][j]:sub(1,1) == 'o' then
					naipe1 = ot
				elseif jogadores[vez][3][j]:sub(1,1) == 'c' then
					naipe1 = ct
				elseif jogadores[vez][3][j]:sub(1,1) == 'e' then
					naipe1 = et
				end
				if i == 2 and jogadores[vez][3][j]:sub(2,2) == 'A' then
					txtVez[i] = naipe1..jogadores[vez][3][j]:sub(2,2)
				elseif i == 3 and jogadores[vez][3][j]:sub(2,2) == '2' then
					txtVez[i] = naipe1..jogadores[vez][3][j]:sub(2,2)
				elseif i == 4 and jogadores[vez][3][j]:sub(2,2) == '3' then
					txtVez[i] = naipe1..jogadores[vez][3][j]:sub(2,2)
				elseif i == 5 and jogadores[vez][3][j]:sub(2,2) == '4' then
					txtVez[i] = naipe1..jogadores[vez][3][j]:sub(2,2)
				elseif i == 6 and jogadores[vez][3][j]:sub(2,2) == 'Q' then
					txtVez[i] = naipe1..jogadores[vez][3][j]:sub(2,2)
				end
			ui.addTextArea(0+i, '<a href="event:super">'..txtVez[i], jogadores[vez][1], 50-126.666666667+(i*126.666666667), 150, 60, 100, fundo, borda, 0.8)
			end
		end
	end
end
--embaralhamento e mão
local baralho = shuffle(merge(p, o, c, e)) --tudo embaralhado
totalplayers = 0 --eu tava fazendo e esqueci de colocar o naipe certo '-'
table.foreach(tfm.get.room.playerList, function() totalplayers = totalplayers+1 end)
print(totalplayers) --#tfm.get.room.playerList não funciona?

--funções do tfm
function eventNewPlayer(p)
	system.bindKeyboard(p, 32, true, true)
	tfm.exec.respawnPlayer(p)
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)

function eventChatCommand(p, c)
	if c == 'print' then
		for _, v in pairs(jogadores) do
			print(v[1])
		end
	end
end

function eventKeyboard(p, k, d, x, y)
	for _, v in pairs(jogadores) do
		if v[1] == p then return end
	end
	if k == 32 and modo == 'cadeira' then
		if x > 25 and x < 75 and jogadores[1] == nil then --cadeira 1
			table.insert(jogadores, #jogadores+1, {p, 1, {baralho[1], baralho[2]}, 2})
			table.remove(baralho, 1)
			table.remove(baralho, 2)
			ui.addTextArea(1, "<p align='center'><font size='12' color='#BABD2F'>"..p, nil, -20, 122, 140, 100, nil, nil, 0, false)
		elseif x > 165 and x < 215 and jogadores[2] == nil then
			table.insert(jogadores, #jogadores+1, {p, 2, {baralho[3], baralho[4]}, 2})
			table.remove(baralho, 3)
			table.remove(baralho, 4)
			ui.addTextArea(2, "<p align='center'><font size='12' color='#BABD2F'>"..p, nil, 120, 122, 140, 100, nil, nil, 0, false)
		elseif x > 305 and x < 355 and jogadores[3] == nil then
			table.insert(jogadores, #jogadores+1, {p, 3, {baralho[5], baralho[6]}, 2})
			table.remove(baralho, 5)
			table.remove(baralho, 6)
			ui.addTextArea(3, "<p align='center'><font size='12' color='#BABD2F'>"..p, nil, 260, 122, 140, 100, nil, nil, 0, false)
		elseif x > 445 and x < 495 and jogadores[4] == nil then
			table.insert(jogadores, #jogadores+1, {p, 4, {baralho[7], baralho[8]}, 2})
			table.remove(baralho, 7)
			table.remove(baralho, 8)
			ui.addTextArea(4, "<p align='center'><font size='12' color='#BABD2F'>"..p, nil, 400, 122, 140, 100, nil, nil, 0, false)
		elseif x > 585 and x < 635 and jogadores[5] == nil then
			table.insert(jogadores, #jogadores+1, {p, 5, {baralho[9], baralho[10]}, 2})
			table.remove(baralho, 9)
			table.remove(baralho, 10)
			ui.addTextArea(5, "<p align='center'><font size='12' color='#BABD2F'>"..p, nil, 540, 122, 140, 100, nil, nil, 0, false)
		elseif x > 725 and x < 775 and jogadores[6] == nil then --cadeira 6
			table.insert(jogadores, #jogadores+1, {p, 6, {baralho[11], baralho[12]}, 2})
			table.remove(baralho, 11)
			table.remove(baralho, 12)
			ui.addTextArea(6, "<p align='center'><font size='12' color='#BABD2F'>"..p, nil, 680, 122, 140, 100, nil, nil, 0, false)
		end
	end
end
--conta o tempo
local time = 0
local totalTime = os.time()

function eventLoop()
	if os.time() >= totalTime+(1000) then
		totalTime = os.time()
		time = time+1
		if modo == 'cadeira' then
			ui.addTextArea(0, '<p align="center"><font size="16" color="#ED67EA">'..8-time, nil, 375, 20, 50, 20, nil, nil, 0.5)
		end
		if modo == 'vez' then
			ui.addTextArea(0, '<p align="center"><font size="16" color="#ED67EA">'..4-time, nil, 375, 20, 50, 20, nil, nil, 0.5)
		end
		if modo == 'mao' then
			ui.addTextArea(0, '<p align="center"><font size="16" color="#ED67EA">'..5-time, nil, 375, 20, 50, 20, nil, nil, 0.5)
		end
	end
	if time == 8 and modo == 'cadeira' then
		modo = 'inicio'
		time = 0
	end
	if modo == 'inicio' then
		modo = 'vez'
		time = 0
		totalTime = os.time()
		for _, v in ipairs(jogadores) do
			ui.addTextArea(90, "<p align='center'><a href='event:moedas'><font size='12' color='#FFFF00'>§</font> <font size='10'>Pratas: <font face='lucida console' size='12' color='#00BFFF'>"..v[4], v[1], 40, 165, 100, 20, 0x000011, 0xFFFF00, 0.1, true)
			ui.addTextArea(41, '<p align="center"><font size="13" color="#30BA76">São suas cartas:', v[1], 20, 260, 140, 100, nil, nil, 0)
			carta(v[2], v[3][1], 1, false)
			carta(v[2], v[3][2], 2, false)
		end
	end
	if time > 3.5 and modo == 'vez' then
		modo = 'mao'
		time = 0
		totalTime = os.time()
		for i=1, #jogadores do
			if jogadores[i] == nil then else
				local id = 110+(jogadores[i][2])
				local x = -140-20+(jogadores[i][2]*140)
				ui.addTextArea(id, "<p align='center'><font size='12' color='#FFFF00'>§</font> <font face='lucida console' size='12' color='#00BFFF'>"..jogadores[i][4], nil, x, 136, 140, 100, nil, nil, 0, false)
			end
		end
		if jogadores[vez][2] == 1 then
			ui.addTextArea(jogadores[vez][2], "<p align='center'><font size='12' color='#40E0D0'>"..jogadores[vez][1], nil, -20, 118, 140, 100, nil, nil, 0, false)
		end
		if jogadores[vez][2] == 2 then
			ui.addTextArea(jogadores[vez][2], "<p align='center'><font size='12' color='#40E0D0'>"..jogadores[vez][1], nil, 120, 118, 140, 100, nil, nil, 0, false)
		end
		if jogadores[vez][2] == 3 then
			ui.addTextArea(jogadores[vez][2], "<p align='center'><font size='12' color='#40E0D0'>"..jogadores[vez][1], nil, 260, 118, 140, 100, nil, nil, 0, false)
		end
		if jogadores[vez][2] == 4 then
			ui.addTextArea(jogadores[vez][2], "<p align='center'><font size='12' color='#40E0D0'>"..jogadores[vez][1], nil, 400, 118, 140, 100, nil, nil, 0, false)
		end
		if jogadores[vez][2] == 5 then
			ui.addTextArea(jogadores[vez][2], "<p align='center'><font size='12' color='#40E0D0'>"..jogadores[vez][1], nil, 540, 118, 140, 100, nil, nil, 0, false)
		end
		if jogadores[vez][2] == 6 then
			ui.addTextArea(jogadores[vez][2], "<p align='center'><font size='12' color='#98E2EB'>"..jogadores[vez][1], nil, 680, 118, 140, 100, nil, nil, 0, false)
		end
		if vez == #jogadores then vez = 1 end
	end
	if modo == 'mao' then
		time = 0
		modo = 'duvida' --💰
		ui.addTextArea(100, "<p align='center'><font size='16'><br><a href='event:monte'>✪<br><font size='10'>Comprar", nil, 370, 200, 60, 100, 0x000011, borda, 1, true)
		--✪
		ui.addTextArea(101, "<p align='center'><a href='event:skip'>É minha vez", jogadores[vez][1], 300, 320, 200, 20, 1, 1, 0.7, true)
		for i=1, #jogadores do
			if i < #jogadores then
				if jogadores[i][2] ~= vez then
					vez = vez+1
				end
			else
				vez = 1
			end
		end
	end
	if minicarta1 ~= nil then
		for k, v in pairs(minicarta1) do
			if minicarta1[k] ~= nil then
				miniTime1[k] = miniTime1[k]+0.5
			end
			if miniTime1[k] >= 2 then
				miniTime1[k] = 0
				ui.removeTextArea(minicarta1[k], nil)
				minicarta1[k] = nil
				return
			end
		end
	end
	if minicarta1 ~= nil then
		for k, v in pairs(minicarta2) do
			if minicarta2[k] ~= nil then
				miniTime2[k] = miniTime2[k]+0.5
			end
			if miniTime2[k] >= 2 then
				miniTime2[k] = 0
				ui.removeTextArea(minicarta2[k], nil)
				minicarta2[k] = nil
				return
			end
		end
	end
end

function eventTextAreaCallback(id, p, name) --1~6 nomes 11-12 cartas 20~31 minicartas 41~50 avisos 100-101 monte 111~116 pratas
	for i=1, #jogadores do 
		if jogadores[i][1] == p then
			callback_cadeira = jogadores[i][2]
			callback_key = i
		end
	end
	if id == 11 then
		miniTime1[p] = 0
		minicarta1[p] = minicarta(callback_cadeira, jogadores[callback_key][3][1], 1, false) --cadeira, carta, posicao, morte
		if p == jogadores[vez][1] then
		end
	end
	if id == 12 then
		miniTime2[p] = 0
		minicarta2[p] = minicarta(callback_cadeira, jogadores[callback_key][3][2], 2, false) --cadeira, carta, posicao, morte
		if p == jogadores[vez][1] then
		end
	end
	if id == 101 and p == jogadores[vez][1] then --é minha vez
		minhavez()
	end
end

function eventPlayerDied(p)
	tfm.exec.respawnPlayer(p)
end
tfm.exec.newGame(mapa)