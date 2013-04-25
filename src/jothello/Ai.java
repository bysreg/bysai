package jothello;

import java.awt.Point;
import java.util.ArrayList;


import org.luaj.vm2.Globals;
import org.luaj.vm2.LuaValue;
import org.luaj.vm2.lib.jse.JsePlatform;

public class Ai {
	
	Globals globals;
	public final static int CORNER_WEIGHT = 10;
	public final static double DISC_WEIGHT = 0.01;
	public final static int MONTE_CARLO_TREE_SEARCH = 0;
	public final static int MINIMAX_ALPHA_BETA = 1;	
	public final int algo_type;
	
	public Ai(int algo_type) {
		String script = "lib/ai.lua";
		
		// create an environment to run in
		globals = JsePlatform.standardGlobals();
		globals.load(new aif());
		
		// Use the convenience function on the globals to load a chunk.
		LuaValue chunk = globals.loadFile(script);
		
		// Use any of the "call()" or "invoke()" functions directly on the chunk.
		chunk.call( LuaValue.valueOf(script) );
		
		this.algo_type = algo_type;
	}
	
	public Point selectMove(Jothello jothello) {
		ArrayList<Point> legalMoves = jothello.getAllMoves();
		LuaValue retvals = null;
		
		if(algo_type == MONTE_CARLO_TREE_SEARCH) {
			LuaValue monteCarlo = globals.get("monteCarlo");
			retvals = monteCarlo.call(LuaValue.valueOf(jothello.getGameStateString()), LuaValue.valueOf(jothello.getNumberOfMoves()));
		}else {
			LuaValue miniMax = globals.get("miniMax");
			retvals = miniMax.call(LuaValue.valueOf(jothello.getGameStateString()));
		}
		return legalMoves.get(retvals.toint());
	}	
}

