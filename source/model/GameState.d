module model.GameState;

import model.CellValueType;

class GameState
{
    private auto values = new CellValueType [3][3];

    void reset()
    {
        foreach (line; values)
        {
            foreach (cell; line)
            {
                cell = CellValueType.NONE;
            }
        }
    }

    bool tryToSetCrossAt(int bigCellY, int bigCellX)
    {
        bool success;

        if (values[bigCellY][bigCellX] == CellValueType.NONE)
        {
            values[bigCellY][bigCellX] = CellValueType.CROSS;
            success = true;
        }
        else {
            success = false;
        }

        return success;
    }

    bool tryToSetCircleAt(int bigCellY, int bigCellX)
    {
        bool success;
        
        if (values[bigCellY][bigCellX] == CellValueType.NONE)
        {
            values[bigCellY][bigCellX] = CellValueType.CIRCLE;
            success = true;
        }
        else {
            success = false;
        }

        return success;
    }

    CellValueType[3][3] getValues()
    {
        CellValueType[3] getValuesLine(int line)
        {
            return [values[line][0], values[line][1], values[line][2]];
        }

        return [
            getValuesLine(0), getValuesLine(1), getValuesLine(2)
        ];
    }
}