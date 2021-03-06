module view.GameArea;

import gtk.DrawingArea;
import gtk.Widget;
import cairo.Context;

import model.CellValueType;

class GameArea : DrawingArea
{
    private const int BORDER_DIMENSION = 3;
	private const auto BORDER_COLOR = [200, 0, 120];
    private const auto CIRCLE_COLOR = [200, 0, 0];
    private const auto CROSS_COLOR = [0, 0, 200];

    private CellValueType [3][3] values = new CellValueType [3][3];

    this(int width, int height)
    {
        super(width, height);

        addOnDraw((Scoped!(Context) context, Widget widget)
        {
            drawArea(context);
            drawPieces(context);
            return true;
        });
    }

    void refresh(CellValueType[3][3] values)
    {
        this.values = values;
        queueDraw();
    }

    private void drawArea(Context context)
    {
        foreach (const borderBigX; 1..3)
        {
            drawHorizontalBorder(context, borderBigX);
            drawVerticalBorder(context, borderBigX);
        }
    }

    private void drawPieces(Context context)
    {
        foreach (const cellBigY; 0..3)
        {
            foreach (const cellBigX; 0..3)
            {
                final switch (values[cellBigY][cellBigX])
                {
                    case CellValueType.CROSS:
                        drawCross(context, cellBigY, cellBigX);
                        break;
                    case CellValueType.CIRCLE:
                        drawCircle(context, cellBigY, cellBigX);
                        break;
                    case CellValueType.NONE:
                        break;
                }
            }
        }
    }

    private void drawHorizontalBorder(Context context, const int borderBigX)
	{
		const int cellsSize = getAllocatedWidth() / 3;
		const int borderX = cellsSize * borderBigX - BORDER_DIMENSION/2;

		context.rectangle(borderX, 0, BORDER_DIMENSION, getAllocatedHeight());
		context.setSourceRgb(BORDER_COLOR[0], BORDER_COLOR[1], BORDER_COLOR[2]);
		context.fill();
	}

	private void drawVerticalBorder(Context context, const int borderBigX)
	{
		const int cellsSize = getAllocatedWidth() / 3;
		const int borderY = cellsSize * borderBigX - BORDER_DIMENSION/2;

		context.rectangle(0, borderY, getAllocatedWidth(), BORDER_DIMENSION);
		context.setSourceRgb(BORDER_COLOR[0], BORDER_COLOR[1], BORDER_COLOR[2]);
		context.fill();
	}

    private void drawCircle(Context context, const int cellBigY, const int cellBigX)
    {
        import std.math: PI;

        const int cellsSize = getAllocatedWidth() / 3;
        const int circleCenterX = cast(int) (cellsSize * (0.5 + cellBigX));
        const int circleCenterY = cast(int) (cellsSize * (0.5 + cellBigY));
        const int circleRadius = cast(int) (cellsSize * 0.8 * 0.5);
        
        context.save();
        
        context.setLineWidth(6);
        context.arc(circleCenterX, circleCenterY, circleRadius, 0, 2*PI);
        context.setSourceRgb(CIRCLE_COLOR[0], CIRCLE_COLOR[1], CIRCLE_COLOR[2]);
        context.stroke();

        context.restore();
    }

    private void drawCross(Context context, const int cellBigY, const int cellBigX)
    {
        const int cellsSize = getAllocatedWidth() / 3;
        const int crossCenterX = cast(int) (cellsSize * (0.5 + cellBigX));
        const int crossCenterY = cast(int) (cellsSize * (0.5 + cellBigY));
        const int crossHalfLength = cast(int) (cellsSize * 0.8 * 0.5);

        context.save();
        
        context.setLineWidth(6);
        context.moveTo(crossCenterX - crossHalfLength, crossCenterY - crossHalfLength);
        context.lineTo(crossCenterX + crossHalfLength, crossCenterY + crossHalfLength);
        context.setSourceRgb(CROSS_COLOR[0], CROSS_COLOR[1], CROSS_COLOR[2]);
        context.stroke();
        context.moveTo(crossCenterX - crossHalfLength, crossCenterY + crossHalfLength);
        context.lineTo(crossCenterX + crossHalfLength, crossCenterY - crossHalfLength);
        context.setSourceRgb(CROSS_COLOR[0], CROSS_COLOR[1], CROSS_COLOR[2]);
        context.stroke();

        context.restore();
    }
}