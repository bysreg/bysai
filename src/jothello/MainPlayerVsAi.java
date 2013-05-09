package jothello;

import java.awt.Point;
import java.util.Scanner;

public class MainPlayerVsAi {
	public static void main(String[] args) {		
		Ai ai = new Ai("default_minimax");	
		Jothello jothello = new Jothello();
		Scanner scanner = new Scanner(System.in);
		do {		
			jothello.printBoard();
			System.out.println("current turn : " + (jothello.getTurn() == State.DARK ? "DARK" : "LIGHT"));
			byte turn = jothello.getTurn();
			Point p = null;
			if(turn == State.DARK) {
				p = ai.selectMove(jothello);
			}else{
				int row = scanner.nextInt();
				int col = scanner.nextInt();
				p = new Point(col, row);				
			}
			jothello.putPiece(p.y, p.x);			
			System.out.printf("P%d langkah ke [%d, %d] sukses%n", turn, p.y, p.x);			
		}while(jothello.whoWin() == State.NONE);
		System.out.println("winner : " + jothello.whoWin());
		scanner.close();
	}
}
