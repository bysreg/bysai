local default_monte_carlo = {type = "monte_carlo",time = 5,}
local default_minimax = {type = "minimax", time = 5, use_tt = true,}
local minimax_without_tt = {type = "minimax", time = 5,}
local minimax_max_depth_with_tt = {type = "minimax", max_depth = 6, use_tt = true}

local profiles = {	
	my_ai_1 = default_minimax,--{type = "minimax", max_depth = 6, use_tt = true}, 
	my_ai_2 = default_monte_carlo,--{type = "minimax", max_depth = 3, use_tt = true}, 
}

return profiles