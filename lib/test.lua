require "ai"

--node == game_state
aif = {}

globals_ai.g_miniMax.depth = 4

local nodes = {}

for i=1, 33 do
	local node = {}
	node.state = node
	node.childs = {}
	node.index = i
	table.insert(nodes, node)
	print(i, node)
end

--turn
nodes[1].turn = 1
nodes[2].turn = 2
nodes[3].turn = 1
nodes[4].turn = 1
nodes[5].turn = 2
nodes[6].turn = 1
nodes[7].turn = 1
nodes[8].turn = 2

nodes[9].turn = 2
nodes[10].turn = 1
nodes[11].turn = 2
nodes[12].turn = 1

nodes[13].turn = 2
nodes[14].turn = 1
nodes[15].turn = 2
nodes[16].turn = 1
nodes[17].turn = 2
nodes[18].turn = 1
nodes[19].turn = 1
nodes[20].turn = 1
nodes[21].turn = 2
nodes[22].turn = 1

nodes[23].turn = 1

nodes[24].turn = 2
nodes[25].turn = 1
nodes[26].turn = 2
nodes[27].turn = 1
nodes[28].turn = 1
nodes[29].turn = 2
nodes[30].turn = 1
nodes[31].turn = 1
nodes[32].turn = 2
nodes[33].turn = 1

--terminal
nodes[3].value = 5
nodes[4].value = 6
nodes[6].value = 7
nodes[7].value = 4
nodes[8].value = 5

nodes[12].value = 3

nodes[16].value = 6
nodes[18].value = 6
nodes[19].value = 9
nodes[22].value = 7

nodes[27].value = 5
nodes[30].value = 9
nodes[31].value = 8
nodes[33].value = 6

--adjacency list
table.insert(nodes[1].childs, nodes[2])
table.insert(nodes[1].childs, nodes[5])
table.insert(nodes[2].childs, nodes[3])
table.insert(nodes[2].childs, nodes[4])
table.insert(nodes[5].childs, nodes[6])
table.insert(nodes[5].childs, nodes[7])
table.insert(nodes[5].childs, nodes[8])

table.insert(nodes[9].childs, nodes[1])
table.insert(nodes[9].childs, nodes[10]) 
table.insert(nodes[10].childs, nodes[11])
table.insert(nodes[11].childs, nodes[12])

table.insert(nodes[13].childs, nodes[14])
table.insert(nodes[14].childs, nodes[15])
table.insert(nodes[14].childs, nodes[17])
table.insert(nodes[15].childs, nodes[16])
table.insert(nodes[17].childs, nodes[18])
table.insert(nodes[17].childs, nodes[19])
table.insert(nodes[13].childs, nodes[20])
table.insert(nodes[20].childs, nodes[21])
table.insert(nodes[21].childs, nodes[22])

table.insert(nodes[23].childs, nodes[9])
table.insert(nodes[23].childs, nodes[13])
table.insert(nodes[23].childs, nodes[24])

table.insert(nodes[24].childs, nodes[25])
table.insert(nodes[24].childs, nodes[28])
table.insert(nodes[25].childs, nodes[26])
table.insert(nodes[26].childs, nodes[27])
table.insert(nodes[28].childs, nodes[29])
table.insert(nodes[29].childs, nodes[30])
table.insert(nodes[29].childs, nodes[31])
table.insert(nodes[28].childs, nodes[32])
table.insert(nodes[32].childs, nodes[33])

function aif.evaluate(game_state)
	--print("yang ", game_state, game_state.value)
	return game_state.value
end

function aif.whoWin(game_state)
	return 2 -- still ongoing
end

function aif.simulate(game_state, move_index)
	return game_state.childs[move_index+1]
end

function aif.getTurn(game_state)
	return game_state.turn
end

function aif.getNumberOfMoves(game_state)
	return #game_state.childs
end

function miniMaxCreateNode(game_state)	
	return game_state
end

local x = miniMax(nodes[23])
print("result", x) 