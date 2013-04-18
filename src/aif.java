import java.awt.Point;
import java.util.ArrayList;

import jothello.Jothello;
import jothello.State;

import org.luaj.vm2.LuaValue;
import org.luaj.vm2.lib.OneArgFunction;
import org.luaj.vm2.lib.TwoArgFunction;

public class aif extends TwoArgFunction {

	/**
	 * Public constructor. To be loaded via require(), the library class must
	 * have a public constructor.
	 */
	public aif() {
	}

	@Override
	public LuaValue call(LuaValue modname, LuaValue env) {
		LuaValue library = tableOf();
		library.set("getNumberOfMoves", new getNumberOfMoves());
		library.set("simulate", new simulate());
		library.set("whoWin", new whoWin());
		library.set("getTurn", new getTurn());
		env.set("aif", library);
		return library;
	}

	static class getNumberOfMoves extends OneArgFunction {
		public LuaValue call(LuaValue arg) {
			String game_state = arg.checkjstring();
			Jothello jothello = new Jothello(game_state);
			return valueOf(jothello.getNumberOfLegalMoves());
		}
	}

	static class simulate extends TwoArgFunction {
		public LuaValue call(LuaValue arg0, LuaValue arg1) {
			String game_state = arg0.checkjstring();
			int move_num = arg1.checkint();
			Jothello jothello = new Jothello(game_state);
			ArrayList<Point> legalMoves = jothello.getAllLegalMoves();
			jothello.putPiece(legalMoves.get(move_num).y,
					legalMoves.get(move_num).x);
			return valueOf(jothello.getGameStateString());
		}
	}

	static class whoWin extends OneArgFunction {
		@Override
		public LuaValue call(LuaValue arg) {
			String game_state = arg.checkjstring();
			Jothello jothello = new Jothello(game_state);
			int winner = jothello.whoWin();
			int ret = 0;
			if (winner == State.NONE)
				ret = 2;
			else if (winner == State.DARK)
				ret = 1;
			else if (winner == State.LIGHT)
				ret = -1;
			else if (winner == State.TIE)
				ret = 0;
			return valueOf(ret);
		}
	}

	static class getTurn extends OneArgFunction {
		@Override
		public LuaValue call(LuaValue arg) {
			String game_state = arg.checkjstring();
			Jothello jothello = new Jothello(game_state);
			return valueOf(jothello.getTurn());
		}
	}
}
