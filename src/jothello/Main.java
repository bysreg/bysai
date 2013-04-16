package jothello;

import java.util.Scanner;

public class Main {
	public static void main(String[] args) {		

		Jothello jothello = new Jothello();				
		Scanner scanner = new Scanner(System.in);
		
		do {
			jothello.printBoard();
			System.out.println("current turn : " + (jothello.getTurn() == State.DARK ? "DARK" : "LIGHT"));
			System.out.println("enter coordinate for " + (jothello.getTurn() == State.DARK ? "DARK" : "LIGHT") + " piece (row col) : ");
			int row = scanner.nextInt();
			int col = scanner.nextInt();
			jothello.putPiece(row, col);			
		}while(jothello.whoWin() == State.NONE);
		/*
		String script = "lib/ai.lua";
		
		// create an environment to run in
		Globals globals = JsePlatform.standardGlobals();
		
		// Use the convenience function on the globals to load a chunk.
		LuaValue chunk = globals.loadFile(script);
		
		// Use any of the "call()" or "invoke()" functions directly on the chunk.
		chunk.call( LuaValue.valueOf(script) );		
		*/		
	}
}
