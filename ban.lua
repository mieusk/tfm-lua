--[[Você precisa usar o comando "!ban User#0000" para banir, "!unban" para desbanir]]

local _, adm = pcall(nil); adm = adm:match('(.-#%d+)') --pega o nick de quem colocou o script

bans = {} --table para armazenar os bans
-------------------------------------------------------
function string.starts(String, Start) --checa o início da string
   return string.sub(String,1,string.len(Start))==Start
end
function table.find(Table, Find) --pega a posição de uma string numa table
	for i=1, #Table do
		if Table[i] == Find then return i end
	end
end
function ban(p) --função pra banir
	tfm.exec.killPlayer(p) --mata o player
	ui.addTextArea(0, '', p, -800, -400, 3200, 1600, 0x000001, 0x000001, 1, true) --adiciona tela preta
	ui.addTextArea(1, '<p align="center"><font color="#CB546B">• '..p..', você foi banido da sala!</font></p>', p, 200, 187, 400, 26, 0x000001, 0x000001, 1, true)
	tfm.exec.setPlayerScore(p, -1) --score negativo
end
-------------------------------------------------------
function eventChatCommand(p, c) --evento chamado sempre q usam um comando
	if p == adm and string.starts(c, 'ban ') then --checa se começa com "ban"
		local c = c:gsub('ban ', '', 1)
		table.insert(bans, #bans+1, c) --adiciona o nick na table de bans
		ban(p) --executa o banimento
	end
	if p == adm and string.starts(c, 'unban ') then --checa se começa com "unban"
		local c = c:gsub('unban ', '', 1)
		table.remove(bans, table.find(bans, c)) --remove da table de bans
		ui.removeTextArea(0, c) --remove tela preta
		ui.removeTextArea(1, c)
		tfm.exec.respawnPlayer(c) --ressucita
	end
end
function eventPlayerRespawn(p)
	if table.find(bans, p) ~= nil then ban(p) end --mata de novo sempre q o player renasce
end