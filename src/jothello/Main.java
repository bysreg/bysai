package jothello;

import java.awt.Point;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {		
		Ai ai = new Ai(Ai.MINIMAX_ALPHA_BETA);	
		Jothello jothello = new Jothello();
		Scanner scanner = new Scanner(System.in);
		do {		
			jothello.printBoard();
			System.out.println("current turn : " + (jothello.getTurn() == State.DARK ? "DARK" : "LIGHT"));
			byte turn = jothello.getTurn();					
			Point p = ai.selectMove(jothello);
			jothello.putPiece(p.y, p.x);
			System.out.printf("P%d langkah ke [%d, %d] sukses%n", turn, p.y, p.x);			
		}while(jothello.whoWin() == State.NONE);
		System.out.println("winner : " + jothello.whoWin());		
		scanner.close();
	}
}
