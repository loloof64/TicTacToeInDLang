import gtk.MainWindow;
import gtk.Main;
import gtk.DrawingArea;
import cairo.Context;
import gtk.Widget;

void main(string[] args)
{
    Main.init(args);
    MainWindow win = new TheMainWindow("Tic Tac Toe");
    Main.run();
}

class TheMainWindow: MainWindow
{
	this(const string title)
	{
		super(title);
		setDefaultSize(200, 200);

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
