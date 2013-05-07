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
local maximizing = {1, 3, 11, 15, 21, 25, 28, 5, 6, 8, 9, 10, 13, 17, 19, 20, 23, 27, 30, 31, 33} -- all the maximizing nodes (21 nodes)
local minimizing = {2, 14, 24, 4, 7, 12, 16, 18, 22, 26, 29, 32} -- all the minimizing nodes (12 nodes)

for i=1, #maximizing do
	nodes[maximizing[i]].turn = 1
end

for i=1, #minimizing do
	nodes[minimizing[i]].turn = 2
end

--terminal
nodes[5].value = 5
nodes[6].value = 6
nodes[8].value = 7
nodes[9].value = 4
nodes[10].value = 5
nodes[13].value = 3
nodes[17].value = 6
nodes[19].value = 6
nodes[20].value = 9
nodes[23].value = 7
nodes[27].value = 5
nodes[30].value = 9
nodes[31].value = 8
nodes[33].value = 6

--adjacency list
nodes[1].childs = {nodes[2], nodes[14], nodes[24]}
nodes[2].childs = {nodes[3], nodes[11]}
nodes[3].childs = {nodes[4], nodes[7]}
nodes[4].childs = {nodes[5], nodes[6]}
nodes[7].childs = {nodes[8], nodes[9], nodes[10]}
nodes[11].childs = {nodes[12]}
nodes[12].childs = {nodes[13]}
nodes[14].childs = {nodes[15], nodes[21]}
nodes[15].childs = {nodes[16], nodes[18]}
nodes[16].childs = {nodes[17]}
nodes[18].childs = {nodes[19], nodes[20]}
nodes[21].childs = {nodes[22]}
nodes[22].childs = {nodes[23]}
nodes[24].childs = {nodes[25], nodes[28]}
nodes[25].childs = {nodes[26]}
nodes[26].childs = {nodes[27]}
nodes[28].childs = {nodes[29], nodes[32]}
nodes[29].childs = {nodes[30], nodes[31]}
nodes[32].childs = {nodes[33]}

--implementation of aif
function aif.evaluate(game_state)
	local node = nodes[game_state]
	print("eval node ", game_state, " : ",node.value)
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