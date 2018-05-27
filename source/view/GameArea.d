module view.GameArea;

import gtk.DrawingArea;
import gtk.Widget;
import cairo.Context;

class GameArea : DrawingArea
{
    private const int BORDER_DIMENSION = 10;
	private const auto BORDER_COLOR = [200, 0, 120];

    this(int width, int height)
    {
        super(width, height);

        addOnDraw((Scoped!(Context) context, Widget widget)
        {
            drawArea(context);
            return true;
        });
    }

    void drawArea(Context context)
    {
        foreach (const borderBigX; 1..3)
        {
            drawHorizontalBorder(context, borderBigX);
            drawVerticalBorder(context, borderBigX);
        }
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