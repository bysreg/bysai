local M = {}

local s_get_childs = function(node)
	return node.childs
end

local s_visit_node = function(node)
	return node.index
end	

local function isEmpty(stack)
	if(stack.top_index == 0) then
		return true
	elseif(stack.top_index > 0) then
		return false
	else
		assert(false, "stack.top_index is incorrect, stack.top_index : " .. stack.top_index)
	end
end

local function push(stack, node) 
	stack[stack.top_index + 1] = node
	stack.top_index = stack.top_index + 1
	--print("push", node.index or 'X')
end

local function pop(stack)
	assert(stack.top_index > 0, "stack is empty, stack.top_index : " .. stack.top_index)
	local ret =  stack[stack.top_index]
	stack.top_index = stack.top_index - 1
	--print("pop", ret.index or 'X')
	return ret
end

local function get_pipe_col_list(stack, sentinel)
	local ret = {}
	local depth = 0
	for i=1, stack.top_index do
		if(stack[i] == sentinel) then
			depth = depth + 1
		else
			local col = 1 + 2 * ((depth - 1) - 1)
			if(ret[#ret] ~= col) then table.insert(ret, col) end
		end
	end
	--print("pcl", #ret, ret[2])
	return ret
end

local function visualize(node, get_childs, visit_node)
	local stack = {top_index = 0}
	local col = 1
	local sentinel = {}
	
	get_childs = get_childs or s_get_childs
	visit_node = visit_node or s_visit_node
	push(stack, sentinel)
	push(stack, node)
	while(not isEmpty(stack)) do
		local cur_node = pop(stack)
		
		if(cur_node == sentinel) then
			col = col - 2
		elseif(cur_node == node) then
			print(visit_node(cur_node))
		else
			--print("ti", stack.top_index)
			local pipe_col_list = get_pipe_col_list(stack, sentinel)
			local pcl_index = 1 -- pipe_col_list_index
			local line = ""
			for i=1, col-2 do
				if(i == pipe_col_list[pcl_index]) then
					line = line .. "|"
					pcl_index = pcl_index + 1
				else
					line = line .. " "					
				end
			end
			line = line .. "\\"
			print(line)
			pcl_index = 1
			line = ""
			for i=1, col-1 do
				if(i == pipe_col_list[pcl_index]) then
					line = line .. "|"
					pcl_index = pcl_index + 1
				else
					line = line .. " "					
				end
			end			
			line = line .. (visit_node(cur_node) .. "")
			print(line)
		end
		
		local childs = get_childs(cur_node)
		if(childs ~= nil and #childs > 0) then
			col = col + 2
			push(stack, sentinel)
			for i=#childs, 1, -1 do
				push(stack, childs[i])
			end
		end
	end
end

local function test()
	nodes = {}
	for i=1, 11 do
		nodes[i] = {index = i, childs = {}}
	end
	
	nodes[1].childs = {nodes[2], nodes[8]}
	nodes[2].childs = {nodes[3], nodes[6]}
	nodes[3].childs = {nodes[4], nodes[5]}
	nodes[6].childs = {nodes[7]}
	nodes[8].childs = {nodes[9], nodes[10]}
	
	visualize(nodes[1])
end

M.visualize = visualize
--test()

return M