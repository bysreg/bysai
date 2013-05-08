-- http://en.wikipedia.org/wiki/Alpha-beta_pruning

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
local maximizing = {1, 4, 10, 16} -- all the maximizing nodes (3 nodes)
local minimizing = {2, 3, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 17} -- all the minimizing nodes (12 nodes)

for i=1, #maximizing do
	nodes[maximizing[i]].turn = 1
end

for i=1, #minimizing do
	nodes[minimizing[i]].turn = 2
end

--terminal
nodes[17].value = 0.03
nodes[5].value = -0.97
nodes[6].value = 0.05
nodes[7].value = 4.03
nodes[8].value = 0.05
nodes[9].value = -0.97
nodes[11].value = 0.03
nodes[12].value = 0.03
nodes[13].value = 3.03
nodes[14].value = 3.03
nodes[15].value = 0.03

--adjacency list
nodes[1].childs = {nodes[2], nodes[3]}
nodes[2].childs = {nodes[16]}
nodes[16].childs = {nodes[17]}
nodes[3].childs = {nodes[4], nodes[10]}
nodes[4].childs = {nodes[5], nodes[6], nodes[7], nodes[8], nodes[9]}
nodes[10].childs = {nodes[11], nodes[12], nodes[13], nodes[14], nodes[15]}

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
local x = miniMax(1, {fixed_depth = 3, get_pv = true, use_tt = true})
print("best move index : ", x)