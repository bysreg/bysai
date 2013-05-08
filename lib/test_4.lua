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
local maximizing = {1, 3, 10, 17, 23, 5, 6, 8, 9, 12, 14, 15, 19, 20, 22, 25, 26} -- all the maximizing nodes (17 nodes)
local minimizing = {2, 16, 4, 7, 11, 13, 18, 21, 24} -- all the minimizing nodes (9 nodes)

for i=1, #maximizing do
	nodes[maximizing[i]].turn = 1
end

for i=1, #minimizing do
	nodes[minimizing[i]].turn = 2
end

--terminal
nodes[5].value = 3
nodes[6].value = 17
nodes[8].value = 2
nodes[9].value = 12
nodes[12].value = 15
nodes[14].value = 25
nodes[15].value = 0
nodes[19].value = 2
nodes[20].value = 5
nodes[22].value = 3
nodes[25].value = 2
nodes[26].value = 14

--adjacency list
nodes[1].childs = {nodes[2], nodes[16]}
nodes[2].childs = {nodes[3], nodes[10]}
nodes[3].childs = {nodes[4], nodes[7]}
nodes[4].childs = {nodes[5], nodes[6]}
nodes[7].childs = {nodes[8], nodes[9]}
nodes[10].childs = {nodes[11], nodes[13]}
nodes[11].childs = {nodes[12]}
nodes[13].childs = {nodes[14], nodes[15]}
nodes[16].childs = {nodes[17], nodes[23]}
nodes[17].childs = {nodes[18], nodes[21]}
nodes[18].childs = {nodes[19], nodes[20]}
nodes[21].childs = {nodes[22]}
nodes[23].childs = {nodes[24]}
nodes[24].childs = {nodes[25], nodes[26]}

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
local x = miniMax(1, {fixed_depth = 4, get_pv = true, use_tt = true})
print("best move index : ", x)
print("expected best move index : 0")
print("expected best move value : 3")