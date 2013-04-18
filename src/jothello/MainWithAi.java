package jothello;

import java.awt.Point;
import java.io.PrintWriter;

public class MainWithAi {
	public static void main(String[] args) {
		PrintWriter writer = null;
		Ai ai = new Ai();	
		try {
			writer = new PrintWriter("the-file-name.txt", "UTF-8");
			for(int i=0;i<100;i++) {		
				writer.println("------------------NEW GAME----------------------");
				Jothello jothello = new Jothello();
				int count = 0;
				do {		
					byte turn = jothello.getTurn();					
					Point p = ai.selectMove(jothello);
					jothello.putPiece(p.y, p.x);
					writer.printf("P%d langkah ke [%d, %d] sukses%n", turn, p.y, p.x);
					count++;			
				}while(jothello.whoWin() == State.NONE);
				writer.printf("sim-%d. turns : %d , result : %d%n", i, count, jothello.whoWin());		
			}
		}catch(Exception e) {
			System.err.println("something's wrong");
		}
	}
}
