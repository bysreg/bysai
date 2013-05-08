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
local maximizing = {2, 3, 4} -- all the maximizing nodes (21 nodes)
local minimizing = {1} -- all the minimizing nodes (12 nodes)

for i=1, #maximizing do
	nodes[maximizing[i]].turn = 1
end

for i=1, #minimizing do
	nodes[minimizing[i]].turn = 2
end

--terminal
nodes[2].value = 1
nodes[3].value = 0
nodes[4].value = -1

--adjacency list
nodes[1].childs = {nodes[2], nodes[3], nodes[4]}

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
---[[
local search_param = {}	
search_param.fixed_depth = 1 -- jika parameter ini tidak nil, parameter max_time dihiraukan dan minimax tidak memakai iterative deepening
search_param.max_time = math.huge
search_param.use_tt = true -- transposition table
search_param.start_time = os.clock()
search_param.node_visit_count = 0
search_param.get_pv = true -- usable only if use_tt is also true
search_param.tt = {} -- reserved untuk transposition table (very good to be used with iterative deepening) 

miniMaxInitTT(search_param.tt, search_param)
--]]

local x = miniMaxRec(nodes[1], 1, -math.huge, 1, search_param)
print("best move index : ", x)
print("expected best move index : ?")
print("expected best move value : ?")