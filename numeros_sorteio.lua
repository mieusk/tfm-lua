------------------------------------------------------------------
--criado por Avuhcie#0000
--function eventPopupAnswer(popupId, playerName, answer)
--ui.addPopup(id, type, text, targetPlayer, x, y, width, fixedPos)
--ui.addTextArea(id, text, targetPlayer, x, y, width, height, backgroundColor, borderColor, backgroundAlpha, fixedPos)
------------------------------------------------------------------
jogando = {}

x=0
segundos=0
eliminados = {}
vencedores = {}
escolhas = {}
s = 1
modo = 'comecando'
ps = true
els = ''
-- modos = {comecando, escolha, sorteio, final}

for k, _ in pairs(tfm.get.room.playerList) do
	table.insert(jogando, #jogando+1, k)
end
ratos = #jogando
for _, v in next, {'AutoShaman', 'AutoNewGame', 'AutoTimeLeft','AfkDeath'} do
    tfm.exec['disable' .. v]()
end

local info = {}
eventNewPlayer = function(n)
    info[n] = { delay = 0 }
    tfm.exec.bindKeyboard(n,69,true,true)
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)
 
vivos=0
 
object_id = 35 -- id do objeto
 
power = 20 -- velocidade do objeto
function eventKeyboard(p,key,down,x,y)
    if key==69 and os.time() > info[p].delay then
        info[p].delay = os.time() + 2000
        if tfm.get.room.playerList[p].isFacingRight then
          peidei = tfm.exec.addShamanObject(object_id,x+20,y-10,0,power,0)
        else
          qcheireesse = tfm.exec.addShamanObject(object_id,x-20,y-10,0,-power,0)
        end
    end
end

--funções úteis
function search_t(tbl, find)
	for i=1, #tbl do
  		if tbl[i] == find then
  			return true
  		end
	end
	return false
end

local _, adm = pcall(nil)
adm = adm:match('(.-#%d+)')
tfm.exec.newGame('@7908645')
ui.addTextArea(0, '<p align="center"><font size="25">Jogo dos Números</font>\n\n<font size="14">Você tem 30 segundos para escolher um número de 1 a '..ratos..'.\nCaso outra pessoa escolher o mesmo número que você, ambos morrem e tão fora do jogo.\nSeu objetivo é pensar em um número que mais ninguém escolheria.\nDigitar um número inválido fará com que você morra automativamente.\nO jogo continua rodando até sobrar 2 ou menos ratos vivos.</font></p>', nil, 160, 80, 480, 240, 0x1C3C41, 0x000111, 1, false)
ui.addTextArea(1, '<p align="center"><font color="#F272A5" size="16"><a href="event:print">Fechar</a></font></p>', nil, 160, 294, 480, 26, 0x1C3C41, 0x000111, 1, false)
function eventPopupAnswer(id, p, a)
	if id==10 then
		if tonumber(a) == nil then
			table.insert(eliminados, #eliminados+1, p)
			tfm.exec.killPlayer(p)
			for i=1, #jogando do
				if jogando[i] == p then
					jogando[i] = nil
				end
			end
			return
		end
		if tonumber(a) > tonumber(ratos) or tonumber(a) < 1 then
			table.insert(eliminados, #eliminados+1, p)
			tfm.exec.killPlayer(p)
			for i=1, #jogando do
				if jogando[i] == p then
					jogando[i] = nil
				end
			end
		else
			escolhas[p] = tonumber(a)
		end
	end
end
function eventTextAreaCallback(id, p, name)
	if id == 1 then
		ui.addTextArea(0, ';)', p, -999999, 0, 1, 1)
		ui.addTextArea(1, ';)', p, -999999, 0, 1, 1)
	end
end
function eventPlayerDied(p)
	if search_t(eliminados, p) then else
		tfm.exec.respawnPlayer(p)
	end
end
function eventPlayerWin(p)
	if search_t(eliminados, p) then else
		tfm.exec.respawnPlayer(p)
	end
end
function eventLoop()
	if x==1 then
		x=0
		return
	end
	if x==0 then
		x=1
		if modo == 'comecando' then
			primeiro = true
			segundos=segundos+1
			ratos = #jogando
			ui.addTextArea(3, '<p align="center"><font size="16" color="#AC0006">'..20-segundos..'</font></p>', nil, 375, 19, 50, 24, 0, 0, 1, false)
			if segundos == 5 then
				segundos=0
				modo = 'escolha'
			end
		end

		if modo == 'escolha' then
			ratos = #jogando
			segundos=segundos+1
			ui.addTextArea(3, '<p align="center"><font size="16" color="#AC0006">'..30-segundos..'</font></p>', nil, 375, 19, 50, 24, 0, 0, 1, false)
			if primeiro then
				for i=1, #jogando do
					ui.addPopup(10, 2, 'Escolha um número de 1 a '..ratos, jogando[i], 300, 133, 200, fixedPos)
				end
				primeiro = false
			end
			if segundos > 10 then
				modo = 'sorteio'
			end
		end
		if modo == 'sorteio' then
			if ps then
				for _, v in pairs(jogando) do
					if escolhas[v] == nil then
						escolhas[v] = 0
						table.insert(eliminados, #eliminados+1, v)
						tfm.exec.killPlayer(v)
						for i=1, #jogando do
							if jogando[i] == v then
								jogando[i] = nil
							end
						end
					end
				end

				local itemsByNum = {}
				for item, num in pairs(escolhas) do
    				itemsByNum[num] = (itemsByNum[num] or 0) + 1
				end
				-- Now move objects to the respective tables
				rep = {}
				norep = {} -- can't use "repeat" as that's a Lua keyword
				for item, num in pairs(escolhas) do
    				if itemsByNum[num] > 1 then -- repeated at least once
        				rep[item] = num
    				end
    				if itemsByNum[num] == 1 then -- unique number
        				norep[item] = num
        				print('norep '..norep[item])
    				end
				end
				for k, v in pairs(rep) do
					table.insert(eliminados, #eliminados+1, k)
					tfm.exec.killPlayer(k)
					for i=1, #jogando do
						if jogando[i] == k then
							jogando[i] = nil
						end
					end
					els = els..' '..k..' ('..v..')'
				end
				ui.addTextArea(3, ';)', p, -999999, 0, 1, 1)
				if els == '' or els == ' ' or els == nil then
					ui.addTextArea(0, '<p align="center"><font size="25">Jogo dos Números</font>\n\n<font size="14">Eita! Parece que nenhum jogador foi morto. ;)\nA rodada vai se repetir.</font>', nil, 160, 80, 480, 240, 0x1C3C41, 0x000111, 1, false)
					ui.addTextArea(1, '<p align="center"><font color="#F272A5" size="16"><a href="event:print">Fechar</a></font></p>', nil, 160, 294, 480, 26, 0x1C3C41, 0x000111, 0, false)
				else
					ui.addTextArea(0, '<p align="center"><font size="25">Jogo dos Números</font>\n\n<font size="14">Jogadores com números repetidos foram mortos!\nAté mais,'..els..'.\n Esses foram os eliminados.</font>', nil, 160, 80, 480, 240, 0x1C3C41, 0x000111, 1, false)
					ui.addTextArea(1, '<p align="center"><font color="#F272A5" size="16"><a href="event:print">Fechar</a></font></p>', nil, 160, 294, 480, 26, 0x1C3C41, 0x000111, 0, false)

				end
				if #jogando == 1 or #jogando == 2 then
					modo = 'final'
					for k, v in pairs(jogando) do
						vencedores[#vencedores+1] = v
						tfm.exec.giveCheese(v)
					end
					ps = false
					ui.addTextArea(51, '<p align="center"><font size="25">Jogo dos Números</font>\n\n<font size="14">Como sobraram apenas '..#jogando..' jogadore(s), o jogo se encerrou. Parabéns ao(s) vencedor(es)!</font>', nil, 160, 80, 480, 240, 0x1C3C41, 0x000111, 1, false)
					ui.addTextArea(52, '<p align="center"><font color="#F272A5" size="16"><a href="event:print">Fechar</a></font></p>', nil, 160, 294, 480, 26, 0x1C3C41, 0x000111, 0, false)
				else
					print('total: '..#norep)
					for k, v in pairs(norep) do
						print('k e v '..k..' '..v)
					end
					s = s+1
					modo = comecando
					x=0
					segundos=0
					escolhas = {}
					s = 1
					modo = 'comecando'
					ps = true
					els = ''
				end
			end
		end
		if modo == 'final' then
		end
	end
end