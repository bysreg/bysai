require "ai"
local tree = require "tree"

--node == game_state
aif = {}

local nodes = {}

for i=1, 33 do
	local node = {}
	node.state = i
	node.childs = {}
	node.index = i
	table.insert(nodes, node)
	--print(i, node)
end

--turn
local maximizing = {1} -- all the maximizing nodes (3 nodes)
local minimizing = {2, 3} -- all the minimizing nodes (12 nodes)

for i=1, #maximizing do
	nodes[maximizing[i]].turn = 1
end

for i=1, #minimizing do
	nodes[minimizing[i]].turn = 2
end

--terminal
nodes[2].value = 0.03
nodes[3].value = 3.03

--adjacency list
nodes[1].childs = {nodes[2], nodes[3]}

--implementation of aif
function aif.evaluate(game_state)
	local node = nodes[game_state]
	return node.value
end

function aif.whoWin(game_state)
	local node = nodes[game_state]
	if(node.value == math.huge) then
		return 1
	elseif(node.value == math.huge*-1) then
		return -1	
	end	
	return 2 -- still ongoing
end

function aif.simulate(game_state, move_index)
	local node = nodes[game_state]
	return node.childs[move_index+1].index
end

function aif.getTurn(game_state)
	local node = nodes[game_state]
	return node.turn
end

function aif.getNumberOfMoves(game_state)
	local node = nodes[game_state]
	return #node.childs
end

function miniMaxCreateNode(game_state)	
	return nodes[game_state]
end
tree.visualize(nodes[1])
local x = miniMax(1, {fixed_depth = 1, get_pv = true, use_tt = true})
print("best move index : ", x)