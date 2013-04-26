require "ai"

--node == game_state
aif = {}

globals_ai.g_miniMax.time = 3

local nodes = {}

for i=1, 5 do
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

--terminal
nodes[3].value = -math.huge
nodes[4].value = -math.huge
nodes[5].value = -math.huge

--adjacency list
table.insert(nodes[1].childs, nodes[2])
table.insert(nodes[1].childs, nodes[5])
table.insert(nodes[2].childs, nodes[3])
table.insert(nodes[2].childs, nodes[4])

function aif.evaluate(game_state)
	--print("yang ", game_state, game_state.value)
	return game_state.value
end

function aif.whoWin(game_state)	
	if(game_state.value == math.huge) then
		return 1
	elseif(game_state.value == math.huge*-1) then
		return -1	
	end	
	
	return 2 -- still ongoings
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

local x = miniMax(nodes[1])
print("result", x) 