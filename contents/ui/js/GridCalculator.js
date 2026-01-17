.pragma library

function calculateGridColumns(totalDays, availableWidth, availableHeight, orientation, constants) {
    if (orientation === constants.ORIENTATIONS.VERTICAL_HEATMAP) return 53;
    return Math.max(1, Math.ceil(Math.sqrt(totalDays * (availableWidth / availableHeight))));
}

function calculateGridRows(totalDays, gridColumns, orientation, constants) {
    if (orientation === constants.ORIENTATIONS.VERTICAL_HEATMAP) return 7;
    return Math.ceil(totalDays / gridColumns);
}

function calculateCellSize(availableWidth, availableHeight, gridColumns, gridRows, gap, maxSquare) {
    return Math.min(
        maxSquare,
        (availableWidth - (gridColumns - 1) * gap) / gridColumns,
        (availableHeight - (gridRows - 1) * gap) / gridRows
    );
}

function getCellRow(dayNumber, gridColumns, gridRows, orientation, constants, mainModel) {
    if (orientation === constants.ORIENTATIONS.VERTICAL_HEATMAP) return mainModel.dayOfWeek(dayNumber);
    if (orientation === constants.ORIENTATIONS.VERTICAL) return (dayNumber - 1) % gridRows;
    return Math.floor((dayNumber - 1) / gridColumns);
}

function getCellCol(dayNumber, gridColumns, gridRows, orientation, constants, mainModel) {
    if (orientation === constants.ORIENTATIONS.VERTICAL_HEATMAP) return mainModel.weekOfYear(dayNumber);
    if (orientation === constants.ORIENTATIONS.VERTICAL) return Math.floor((dayNumber - 1) / gridRows);
    return (dayNumber - 1) % gridColumns;
}

function isDayPassed(dayNumber, todayIndex, orientation, cellRow, cellCol, gridRows, gridColumns, constants) {
    if (orientation === constants.ORIENTATIONS.VERTICAL_HEATMAP) {
        return dayNumber <= todayIndex;
    } else if (orientation === constants.ORIENTATIONS.VERTICAL) {
        return (cellCol * gridRows + cellRow + 1) <= todayIndex;
    } else {
        return (cellRow * gridColumns + cellCol + 1) <= todayIndex;
    }
}
