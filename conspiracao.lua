local scriptDoGato = coroutine.create(function(...) --coroutine que será chamada pelo eventLoop
  while true do
    local argumentosCoroutina = { ... }
    --[[1 = listaDeModos]]

    coroutine.yield()
  end
end)

--randomização desnecessariamente grande, mas fazer o que se o resultado assim é melhor...
math.randomseed(math.random(os.time()+math.random()^286637850%64666/math.random()^math.random(os.time(), os.time()+1099511627776)*math.random(32, 64), 60525076796/478324)+1000000000)

--mapa
local mapaXML = [[<C><P /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="2e2825" H="210" Y="236" T="12" X="400" /><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="0" X="400" c="3" Y="370" T="12" H="60" /><S H="50" L="1600" o="0" X="400" c="3" Y="117" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S H="3000" L="200" o="6a7495" X="900" c="4" N="" Y="646" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="200" o="6a7495" X="-100" c="4" N="" Y="183" T="12" H="3000" /><S P="0,0,0,0.2,0,0,0,0" L="800" o="6a7495" X="400" c="4" N="" Y="-50" T="12" H="100" /><S P="0,0,0,9999,0,0,0,0" L="10" o="324650" H="265" Y="32" T="12" X="900" /><S L="10" o="324650" H="265" X="-100" Y="32" T="12" P="0,0,0,9999,0,0,0,0" /><S P="0,0,0.3,0.2,180,0,0,0" L="3000" o="3488" X="600" c="2" Y="1500" T="12" m="" H="3000" /><S P="0,0,0,0.2,0,0,0,0" L="200" o="6a7495" X="1100" c="4" N="" Y="674" T="12" H="3000" /><S H="3000" L="200" o="6a7495" X="-300" c="4" N="" Y="159" T="12" P="0,0,0,0.2,0,0,0,0" /></S><D><P C="262626,4a2d10" Y="0" T="117" X="0" P="0,0" /><P C="7f7f7f" Y="110" T="96" X="400" P="0,0" /><P X="260" Y="51" T="112" P="0,0" /><P X="0" Y="148" T="17" P="0,0" /><P P="0,0" Y="148" T="17" X="100" /><P X="200" Y="148" T="17" P="0,0" /><P P="0,0" Y="148" T="17" X="300" /><P C="df2d00" Y="116" T="19" X="50" P="0,0" /><P X="400" Y="148" T="17" P="0,0" /><P C="df2d00" Y="116" T="19" X="190" P="0,0" /><P C="df2d00" Y="116" T="19" P="0,0" X="330" /><P P="0,0" Y="148" T="17" X="500" /><P X="600" Y="148" T="17" P="0,0" /><P C="df2d00" Y="116" T="19" X="470" P="0,0" /><P P="0,0" Y="148" T="17" X="700" /><P C="df2d00" Y="116" T="19" P="0,0" X="610" /><P X="800" Y="148" T="17" P="0,0" /><P C="df2d00" Y="116" T="19" P="0,0" X="750" /><DS Y="82" X="400" /><P P="0,0" Y="148" T="17" X="-100" /><P P="0,0" Y="148" T="17" X="900" /><P X="661" Y="93" T="55" P="0,0" /></D><O /></Z></C>]]
--desativa shaman, inicio de jogo, tempo, morte automática
do local disable = {'AutoShaman', 'AutoNewGame', 'AutoTimeLeft', 'AfkDeath'}
  for i=1, #disable do
    tfm.exec['disable'..disable[i]]()
  end
end

--tabelas do jogo
local jogadoresNoJogo = {} --{nick, papel}
local papeisNoJogo = {1, 0, 0, 1, 1, 1} --0 é espião, 1 é sociedade
local jogadoresTotais = 0 --total de jogadores nas cadeiras

--tempo total percorrido no modo
local tempoPercorrido = 0

--título das missões
local listaDeMissoes = {'Achatar a Terra', 'Fazer chapéus de alumínio', 'Criar a nova ordem mundial', 'Gravar pouso falso na Lua', 'Iniciar esquema de pirâmide', 'Visitar família reptiliana da Rainha Elizabeth II', 'Cultuar religião pagã', 'Explorar cidade perdida da Amazônia', 'Começar um desastre "natural"', 'Inspecionar bunker apocalíptico na Groenlândia', 'Quebrar mercado de ações', 'Sabotar alianças internacionais', 'Sabotar organizações rivais', 'Encontrar o homem de Marte', 'Eleger candidato manchuriano', 'Prever o futuro com tarot', 'Conversar com a Bruxa Branca', 'Conversar com a Bruxa Negra'}
local missaoSelecionada = 1 --número do título da missão selecionada
local missaoAtual = 1 --número da missão atual

--agentes da missão atual
local agentesAtuais = {} 
local agentesForamAprovados = false --se agentes foram aprovados
local sequenciaDeAgentes = {{2, 3, 2, 2, 3}, {2, 2, 2, 3, 3}} --sequência de número de agente nas missões

--modos e suas propriedades
local listaDeModos = { 

  { --pegar as cadeiras
    tipoDoModo = 'cadeira', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = true, --se esse é o modo ativo ou não
    textAreaDeTempo = 7, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

  { --parte em que mostra se vc é espião ou sociedade
    tipoDoModo = 'inciar', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = true, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

   { --exibição da missão que iniciará
    tipoDoModo = 'exibir', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = true, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

  { --seleção de agentes pelo líder
    tipoDoModo = 'selecionar', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = true, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

  { --aprovação da missão pela população
    tipoDoModo = 'aprovar', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = true, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

   { --durante a execução da missão
    tipoDoModo = 'agir', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = true, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

  { --final de tudo
    tipoDoModo = 'encerrar', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = true, --se esse é o modo ativo ou não
    textAreaDeTempo = 9, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    }
}
--ajustando algumas coisas, adiciona index na tabela
setmetatable(jogadoresNoJogo, {__index = function()
  return {'</b>[ espaço ]', 2}
end})

--text areas gerais
textAreas = function(numeroDaTextArea, jogadorAlvo, textoAuxiliar, numeroExtra)
  if not numeroExtra then numeroExtra = 1 end
  for i=numeroDaTextArea, numeroDaTextArea do
    return ({
      --1-6 - lista de cadeiras
      {1, "<p align='center'><font size='12' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[1][1], jogadorAlvo, -20, 102, 140, 20, nil, nil, 0, false},
      {2, "<p align='center'><font size='12' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[2][1], jogadorAlvo, 120, 102, 140, 20, nil, nil, 0, false},
      {3, "<p align='center'><font size='12' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[3][1], jogadorAlvo, 260, 102, 140, 20, nil, nil, 0, false},
      {4, "<p align='center'><font size='12' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[4][1], jogadorAlvo, 400, 102, 140, 20, nil, nil, 0, false},
      {5, "<p align='center'><font size='12' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[5][1], jogadorAlvo, 540, 102, 140, 20, nil, nil, 0, false},
      {6, "<p align='center'><font size='12' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[6][1], jogadorAlvo, 680, 102, 140, 20, nil, nil, 0, false},
      --7 - text areas de jogadores que faltam
      {7, '<p align="center"><font size="12" color="#C2C2DA">Faltam <font size="12" color="#ED67EA">'..6-jogadoresTotais..'</font> jogadores</font></p>', nil, 320, 20, 160, 25, 0x000001, 0x7F002A, 0.85},
      --8 - contagem de tempo na maioria do listaDeModos
      {8, '<p align="center"><font size="16" color="#FDFE81">'..6-tempoPercorrido, nil, 375, 20, 50, 20, 0x000001, 0x443333, 0.85},
      --9
      {9,'<font size="16" color="#00DABB"><B>&nbsp;&nbsp;Missão #'..missaoAtual..'</B></font>\n<font size="17"><B><p align="center">'..listaDeMissoes[numeroExtra]..'&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;', nil, 160, 125, 480, 240, 0x000001, 0x554444, 0.94, false},
      --10
      {10, '<p align="center"><font size="16" color="#C2C2DA">Fim de jogo', nil, 375, 20, 50, 20, nil, nil, 0.5}
  })[i]
  end
end

removerTextArea = function(numeroDaTextArea, jogadorAlvo) --remove text area
  ui.removeTextArea(numeroDaTextArea, jogadorAlvo)
end

carregarTextArea = function(numeroDaTextArea, jogadorAlvo, textoAuxiliar)
  ui.addTextArea(table.unpack(textAreas(numeroDaTextArea, jogadorAlvo, textoAuxiliar)))
end

--funções úteis (essas não fui eu quem fez, peguei snippet, todos os créditos para stackoverflow e afins)
shuffle = function(tbl) --embaralhador, coloca a tabela em ordem aleatória
  local t = {}
  for i, v in ipairs(tbl) do
    local pos = math.random(1, #t+1)
    table.insert(t, pos, v)
  end
  return t
end

string.starts = function(String, Start) --útil também
   return string.sub(String,1,string.len(Start))==Start
end

try = function(f, catch_f)
  local status, exception = pcall(f) --função "try" igual ao python, n sei se vou usar
  if not status then
    catch_f(exception)
  end
end

tablelength = function(T) --contar o número de elementos na tabela
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

--+ tabelas e funções do jogo
for i=1, math.random(32, 128) do
  papeisNoJogo = (shuffle(papeisNoJogo)) --embaralha a tabela "papel" pra definir espião ou sociedade
end

eventLoop = function() --"aii mimimi coroutine desnecessaria" AAAAAAAAA RASENGAN
  if aCada1Segundo then 
    aCada1Segundo = false
    return
  end
  coroutine.resume(scriptDoGato, listaDeModos)
  aCada1Segundo = true
end

eventNewPlayer = function(jogadorQueEntrou)
  system.bindKeyboard(jogadorQueEntrou, 32, true, true) --espaço
  tfm.exec.respawnPlayer(jogadorQueEntrou) --ressuscita

  --pra não ficar estranho as textareas, tem q ter um lugar pra exibi-las sempre q alguem novo entrar
  for i=1, 6 do
    carregarTextArea(i, jogadorQueEntrou, 'BABD2F')
  end
  if listaDeModos[1].modoAtual then
    carregarTextArea(7, jogadorQueEntrou)
  end
end
table.foreach(tfm.get.room.playerList, eventNewPlayer) --executa p'ra todes

local sala = {'Preuclides#3383', 'Clautine#0000', 'Eschoje#0000', 'Momomorrow#0000', 'Descont_o#0000', 'Ablublble#0000'}
eventKeyboard = function(nomeDoJogador, teclaPressionada, _, PosicaoXDoRato, _)
   --padrão: jogadores={{Falado#0000, 0}, [Fulano#0000, 1]}
  if teclaPressionada == 32 and listaDeModos[1].modoAtual then --cá temos cada textarea das cadeiras, tb coloca os jogadores na tabela {jogadores}
    for i=1, 6 do
      if jogadoresNoJogo[i][1] == nomeDoJogador then return end --quem já tem cadeira não pode pegar outra
    end
    for i=1, 6 do
      nomeDoJogador = sala[i] --apenas para teste
      PosicaoXDoRato = 30-140+(i*140) --teste também, remover depois
      if PosicaoXDoRato > 25-140+i*140 and PosicaoXDoRato < 75-140+i*140 and jogadoresNoJogo[i][1] == '</b>[ espaço ]' then --verifica se o PosicaoXDoRato do jogador é em cima de uma cadeira
        jogadoresNoJogo[i] = {nomeDoJogador, papeisNoJogo[i]}; carregarTextArea(i, nil, 'DFDFDF'); jogadoresTotais = jogadoresTotais+1; --loadTextArea(7) --insere txtareas
      end
    end
    ui.addPopup(3, 0, jogadoresNoJogo[1][1]..' : '..jogadoresNoJogo[1][2]..'\n'..jogadoresNoJogo[2][1]..' : '..jogadoresNoJogo[2][2]..'\n'..jogadoresNoJogo[3][1]..' : '..jogadoresNoJogo[3][2]..'\n'..jogadoresNoJogo[4][1]..' : '..jogadoresNoJogo[4][2]..'\n'..jogadoresNoJogo[5][1]..' : '..jogadoresNoJogo[5][2]..'\n'..jogadoresNoJogo[6][1]..' : '..jogadoresNoJogo[6][2]..'\n', nil, 575, 55, 200, false)
  end
end

tfm.exec.newGame(mapaXML)
