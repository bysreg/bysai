package jothello;

import java.awt.Point;
import java.util.ArrayList;

import org.luaj.vm2.Globals;
import org.luaj.vm2.LuaValue;
import org.luaj.vm2.lib.jse.JsePlatform;

public class Ai {
	
	Globals globals;
	
	public Ai() {
		String script = "lib/ai.lua";
		
		// create an environment to run in
		globals = JsePlatform.standardGlobals();
		
		// Use the convenience function on the globals to load a chunk.
		LuaValue chunk = globals.loadFile(script);
		
		// Use any of the "call()" or "invoke()" functions directly on the chunk.
		chunk.call( LuaValue.valueOf(script) );			
	}
	
	public Point selectMove(Jothello jothello) {
		ArrayList<Point> legalMoves = jothello.getAllLegalMoves();
		
		//call the function MyAdd with two parameters 5, and 5
        LuaValue monteCarlo = globals.get("monteCarlo");
        LuaValue retvals = monteCarlo.call(LuaValue.valueOf(jothello.getGameStateString()), LuaValue.valueOf(jothello.getNumberOfLegalMoves()));		
		return legalMoves.get(retvals.toint());
	}	
	
	
}

