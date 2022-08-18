---------------------------------------------------------
-- e aí, parsa, veio dar uma olhada?
-- não sou o chico xavier da programação
-- então é claro q o script vai estar cheio de gambiarras
-- tem alguma crítica p/ dar? fale à vontade
-- autoria de preuclides#3383 rs
-- um modelo de "conspiração" no transformice
-- ideia de um joguinho de celular semelhante a esse
-- créditos: {
--    Sklag#2552 pelo script de Degradê,
--    Ninguem#0095 por me deixar roubar o mapa do unotfm,
--    Alguns snippets foram furtados do stackoverflow </3
--  }
-- 10/08/2022
--[[utilidade: 

ui.addTextArea(id, texto, player, x, y, largura, altura, corFundo, corBorda, binarioOpacidade, binarioPos)
function eventTextAreaCallback(id, p, name) end

]]

local scriptDoGato = coroutine.create(function() --coroutine que será chamada pelo eventLoop
  while true do
    local degradeParaRemover
    if listaDeModos[1].modoAtual and jogadoresTotais == 6 then --cadeira - pegar as cadeiras
      listaDeModos[1].modoAtual = false; listaDeModos[2].modoAtual = true; tempoPercorrido = 0; removerTextArea(listaDeModos[1].textAreaDeTempo, nil)
    ------------------------------------------------------------------------------------------
    end

    if listaDeModos[2].modoAtual then --iniciar - mostra sociedade ou espião
      carregarTextArea(listaDeModos[2].textAreaDeTempo) --contagem do tempo
      if listaDeModos[2].primeiraVez then
        degradeParaRemover = gradient(nil, 0.008)
        for i=1, #jogadoresNoJogo do --muda a cor dos espiões para vermelho
        print(jogadoresNoJogo[i][1]..' | '..jogadoresNoJogo[i][2])
          if jogadoresNoJogo[i][2] == 0 then
            for j=1, #jogadoresNoJogo do
              if jogadoresNoJogo[j][2] == 0 then
                carregarTextArea(i, jogadoresNoJogo[j][1], coresPadrao.espiao)
              end
            end --abaixo: mostra a mensagem do espião
              carregarTextArea(11, jogadoresNoJogo[i][1], '<font color="#'..coresPadrao.espiao..'" size="22"><b>&#12288;Você é um espião</b></font>\n\n\n<font size="14" color="#'..coresPadrao.brancoDeTexto..'">&#12288;&#12288;&#12288;➜ Infiltre e <font color="#'..coresPadrao.espiao..'">sabote</font> 3 missões da <font color="#'..coresPadrao.sociedade..'">sociedade</font> para vencer;\n\n&#12288;&#12288;&#12288;➜ Seja discreto: não deixe que a <font color="#'..coresPadrao.sociedade..'">sociedade</font> descubra\n&#12288;&#12288;&#12288;&#12288;sua verdadeira <font color="#'..coresPadrao.espiao..'">identidade</font>;\n\n&#12288;&#12288;&#12288;➜ Tente fazer com que o <font color="#'..coresPadrao.lider..'">Líder</font> da missão escolha você.\n&#12288;&#12288;&#12288;&#12288;Um <font color="#'..coresPadrao.espiao..'">espião</font> pode sabotar a missão inteira.</font>')
            else --mostra a mensagem da sociedade
              carregarTextArea(11, jogadoresNoJogo[i][1], '<font color="#'..coresPadrao.sociedade..'" size="22"><b>&#12288;Você é sociedade</b></font>\n\n\n<font size="14" color="#'..coresPadrao.brancoDeTexto..'">&#12288;&#12288;&#12288;➜ Complete <font color="#'..coresPadrao.sociedade..'">3 missões</font> com <font color="#'..coresPadrao.sociedade..'">sucesso</font> para vencer;\n\n&#12288;&#12288;&#12288;➜ Fique atento: há <font color="#'..coresPadrao.espiao..'">2 espiões</font> infiltrados na <font color="#'..coresPadrao.sociedade..'">sociedade</font>\n&#12288;&#12288;&#12288;&#12288;que podem sabotar as missões;\n\n&#12288;&#12288;&#12288;➜ Ao ser o <font color="#'..coresPadrao.lider..'">Líder</font> da missão, escolha com sabedoria\n&#12288;&#12288;&#12288;&#12288;seus agentes. Um <font color="#'..coresPadrao.espiao..'">espião</font> pode sabotar a missão inteira.</font>')
          end
        end
        listaDeModos[2].primeiraVez = false
      end
      if tempoPercorrido == listaDeModos[2].duracaoDoModo then
        listaDeModos[2].modoAtual = false; listaDeModos[3].modoAtual = true; removerTextArea(11, nil); tempoPercorrido = 0; coroutine.yield();
      end
    ------------------------------------------------------------------------------------------
    end

    if listaDeModos[3].modoAtual then --exibir - missao atual
      carregarTextArea(listaDeModos[3].textAreaDeTempo)
      if listaDeModos[3].primeiraVez then
        carregarTextArea(11, nil, '<font size="16" color="#'..coresPadrao.missaoNumero..'"><b>&#12288;&#12288;Missão #'..tostring(missaoAtual)..'</b></font>\n<font size="22" color="#'..coresPadrao.brancoDeTexto..'"><b>&#12288;&#12288;&#12288;&#12288;&#12288;<font size="16" color="#'..coresPadrao.missaoNumero..'"><b>└ </b></font>'..listaDeMissoes[missaoSelecionada][1]..'</b></font>')
        carregarTextArea(12, nil, '<p align="justify"><font size="10" color="#'..coresPadrao.brancoDeTexto..'">'..listaDeMissoes[missaoSelecionada][2]..'</font></p>')
      elseif tempoPercorrido == 5 then
        carregarTextArea(11, nil, '')
      end
    ------------------------------------------------------------------------------------------
    end

    if listaDeModos[4].modoAtual then --selecionar - seleciona os agentes da missão
    ------------------------------------------------------------------------------------------
    end

    if listaDeModos[5].modoAtual then
    ------------------------------------------------------------------------------------------
    end

    if listaDeModos[6].modoAtual then
    ------------------------------------------------------------------------------------------
    end

    if listaDeModos[7].modoAtual then
    ------------------------------------------------------------------------------------------
    end

    coroutine.yield()
  end
end)



--randomização desnecessariamente grande, mas fazer o que se o resultado assim é melhor...
math.randomseed(math.random(os.time()+math.random()^286637850%64666/math.random()^math.random(os.time(), os.time()+1099511627776)*math.random(32, 64), 60525076796/478324)+1000000000)

--desativa shaman, inicio de jogo, tempo, morte automática
do local disable = {'AutoShaman', 'AutoNewGame', 'AutoTimeLeft', 'AfkDeath', 'AutoScore'}
  for i=1, #disable do
    tfm.exec['disable'..disable[i]]()
  end
end

--tabelas do jogo
jogadoresNoJogo = {} --{nick, papel}
local papeisNoJogo = {1, 0, 0, 1, 1, 1} --0 é espião, 1 é sociedade
jogadoresTotais = 0 --total de jogadores nas cadeiras

--cores usadas no jogo para as textareas
coresPadrao = {brancoDeTexto = 'FDFDFE',
    brancoMaisEscuro = 'EDEDEE',
    espiao = 'FF0C40', --cor vermelho para espião
    sociedade = '10FF54',
    lider = '0950FF',
    missaoNumero = 'FFBF00'}

--tempo total percorrido no modo
tempoPercorrido = 0

--título das missões
listaDeMissoes = {
    {'Achatar a Terra', 'Ordem superior: que a Terra é plana todo o globo sabe. Mas para caucionar que ela jamais fique curva, a sociedade achatá-la-á mais ainda.'}, 
    {'Fazer chapéus de alumínio', 'Para abster o manejo mental transversalmente das micro-ondas, a sociedade fornecerá chapéus de alumínio para seus membros. Precisa-se de alguns agentes para perfazer essa missão.'}, 
    {'Gravar pouso falso na Lua', 'A fim de a URSS recear de inveja, a sociedade compô-lo-á seu apropriado assentamento de foguete até a Lua. Produzido em Hollywood...'}, 
    {'Visitar família reptiliana da Rainha Elizabeth II', 'O acordo da sociedade juntamente os répteis nunca estive tão longínquo. Uma visita reaproximar-nos-ia.'}, 
    {'Encontrar os descendentes do Conde Drácula', 'Través de sacrifícios, a sociedade unir-se-á junto aos vampíros romenianos que descendem do Conde Drácula. O domínio vampírico dará uma superioridade da sociedade sobre a multidão ordinário'}, 
    {'Explorar cidade perdida da Amazônia', 'Há boatos que dizem que cidades indígenas de 10 milhões de anos estão perdidas na Amazônia. A sociedade intrigou-se. Escolha agentes para explorar.'}, 
    {'Começar um desastre "natural"', 'Aqueça a ionosfera para manejar o clima mundial. Destarte, a sociedade secreta poderá dominar governos inteiros través dos desastres climáticos.'}, 
    {'Inspecionar bunker apocalíptico na Groenlândia', 'Posto que ocorrer o apocalípse, deseja-se que nosso bunker de sobrevivência esteja nos trilhos. Verifique se o bunker está nos conformes.'}, 
    {'Quebrar mercado de ações', 'O mercado de ações nada produz. A missão hodierno é atuar para despedaçar as bolsas de valores causando um caos no bolso dos acionistas.'}, 
    {'Sabotar alianças internacionais', 'Conspire contra as organizações globais que unem os países uns aos outros, para o bem da sociedade secreta.'}, 
    {'Sabotar organizações rivais', 'Outras sociedades secretas estão causando danos a nós. A sociedade secreta da conspiração não deixará barato. Retalhe.'}, 
    {'Encontrar o homem de Marte', 'A sociedade chegará em Marte para trocar ideias com um habitador autóctone sobre a colonização da Lua.'}, 
    {'Eleger candidato manchuriano', 'As eleições estão acontecendo! A sociedade quer escolher um cadindato chinês a fim de espionar o governo.'}, 
    {'Prever o futuro com tarot', 'Parece que essa missão é especial. Madame Lulu joga suas cartas na mesa: duas letras que existem no nome de um dos espiões são reveladas. Apenas os agentes da missão veem as letras. Esse futuro será profíquo?'}, 
    {'Conversar com a Bruxa Branca', 'Missão especial da sede da sociedade secreta! Encontre a Bruxa Branca, ela desfrutará seus poderes absolutos para te metamorfosear em sociedade ou espião, de acordo com seus desejos. Só um agente da missão pode comunicar com ela.'}, 
    {'Conversar com a Bruxa Negra', 'Uma anormalidade: missão especial. A Bruxa Negra jogará uma praga na Missão #5, fazendo com que ela seja automaticamente bem-sucedida ou sabotada, independentemente dos agentes da missão. Só um agente pode conversar com a Bruxa Negra.'}
  }


missaoSelecionada = 1 --número do título da missão selecionada
missaoAtual = 1 --número da missão atual

--agentes da missão atual
local agentesAtuais = {} 
local agentesForamAprovados = false --se agentes foram aprovados
local sequenciaDeAgentes = {{2, 3, 2, 2, 3}, {2, 2, 2, 3, 3}} --sequência de número de agente nas missões

--modos e suas propriedades
listaDeModos = { 

  { --pegar as cadeiras 1
    tipoDoModo = 'cadeira', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = true, --se esse é o modo ativo ou não
    textAreaDeTempo = 7, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

  { --parte em que mostra se vc é espião ou sociedade 2
    tipoDoModo = 'inciar', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = false, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = 11, --número da textArea importante
    duracaoDoModo = 5 --duração do modo
    },

   { --exibição da missão que iniciará 3
    tipoDoModo = 'exibir', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = false, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 10 --duração do modo
    },

  { --seleção de agentes pelo líder 4
    tipoDoModo = 'selecionar', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = false, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

  { --aprovação da missão pela população 5
    tipoDoModo = 'aprovar', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = false, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

   { --durante a execução da missão 6
    tipoDoModo = 'agir', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = false, --se esse é o modo ativo ou não
    textAreaDeTempo = 8, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    },

  { --final de tudo 7
    tipoDoModo = 'encerrar', --o ID do modo
    primeiraVez = true, --se é a primeira vez que tá sendo executado
    modoAtual = false, --se esse é o modo ativo ou não
    textAreaDeTempo = 9, --número da textArea de tempo
    textAreasDoModo = nil, --número da textArea importante
    duracaoDoModo = 0 --duração do modo
    }
}
--ajustando algumas coisas, adiciona index na tabela
setmetatable(jogadoresNoJogo, {__index = function()
  return {'</b><font size="11">[ espaço ]', 2}
end})

--text areas gerais
textAreas = function(numeroDaTextArea, jogadorAlvo, textoAuxiliar, numeroExtra)
  if not numeroExtra then numeroExtra = 1 end
  if not textoAuxiliar then textoAuxiliar = '' end
  for i=numeroDaTextArea, numeroDaTextArea do
    return ({
      --1-6 - lista de cadeiras
      {1, "<p align='center'><font size='10' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[1][1], jogadorAlvo, 000, 100, 100, 20, nil, nil, 0, false},
      {2, "<p align='center'><font size='10' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[2][1], jogadorAlvo, 130, 100, 120, 20, nil, nil, 0, false},
      {3, "<p align='center'><font size='10' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[3][1], jogadorAlvo, 270, 100, 120, 20, nil, nil, 0, false},
      {4, "<p align='center'><font size='10' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[4][1], jogadorAlvo, 410, 100, 120, 20, nil, nil, 0, false},
      {5, "<p align='center'><font size='10' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[5][1], jogadorAlvo, 550, 100, 120, 20, nil, nil, 0, false},
      {6, "<p align='center'><font size='10' color='#"..tostring(textoAuxiliar).."'><b>"..jogadoresNoJogo[6][1], jogadorAlvo, 700, 100, 100, 20, nil, nil, 0, false},
      --7 - do modo 'cadeira', text areas de jogadores que faltam
      {7, '<p align="center"><font size="12" color="#C2C2DA">Faltam <font size="12" color="#ED67EA">'..6-jogadoresTotais..'</font> jogadores</font></p>', nil, 320, 20, 160, 25, 0x000001, 0x7F002A, 0.85},
      --8 - contagem de tempo na maioria do listaDeModos
      {8, '<p align="center"><font size="16" color="#FDFE81">'..6-tempoPercorrido, nil, 375, 20, 50, 20, 0x000001, 0x443333, 0.85},
      --9 do modo 'encerrar', mostra "fim de jogo"
      {9, '<p align="center"><font size="16" color="#C2C2DA">Fim de jogo', nil, 375, 20, 50, 20, nil, nil, 0.5},
      --10 reservado para alguma coisa
      {10,'reservado', nil, 160, 125, 480, 240, 0x000001, 0x554444, 0.94, false},
      --11-16 do modo 'iniciar', mostra se é espião ou sociedade; do modo 'exibir', mostra a missão e quem está escolhendo a missão
      {11, textoAuxiliar, jogadorAlvo, 160, 125, 480, 240, 0x000001, 0x554444, 0.94, false},
      --do modo exibir, mostra a descrissão da missão
      {12, textoAuxiliar, jogadorAlvo, 325, 190, 215, 175, nil, nil, 0, false}
  })[i] --{10,'<font size="16" color="#00DABB"><B>&nbsp;&nbsp;Missão #'..missaoAtual..'</B></font>\n<font size="17"><B><p align="center">'..listaDeMissoes[numeroExtra]..'&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;&#12288;', nil, 160, 125, 480, 240, 0x000001, 0x554444, 0.94, false}
  end
end

removerTextArea = function(numeroDaTextArea, jogadorAlvo) --remove text area
  ui.removeTextArea(numeroDaTextArea, jogadorAlvo)
end

carregarTextArea = function(numeroDaTextArea, jogadorAlvo, textoAuxiliar)
  ui.addTextArea(table.unpack(textAreas(numeroDaTextArea, jogadorAlvo, textoAuxiliar)))
end

--funções úteis (essas não fui eu quem fez, créditos aos criadores obviamente rs)
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

gradient = function(targetPlayer, force)
  local y = 0
  local opacity = 1
  local ids = {}
  for i = 1, 125 do --numero exato em que a opacidade vira '0'
    y = y +1
    opacity = opacity-force
    ids[#ids+1] = tfm.exec.addImage('17948da3319.png', "!1", 0, y, targetPlayer, 800, 1, nil, opacity)
    ids[#ids+1] = tfm.exec.addImage('17948da3319.png', "!1", 0, 400-y, targetPlayer, 800, 1, nil, opacity)
  end
  return ids
end

--+ tabelas e funções do jogo
for i=1, math.random(32, 128) do
  papeisNoJogo = (shuffle(papeisNoJogo)) --embaralha a tabela "papel" pra definir espião ou sociedade
end

---------------------------------------------------------
do 
  local aCada1Segundo
  eventLoop = function() --"aii mimimi coroutine desnecessaria" AAAAAAAAA RASENGAN
    if aCada1Segundo then 
      aCada1Segundo = false
      return
    end
    coroutine.resume(scriptDoGato, listaDeModos)
    tempoPercorrido = tempoPercorrido+1
    aCada1Segundo = true
  end
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

local sala = {'Preuclides#3383', 'Sklag#2552', 'Eschoje#0000', 'Momomorrow#0000', 'Descont_o#0000', 'Eletroohause#0000'}
eventKeyboard = function(nomeDoJogador, teclaPressionada, _, posicaoXDoRato, _)
   --padrão: jogadores={{Falado#0000, 0}, [Fulano#0000, 1]}
  if teclaPressionada == 32 and listaDeModos[1].modoAtual then --cá temos cada textarea das cadeiras, tb coloca os jogadores na tabela {jogadores}
    for i=1, 6 do
      if jogadoresNoJogo[i][1] == nomeDoJogador then return end --quem já tem cadeira não pode pegar outra
      nomeDoJogador = sala[i] --apenas para teste
      posicaoXDoRato = 30-140+(i*140) --teste também, remover depois
      if posicaoXDoRato > 25-140+i*140 and posicaoXDoRato < 75-140+i*140 and jogadoresNoJogo[i][1] == '</b><font size="11">[ espaço ]' then --verifica se o posicaoXDoRato do jogador é em cima de uma cadeira
        jogadoresNoJogo[i] = {nomeDoJogador, papeisNoJogo[i]}; carregarTextArea(i, nil, coresPadrao.brancoDeTexto); jogadoresTotais = jogadoresTotais+1; --loadTextArea(7) --insere txtareas
      end
    end
    ui.addPopup(3, 0, jogadoresNoJogo[1][1]..' : '..jogadoresNoJogo[1][2]..'\n'..jogadoresNoJogo[2][1]..' : '..jogadoresNoJogo[2][2]..'\n'..jogadoresNoJogo[3][1]..' : '..jogadoresNoJogo[3][2]..'\n'..jogadoresNoJogo[4][1]..' : '..jogadoresNoJogo[4][2]..'\n'..jogadoresNoJogo[5][1]..' : '..jogadoresNoJogo[5][2]..'\n'..jogadoresNoJogo[6][1]..' : '..jogadoresNoJogo[6][2]..'\n', nil, 575, 55, 200, false)
  end
end

--mapa
do
  local mapaXML = [[<C><P /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="2e2825" H="210" Y="236" T="12" X="400" /><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="0" X="400" c="3" Y="370" T="12" H="60" /><S H="50" L="1600" o="0" X="400" c="3" Y="117" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S H="3000" L="200" o="6a7495" X="900" c="4" N="" Y="646" T="12" P="0,0,0,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="200" o="6a7495" X="-100" c="4" N="" Y="183" T="12" H="3000" /><S P="0,0,0,0.2,0,0,0,0" L="800" o="6a7495" X="400" c="4" N="" Y="-50" T="12" H="100" /><S P="0,0,0,9999,0,0,0,0" L="10" o="324650" H="265" Y="32" T="12" X="900" /><S L="10" o="324650" H="265" X="-100" Y="32" T="12" P="0,0,0,9999,0,0,0,0" /><S P="0,0,0.3,0.2,180,0,0,0" L="3000" o="3488" X="600" c="2" Y="1500" T="12" m="" H="3000" /><S P="0,0,0,0.2,0,0,0,0" L="200" o="6a7495" X="1100" c="4" N="" Y="674" T="12" H="3000" /><S H="3000" L="200" o="6a7495" X="-300" c="4" N="" Y="159" T="12" P="0,0,0,0.2,0,0,0,0" /></S><D><P C="262626,4a2d10" Y="0" T="117" X="0" P="0,0" /><P C="7f7f7f" Y="110" T="96" X="400" P="0,0" /><P X="260" Y="51" T="112" P="0,0" /><P X="0" Y="148" T="17" P="0,0" /><P P="0,0" Y="148" T="17" X="100" /><P X="200" Y="148" T="17" P="0,0" /><P P="0,0" Y="148" T="17" X="300" /><P C="df2d00" Y="116" T="19" X="50" P="0,0" /><P X="400" Y="148" T="17" P="0,0" /><P C="df2d00" Y="116" T="19" X="190" P="0,0" /><P C="df2d00" Y="116" T="19" P="0,0" X="330" /><P P="0,0" Y="148" T="17" X="500" /><P X="600" Y="148" T="17" P="0,0" /><P C="df2d00" Y="116" T="19" X="470" P="0,0" /><P P="0,0" Y="148" T="17" X="700" /><P C="df2d00" Y="116" T="19" P="0,0" X="610" /><P X="800" Y="148" T="17" P="0,0" /><P C="df2d00" Y="116" T="19" P="0,0" X="750" /><DS Y="82" X="400" /><P P="0,0" Y="148" T="17" X="-100" /><P P="0,0" Y="148" T="17" X="900" /><P X="661" Y="93" T="55" P="0,0" /></D><O /></Z></C>]]
  tfm.exec.newGame(mapaXML)
end

--eu realmente não sei por que fiz isso abaixo, mas pensei em fazer por alguns motivos
local listaDeModos
local jogadoresTotais
local jogadoresNoJogo
local tempoPercorrido
local missaoAtual
local missaoSelecionada
local listaDeMissoes
