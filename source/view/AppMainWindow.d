module view.AppMainWindow;

import gtk.MainWindow;
import gtk.Widget;
import gdk.Event;

import model.GameState;
import view.GameArea;

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

		addOnButtonRelease(&clickCallBack);

		showAll();
	}

	void initializeChildren()
	{
		gameArea = new GameArea(GAME_ZONE_SIZE, GAME_ZONE_SIZE);
		add(gameArea);
	}

	bool clickCallBack(Event event, Widget widget)
	{
		uint eventButton;
			event.getButton(eventButton);
			const int LEFT_BUTTON = 1;

			if (eventButton == LEFT_BUTTON)
			{
				double eventX, eventY;
				event.getCoords(eventX, eventY);

				const int cellBigX = cast(int) (eventX / (GAME_ZONE_SIZE / 3));
				const int cellBigY = cast(int) (eventY / (GAME_ZONE_SIZE / 3));

				if (state.tryToSetAPieceAt(cellBigY, cellBigX))
				{
					state.toggleTurn();
					gameArea.refresh(state.getValues());
				}
			}
			return true;
	}

}
