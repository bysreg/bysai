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
	LuaValue brain = null;
	LuaValue profile_data = null;
	
	public Ai(String ai_profile) {
		String ai_lib_path = "lib/ai.lua";
		String ai_profiles_path = "lib/ai_profiles.lua";
		
		// create an environment to run in
		globals = JsePlatform.standardGlobals();
		globals.load(new aif());
		
		LuaValue lib_chunk = globals.loadFile(ai_lib_path);
		lib_chunk.call( LuaValue.valueOf(ai_lib_path));
		
		globals.get("initProfile").call(LuaValue.valueOf(ai_profiles_path), LuaValue.valueOf(ai_profile));	
		brain = globals.get("exec");
	}
	
	public Point selectMove(Jothello jothello) {
		ArrayList<Point> legalMoves = jothello.getAllMoves();
		LuaValue retvals = null; 
		retvals = brain.call(LuaValue.valueOf(jothello.getGameStateString()));
		return legalMoves.get(retvals.toint());
	}	
}

