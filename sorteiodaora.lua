---@autor Avuhcie#0000
---@descrição script de sorteio
---@créditos Ninguem#0095 pela versão anterior e pela função nineSlicedRect

local comunidade = 'br' --put "en" if you speak english to start with english

--otimizações
local tfm, ui, coroutine, string, table, math = tfm, ui, coroutine, string, table, math

math.randomseed(math.random()*os.time()*math.random(100))

--gera o adm do script de acordo com quem o carregou
local chefe = (debug.traceback()):match('(%w*%#%d+)')

--edite aqui
local mapa = '@7923684'
local ganhadoresNumero = 1
local premio = 'prêmio indefinido'

--desativa umas coisas
do 
	local desativar = {'AutoShaman', 'AutoNewGame', 'AutoTimeLeft', 'AfkDeath', 'AutoScore'}
   for i=1, #desativar do
      tfm.exec['disable'..desativar[i]]()
   end
end

local participantes = {}
local ganhadores = {}

local index = {}

local nineSlicedRect
local fatias = {
   {img="17f85ff6afb.png", w=28, h=29},
   {img="17f86018555.png", w=8, h=29},
   {img="17f8601f67b.png", w=28, h=29},
   {img="17f860256e6.png", w=28, h=4},
   {img="17f8602b3f0.png", w=8, h=4},
   {img="17f86038225.png", w=28, h=4},
   {img="17f8603de5f.png", w=28, h=29},
   {img="17f86043b4a.png", w=8, h=29},
   {img="17f86049374.png", w=28, h=29}
}
do
	nineSlicedRect = function(source, target, targetPlayer, x, y, width, height) --por Ninguem#0095
   	return {
   	   tfm.exec.addImage (source[1].img, target, x, y, targetPlayer, 1, 1),
   	   tfm.exec.addImage (source[2].img, target, x+source[1].w, y, targetPlayer, (width-source[1].w-source[3].w)/source[2].w, 1),
   	   tfm.exec.addImage (source[3].img, target, x+width-source[3].w, y, targetPlayer, 1, 1),
   	   tfm.exec.addImage (source[4].img, target, x, y+source[1].h, targetPlayer, 1, (height-source[1].h-source[7].h)/source[4].h),
   	   tfm.exec.addImage (source[5].img, target, x+source[1].w, y+source[1].h, targetPlayer, (width-source[1].w-source[3].w)/source[2].w, (height-source[1].h-source[7].h)/source[4].h),
   	   tfm.exec.addImage (source[6].img, target, x+width-source[6].w, y+source[1].h, targetPlayer, 1, (height-source[1].h-source[7].h)/source[4].h),
   	   tfm.exec.addImage (source[7].img, target, x, y+height-source[7].h, targetPlayer, 1, 1),
   	   tfm.exec.addImage (source[8].img, target, x+source[7].w, y+height-source[8].h, targetPlayer, (width-source[1].w-source[3].w)/source[2].w, 1),
   	   tfm.exec.addImage (source[9].img, target, x+width-source[9].w, y+height-source[9].h, targetPlayer, 1, 1)
   	}
	end
end

local removerTextArea


local lingua = {
	['br'] = {
		'Org.',
		'Prêmio',
		'Número de participantes',
		'<font color="#FDFDFE" size="16" face="Lucida Console"><font color="#ED67EA" size="22" face="Trebuchet MS"><p align="center"><b>GANHADOR(ES):</b></p></font>\n<p align="center">',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b><a href="event:definirPremio">Prêmio</a></b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b><a href="event:definirNumeroDeGanhadores">Número de Ganhadores</a></b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b><a href="event:darPosse">Dar posse</a></b></font></p>',
		'<p align="center"><font color="#FFD700" size="16" face="Trebuchet MS"><b>Configurações disponíveis:</b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b><a href="event:setEnglish">English</a></b></font></p>',
		'<font size="14" face="Trebuchet MS" color="#FFD700"><b>Participando!</b></font>',
		'<font size="14" face="Trebuchet MS" color="#55557A"><b>Sorteio em andamento...</b></font>',
		'<p align="center"><font color="#55557A" size="14" face="Trebuchet MS"><b>Iniciar</b></font></p>',
		'Selecione o número de ganhadores',
		'Selecione o título do sorteio',
		'<font size="14" face="Trebuchet MS" color="#ED67EA"><b>Finalizado!</b></font>',
		'Ganhadores:',
		'<font size="14" face="Trebuchet MS" color="#55557A"><b>O sorteio já começou.</b></font>',
		'<p align="center"><font color="#55557A" size="14" face="Trebuchet MS"><b>Iniciar</b></font></p>',
		'<font size="14" face="Trebuchet MS" color="#00FF7F"><b>Clique para participar!</b></font>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b>Iniciar</b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b>Configurações</b></font></p>',
		'<font size="14" face="Trebuchet MS" color="#00FF7F"><b>Clique para participar!</b></font>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b>Iniciar</b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b>Configurações</b></font></p>',
		'O novo organizador do sorteio:',
		'<b>Ganhadores: <font color="#ED67EA">%s</font></b>'
	},
	['en'] = {
		'Org.',
		'Prize',
		'Participants',
		'<font color="#FDFDFE" size="16" face="Lucida Console"><font color="#ED67EA" size="22" face="Trebuchet MS"><p align="center"><b>WINNER(S):</b></p></font>\n<p align="center">',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b><a href="event:definirPremio">Prize</a></b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b><a href="event:definirNumeroDeGanhadores">Number of Winners</a></b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b><a href="event:darPosse">Transfer Host</a></b></font></p>',
		'<p align="center"><font color="#FFD700" size="16" face="Trebuchet MS"><b>Available configurations:</b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b><a href="event:definirPortugues">Português</a></b></font></p>',
		'<font size="14" face="Trebuchet MS" color="#FFD700"><b>You\'ve joined!</b></font>',
		'<font size="14" face="Trebuchet MS" color="#55557A"><b>Running the giveaway...</b></font>',
		'<p align="center"><font color="#55557A" size="14" face="Trebuchet MS"><b>Start</b></font></p>',
		'Set number of winners',
		'Set giveaway title',
		'<font size="14" face="Trebuchet MS" color="#ED67EA"><b>Ended!</b></font>',
		'Winners:',
		'<font size="14" face="Trebuchet MS" color="#55557A"><b>The giveaway already started.</b></font>',
		'<p align="center"><font color="#55557A" size="14" face="Trebuchet MS"><b>Start</b></font></p>',
		'<font size="14" face="Trebuchet MS" color="#00FF7F"><b>Click to join!</b></font>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b>Start</b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b>Configurations</b></font></p>',
		'<font size="14" face="Trebuchet MS" color="#00FF7F"><b>Click to join!</b></font>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b>Start</b></font></p>',
		'<p align="center"><font color="#FDFDFE" size="14" face="Trebuchet MS"><b>Configurations</b></font></p>',
		'The new scheduler of the script:',
		'<b>Winners: <font color="#ED67EA">%s</font></b>'
	}
}

local tabelaTamanho = function(tabela)
	local tamanho = 0
	for _ in next, tabela do tamanho = tamanho+1 end
	return tamanho
end

local dados
do 
	local arquivos = {}
	dados = function()
		local _dados = {}
		local info = {
			{lingua[comunidade][1], '<font face="lucida console" size="12">'..chefe..'</font>'},
			{lingua[comunidade][2], '<font face="lucida console" size="12">'..premio..'</font>'},
			{lingua[comunidade][3], '<font face="lucida console">'..tabelaTamanho(participantes)..'</font>'}
		}
		for i=1, #arquivos do
			tfm.exec.removeImage(arquivos[i], false)
		end
		arquivos = {}
		if premio:len() < 19 then
			arquivos = nineSlicedRect(fatias, '!1', nil, 0, 20, 207, 74)
		else
			arquivos = nineSlicedRect(fatias, '!1', nil, 0, 20, 75+(premio:len()*7), 74)
		end
		for i=1, #info do
			_dados[#_dados+1] = '<font color="#FDFDFE" size="13" face="Trebuchet MS"><b>'..info[i][1]..'</b>: '..info[i][2]
		end
		return _dados
	end
end

	

---@textAreas
--[[
	1 = dados
	2 = participar
	3 = abrir participantes
	4 = participantes
	5 = iniciar
	6 = ganhadores
	7 = configurações
]]

local idEspecial, premioImagem, slice, iniciarSlice = {}, {}, {}, {}
do
	idEspecial = { --executa algo quando uma textarea é chamada
		[2] = function(alvo)
			slice = nineSlicedRect(fatias, '!1', alvo, 0, 342, 207, 56)
			ui.addTextArea(-2, '<font size="16"><a href="event:entrar">ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ</a></font>', alvo, 10, 362, nil, nil, 0x0, 0x0, 1, true)
		end,
		[5] = function(alvo)
			for i=1, #iniciarSlice do
				tfm.exec.removeImage(iniciarSlice[i])
			end
			removerTextArea(8, nil, 9, 10, 11, 12)
			iniciarSlice = nineSlicedRect(fatias, '!1', alvo, 0, 92, 207, 56)
			ui.addTextArea(-5, '<font size="16"><a href="event:iniciar">ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ</a></font>', alvo, 10, 112, nil, nil, 1, 1, 0, true)
		end,
		[7] = function(alvo)
			for i=1, #premioImagem do
				tfm.exec.removeImage(premioImagem[i])
			end
			premioImagem = nineSlicedRect(fatias, '!1', alvo, 0, 92+55, 207, 56)
			ui.addTextArea(-7, '<font size="16"><a href="event:abrirConfig">ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ</a></font>', alvo, 10, 112+55, nil, nil, 1, 1, 0, true)
		end
	}
end

--pra não dar erro qnd chamar nil 165e2e4d8e2.png
setmetatable(idEspecial, {__index = function() return function() end end})

local textAreas = function(id, alvo, textoAuxiliar)
	local textoAuxiliar = textoAuxiliar or ''
	local cor = {'9400D3','4B0082','0000FF', '00FFFF', '00FF00', 'FFFF00', 'FF7F00', 'FF0000', 'FF0382'}
	return ({
		{1, table.concat(dados(), '\n'), alvo, 10, 30, nil, nil, 0x0, 0x0, 1, true},
		{2, '<p align="center">'..textoAuxiliar..'</p>', alvo, 15, 362, 180, nil, 0x0, 0x0, 1, true},
		{3, '<p align="center">'..textoAuxiliar..'</p>', alvo, 15, 362, 180, nil, 0x0, 0x0, 1, true},
		{4, '<p align="center">'..textoAuxiliar..'</p>', alvo, 15, 362, 180, nil, 0x0, 0x0, 1, true},
		{5, textoAuxiliar, alvo, 15, 112, 180, nil, 0x0, 0x0, 1, true},
		{6, lingua[comunidade][4]..table.concat(ganhadores, '<b>, </b>'), alvo, 208+25, 108+18, 536, nil, -1, tonumber('0x'..cor[math.random(#cor)]), 1, true},
		{7, textoAuxiliar, alvo, 15, 112+54, 180, nil, 0x0, 0x0, 1, true},
		{8, lingua[comunidade][5], alvo, 310, 178+10, 180, nil, 0x0, 0x0, 1, true},
		{9, lingua[comunidade][6], alvo, 310, 178+46, 180, nil, 0x0, 0x0, 1, true},
		{10, lingua[comunidade][7], alvo, 310, 178+82, 180, nil, 0x0, 0x0, 1, true},
		{11, lingua[comunidade][8], alvo, 290, 178-40, 220, nil, 0x0, 0x0, 1, true},
		{12, lingua[comunidade][9], alvo, 310, 178+118, 180, nil, 0x0, 0x0, 1, true},
		{13, '<font size="18"><a href="event:fecharConfig">ㅤㅤ</a></font>', alvo, 545, 110, nil, nil, 0x0, 0x0, 1, true}
	})[id]
end

local carregarTextArea = function(id, alvo, textoAuxiliar, ...)
	ui.addTextArea(table.unpack(textAreas(id, alvo, textoAuxiliar)))
	idEspecial[id](alvo)
	if ... then
		local argumentos = {...}
		for i=1, #argumentos do
			ui.addTextArea(table.unpack(textAreas(argumentos[i], alvo)))
			idEspecial[argumentos[i]](alvo)
		end
	end
end

removerTextArea = function(id, alvo, ...)
	ui.removeTextArea(id, alvo)
	if ... then
		local argumentos = {...}
		for i=1, #argumentos do
			ui.removeTextArea(argumentos[i], alvo)
		end
	end
end

local selecionar = function(t)
	local t = t
   for i = #t, 2, -1 do
      local j = math.random(i)
      t[i], t[j] = t[j], t[i]
   end
   return t[math.random(#t)]
end

local _modo = 'nenhum' --'nenhum', 'inicio', 'final'

local callback, imageDaConfiguracao
do
	callback = {
		entrar = function(nome)
			participantes[nome] = true
			index[#index+1] = nome
			carregarTextArea(1)
			carregarTextArea(2, nome, lingua[comunidade][10])
			removerTextArea(-2, nome)
		end,
		iniciar = function()
			removerTextArea(7)
			removerTextArea(-7)
			_modo = 'inicio'
			carregarTextArea(2, nil, lingua[comunidade][11])
			carregarTextArea(5, chefe, lingua[comunidade][12])
			removerTextArea(-5, nil, '', -2)
		end,
		abrirConfig = function()
			if imageDaConfiguracao then tfm.exec.removeImage(imageDaConfiguracao) end
			imageDaConfiguracao = tfm.exec.addImage('17290d6d18e.png', '!92', 800/2, 400/2+30, chefe, 0.95, 0.95, nil, nil, 0.5, 0.5)
			carregarTextArea(8, chefe)
			carregarTextArea(9, chefe)
			carregarTextArea(10, chefe)
			carregarTextArea(11, chefe)
			carregarTextArea(12, chefe)
			carregarTextArea(13, chefe)
		end,
		fecharConfig = function()
			tfm.exec.removeImage(imageDaConfiguracao)
			removerTextArea(8, nil, 9, 10, 11, 12, 13)
		end,
		definirNumeroDeGanhadores = function()
			ui.addPopup(2, 2, lingua[comunidade][13], chefe, 400-100, 200-50, 200, true)
		end,
		definirPremio = function()
			ui.addPopup(1, 2, lingua[comunidade][14], chefe, 400-100, 200-50, 200, true)
		end,
		setEnglish = function()
			for i=1, #premioImagem do
				tfm.exec.removeImage(premioImagem[i])
			end
			for i=1, #slice do
				tfm.exec.removeImage(slice[i])
			end
			tfm.exec.removeImage(imageDaConfiguracao)
			removerTextArea(8, nil, 9, 10, 11, 12, 13)
			comunidade = 'en'
			for k in next, tfm.get.room.playerList do
				eventNewPlayer(k)
			end
			ui.setMapName(lingua[comunidade][26]:format(ganhadoresNumero))
		end,
		darPosse = function()
			ui.addPopup(3, 2, lingua[comunidade][25], chefe, 400-100, 200-50, 200, true)
		end,
		definirPortugues = function()
			for i=1, #premioImagem do
				tfm.exec.removeImage(premioImagem[i])
			end
			for i=1, #slice do
				tfm.exec.removeImage(slice[i])
			end
			tfm.exec.removeImage(imageDaConfiguracao)
			removerTextArea(8, nil, 9, 10, 11, 12, 13)
			comunidade = 'br'
			ui.setMapName(lingua[comunidade][26]:format(ganhadoresNumero))
			for k in next, tfm.get.room.playerList do
				eventNewPlayer(k)
			end
		end
	}
end

local primeiraVez = true
local particula = {1, 2, 9, 21, 22, 23, 24, 29, 31, 33, 34, 39, 43}
local particulaFEscolhida = particula[math.random(#particula)]

local sorteiozinho = coroutine.create(function()
	while true do
		if _modo == 'inicio' then
			if primeiraVez then
				for i=1, #premioImagem do
					tfm.exec.removeImage(premioImagem[i], false)
				end
				ui.addPopup(1, 1, '', nil, 999999, -999999)
				ui.addPopup(2, 1, '', nil, 999999, -999999)
				ui.addPopup(3, 1, '', nil, 999999, -999999)
			end
			if tabelaTamanho(participantes) < 8 then
				for k in next, participantes do
					if math.random(0, 100) > 40/tabelaTamanho(participantes) then
						local ratoX = tfm.get.room.playerList[k].x
						local ratoY = tfm.get.room.playerList[k].y
						local particulaEscolhida = particula[math.random(#particula)] 
						for i=1, 360/6, 6 do
							tfm.exec.displayParticle(particulaEscolhida, ratoX+(math.sin(math.rad(i*6))*36)-(5), ratoY+(math.cos(math.rad(i*6))*36)-(5), -((math.sin(math.rad(i*6))*36)-(5))/32, -((math.cos(math.rad(i*6))*36)-(5))/32)
						end
					end
				end
			else
				for k in next, participantes do
					if math.random(0, 100) > 40/tabelaTamanho(participantes) then
						local ratoX = tfm.get.room.playerList[k].x
						local ratoY = tfm.get.room.playerList[k].y
						local particulaEscolhida = particula[math.random(#particula)] 
						for i=1, 360/8, 8 do
							tfm.exec.displayParticle(particulaEscolhida, ratoX+(math.sin(math.rad(i*8))*36)-(5), ratoY+(math.cos(math.rad(i*8))*36)-(5), -((math.sin(math.rad(i*8))*36)-(5))/32, -((math.cos(math.rad(i*8))*36)-(5))/32)
						end
					end
				end
			end
		elseif _modo == 'final' then
			if primeiraVez then
				primeiraVez = false
				for i=1, ganhadoresNumero do
					ganhadores[#ganhadores+1] = selecionar(index)
				end
				carregarTextArea(2, nil, lingua[comunidade][15])
				removerTextArea(-2, nil)
				print(lingua[comunidade][16])
				for i=1, #ganhadores do
					tfm.exec.giveCheese(ganhadores[i])
					print(ganhadores[i])
				end
			end
			carregarTextArea(6)
			do
				for i=1, 64 do
					tfm.exec.displayParticle(math.random(21, 24), math.random(800), 18, math.abs(math.sin(math.random(90, 120)))/4, math.abs(math.cos(math.random(90, 120)))/4, math.abs(math.asin(math.random(90, 120)))/4, math.abs(math.sin(math.random(90, 120)))/4)
				end
				if #ganhadores < 2 then
					for i=1, #ganhadores do
						if tfm.get.room.playerList[ganhadores[i]] ~= nil then
							local ratoX = tfm.get.room.playerList[ganhadores[i]].x
							local ratoY = tfm.get.room.playerList[ganhadores[i]].y
							for i=1, 360/5, 5 do
								tfm.exec.displayParticle(particulaFEscolhida, ratoX+(math.sin(math.rad(i*5))*48)-(2), ratoY+(math.cos(math.rad(i*5))*48)-(2), ((math.sin(math.rad(i*5))*48)-(5))/32, ((math.cos(math.rad(i*5))*48)-(5))/32)
								tfm.exec.displayParticle(particulaFEscolhida, ratoX+(math.sin(math.rad(i*5))*36)-(2), ratoY+(math.cos(math.rad(i*5))*36)-(2), ((math.sin(math.rad(i*5))*36)-(5))/32, ((math.cos(math.rad(i*5))*36)-(5))/32)
								tfm.exec.displayParticle(particulaFEscolhida, ratoX+(math.sin(math.rad(i*5))*24)-(2), ratoY+(math.cos(math.rad(i*5))*24)-(2), ((math.sin(math.rad(i*5))*24)-(5))/32, ((math.cos(math.rad(i*5))*24)-(5))/32)
							end
						end
					end
				elseif #ganhadores < 10 then
					for i=1, #ganhadores do
						if tfm.get.room.playerList[ganhadores[i]] ~= nil then
							local ratoX = tfm.get.room.playerList[ganhadores[i]].x
							local ratoY = tfm.get.room.playerList[ganhadores[i]].y
							for i=1, 360/6, 6 do
								tfm.exec.displayParticle(particulaFEscolhida, ratoX+(math.sin(math.rad(i*6))*36)-(2), ratoY+(math.cos(math.rad(i*6))*36)-(2), ((math.sin(math.rad(i*6))*36)-(5))/32, ((math.cos(math.rad(i*6))*36)-(5))/32)
								tfm.exec.displayParticle(particulaFEscolhida, ratoX+(math.sin(math.rad(i*6))*24)-(2), ratoY+(math.cos(math.rad(i*6))*24)-(2), ((math.sin(math.rad(i*6))*24)-(5))/32, ((math.cos(math.rad(i*6))*24)-(5))/32)
							end
						end
					end
				else
					for i=1, #ganhadores do
						if tfm.get.room.playerList[ganhadores[i]] ~= nil then
							local ratoX = tfm.get.room.playerList[ganhadores[i]].x
							local ratoY = tfm.get.room.playerList[ganhadores[i]].y
							for i=1, 360/8, 8 do
								tfm.exec.displayParticle(particulaFEscolhida, ratoX+(math.sin(math.rad(i*8))*24)-(6), ratoY+(math.cos(math.rad(i*8))*24)-(6), ((math.sin(math.rad(i*4))*24)-(5))/32, ((math.cos(math.rad(i*2))*24)-(5))/32)
							end
						end
					end
				end
			end
		end
		coroutine.yield()
	end
end)

do
	local tempoPercorrido = 0
	eventLoop = function()
		coroutine.resume(sorteiozinho)
		if tempoPercorrido == 5 then --depois de 5 segundos selecioando
			_modo = 'final'
			primeiraVez = true
			tempoPercorrido = tempoPercorrido+1
		elseif _modo == 'inicio' then
			tempoPercorrido = tempoPercorrido+0.5
		end
	end
end


eventTextAreaCallback = function(_, b, c) callback[c](b) end

eventPopupAnswer = function(id, _, resposta)
	if id == 1 then
		premio = resposta or ''
		carregarTextArea(1)
	elseif id == 2 then
		ganhadoresNumero = tonumber(resposta) or 1
		carregarTextArea(1)
		ui.setMapName(lingua[comunidade][26]:format(ganhadoresNumero))
	elseif id == 3 then
		chefe = tfm.get.room.playerList[resposta] and resposta or (debug.traceback()):match('(%w*%#%d+)')
		for i=1, #premioImagem do
			tfm.exec.removeImage(premioImagem[i])
		end
		for i=1, #iniciarSlice do
   		tfm.exec.removeImage(iniciarSlice[i])
   	end
		for k in next, tfm.get.room.playerList do
			eventNewPlayer(k)
		end
		if imageDaConfiguracao then tfm.exec.removeImage(imageDaConfiguracao) removerTextArea(13, nil) end
		for i=1, #premioImagem do
			tfm.exec.removeImage(premioImagem[i])
		end
		for i=1, #iniciarSlice do
   		tfm.exec.removeImage(iniciarSlice[i])
   	end
		carregarTextArea(5, chefe, lingua[comunidade][20])
		carregarTextArea(7, chefe, lingua[comunidade][21])
	end
end

eventNewPlayer = function(nomeDoJogador)
   tfm.exec.respawnPlayer(nomeDoJogador)
   carregarTextArea(1, nomeDoJogador)
   if _modo == 'inicio' or _modo == 'final' then
		carregarTextArea(2, nomeDoJogador, lingua[comunidade][17])
		removerTextArea(-2, nomeDoJogador)
		removerTextArea(7)
		removerTextArea(-7)
		for i=1, #slice do
			tfm.exec.removeImage(slice[i])
		end
		for i=1, #premioImagem do
			tfm.exec.removeImage(premioImagem[i])
		end
		if nomeDoJogador == chefe then
			carregarTextArea(5, chefe, lingua[comunidade][18])
			removerTextArea(-5, nomeDoJogador)
		end
	else
		if participantes[nomeDoJogador] then
			carregarTextArea(2, nomeDoJogador, lingua[comunidade][10])
			removerTextArea(-2, nomeDoJogador)
		else
			carregarTextArea(2, nomeDoJogador, lingua[comunidade][19])
		end
		if nomeDoJogador == chefe then
			carregarTextArea(5, chefe, lingua[comunidade][20])
			carregarTextArea(7, chefe, lingua[comunidade][21])
		end
	end
	if nomeDoJogador ~= chefe then
   	removerTextArea(7, nomeDoJogador, 8, 9, 10, 11, 12, 13, -7, 5, -5)
   end
end

eventNewGame = function()
	ui.setMapName(lingua[comunidade][26]:format(ganhadoresNumero))
	carregarTextArea(1)
	carregarTextArea(2, k, lingua[comunidade][22])
	carregarTextArea(5, chefe, lingua[comunidade][23])
	carregarTextArea(7, chefe, lingua[comunidade][24])
end

eventPlayerDied = tfm.exec.respawnPlayer
eventPlayerWon = tfm.exec.respawnPlayer

tfm.exec.newGame(mapa)
