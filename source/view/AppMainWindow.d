module view.AppMainWindow;

import gtk.MainWindow;
import gtk.DrawingArea;
import cairo.Context;
import gtk.Widget;

export class AppMainWindow: MainWindow
{
	private const int BORDER_DIMENSION = 10;
	private const auto BORDER_COLOR = [200, 0, 120];


	this(const string title)
	{
		super(title);
		setDefaultSize(201, 201);
		setResizable(false);
		setIconFromFile("tic-tac-toe.png");

		initializeChildren();

		showAll();
	}

	void initializeChildren()
	{
		DrawingArea canvas = new DrawingArea(201, 201);
		canvas.addOnDraw((Scoped!(Context) context, Widget widget)
		{
			foreach (const borderBigX; 1..3)
			{
				drawHorizontalBorder(context, borderBigX);
				drawVerticalBorder(context, borderBigX);
			}
			
			return true;
		});
		add(canvas);
	}

	void drawHorizontalBorder(Context context, const int borderBigX)
	{
		const int cellsSize = getAllocatedWidth() / 3;
		const int borderX = cellsSize * borderBigX - BORDER_DIMENSION/2;

		context.rectangle(borderX, 0, BORDER_DIMENSION, getAllocatedHeight());
		context.setSourceRgb(BORDER_COLOR[0], BORDER_COLOR[1], BORDER_COLOR[2]);
		context.fill();
	}

	void drawVerticalBorder(Context context, const int borderBigX)
	{
		const int cellsSize = getAllocatedWidth() / 3;
		const int borderY = cellsSize * borderBigX - BORDER_DIMENSION/2;

		context.rectangle(0, borderY, getAllocatedWidth(), BORDER_DIMENSION);
		context.setSourceRgb(BORDER_COLOR[0], BORDER_COLOR[1], BORDER_COLOR[2]);
		context.fill();
	}

}
