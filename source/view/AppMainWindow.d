module view.AppMainWindow;

import gtk.MainWindow;
import view.GameArea;

import model.GameState;

export class AppMainWindow: MainWindow
{
	private const auto GAME_ZONE_SIZE = 201;
	private const auto TITLE_BAR_SIZE = 18;

	private auto state = new GameState();
	private GameArea gameArea;

	this(const string title)
	{
		super(title);
		setDefaultSize(GAME_ZONE_SIZE, GAME_ZONE_SIZE + TITLE_BAR_SIZE);
		setResizable(false);
		setIconFromFile("tic-tac-toe.png");

		state.reset();
		initializeChildren();

		showAll();


		///////////////////
		state.tryToSetCrossAt(2,0);
		state.tryToSetCircleAt(2,0);
		state.tryToSetCircleAt(1,1);
		gameArea.refresh(state.getValues());
		/////////////////////
	}

	void initializeChildren()
	{
		gameArea = new GameArea(GAME_ZONE_SIZE, GAME_ZONE_SIZE);
		add(gameArea);
	}

}
