module view.AppMainWindow;

import gtk.MainWindow;
import view.GameArea;

export class AppMainWindow: MainWindow
{
	private const auto GAME_ZONE_SIZE = 201;
	private const auto TITLE_BAR_SIZE = 18;

	this(const string title)
	{
		super(title);
		setDefaultSize(GAME_ZONE_SIZE, GAME_ZONE_SIZE + TITLE_BAR_SIZE);
		setResizable(false);
		setIconFromFile("tic-tac-toe.png");

		initializeChildren();

		showAll();
	}

	void initializeChildren()
	{
		add(new GameArea(GAME_ZONE_SIZE, GAME_ZONE_SIZE));
	}

}
