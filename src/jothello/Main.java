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
		scanner.close();
		System.out.println("winner : " + jothello.whoWin());		
	}
}
