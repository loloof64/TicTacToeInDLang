module view.AppMainWindow;

import gtk.MainWindow;
import gtk.DrawingArea;
import cairo.Context;
import gtk.Widget;

export class AppMainWindow: MainWindow
{
	this(const string title)
	{
		super(title);
		setDefaultSize(200, 200);
		setResizable(false);
		setIconFromFile("tic-tac-toe.png");

		initializeChildren();

		showAll();
	}

	void initializeChildren()
	{
		DrawingArea canvas = new DrawingArea(200, 200);
		canvas.addOnDraw((Scoped!(Context) context, Widget widget) {
			context.rectangle(0, 0, getAllocatedWidth(), getAllocatedHeight());
			context.setSourceRgb(255, 0, 0);
			context.fill();

			return true;
		});
		add(canvas);
	}
}
