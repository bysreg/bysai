package jothello;

import org.luaj.vm2.*;
import org.luaj.vm2.lib.jse.*;

public class Main {
	public static void main(String[] args) {
		String script = "lib/ai.lua";
		
		// create an environment to run in
		Globals globals = JsePlatform.standardGlobals();
		
		// Use the convenience function on the globals to load a chunk.
		LuaValue chunk = globals.loadFile(script);
		
		// Use any of the "call()" or "invoke()" functions directly on the chunk.
		chunk.call( LuaValue.valueOf(script) );
	}
}
