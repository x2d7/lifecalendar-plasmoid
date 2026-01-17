.pragma library

function initializeConfig(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration) {
        if (plasmoid.configuration.maxSquare !== undefined && plasmoid.configuration.maxSquare !== null) {
            root.maxSquare = parseInt(plasmoid.configuration.maxSquare) || constants.DEFAULT_MAX_SQUARE;
        }
        if (plasmoid.configuration.orientation) {
            root.orientation = plasmoid.configuration.orientation;
        }
        if (plasmoid.configuration.width !== undefined && plasmoid.configuration.width !== null) {
            root.width = parseInt(plasmoid.configuration.width) || constants.DEFAULT_WIDTH;
        }
        if (plasmoid.configuration.height !== undefined && plasmoid.configuration.height !== null) {
            root.height = parseInt(plasmoid.configuration.height) || constants.DEFAULT_HEIGHT;
        }
        if (plasmoid.configuration.margin !== undefined && plasmoid.configuration.margin !== null) {
            root.margin = parseInt(plasmoid.configuration.margin) || constants.DEFAULT_MARGIN;
        }
        if (plasmoid.configuration.gap !== undefined && plasmoid.configuration.gap !== null) {
            root.gap = parseInt(plasmoid.configuration.gap) || constants.DEFAULT_GAP;
        }
        if (plasmoid.configuration.backgroundRadius !== undefined && plasmoid.configuration.backgroundRadius !== null) {
            root.backgroundRadius = parseInt(plasmoid.configuration.backgroundRadius) || constants.DEFAULT_BACKGROUND_RADIUS;
        }
        if (plasmoid.configuration.cellRadiusFactor !== undefined && plasmoid.configuration.cellRadiusFactor !== null) {
            root.cellRadiusFactor = parseFloat(plasmoid.configuration.cellRadiusFactor) || constants.DEFAULT_CELL_RADIUS_FACTOR;
        }
        if (plasmoid.configuration.cellBorderWidth !== undefined && plasmoid.configuration.cellBorderWidth !== null) {
            root.cellBorderWidth = parseInt(plasmoid.configuration.cellBorderWidth) || constants.DEFAULT_CELL_BORDER_WIDTH;
        }
        if (plasmoid.configuration.updateInterval !== undefined && plasmoid.configuration.updateInterval !== null) {
            root.updateInterval = parseInt(plasmoid.configuration.updateInterval) || constants.UPDATE_INTERVALS.DAILY;
        }
        if (plasmoid.configuration.useCustomColors !== undefined) {
            root.useCustomColors = plasmoid.configuration.useCustomColors;
        }
        if (plasmoid.configuration.filledColor) {
            root.filledColor = plasmoid.configuration.filledColor;
        }
        if (plasmoid.configuration.emptyColor) {
            root.emptyColor = plasmoid.configuration.emptyColor;
        }
        if (plasmoid.configuration.todayBorderColor) {
            root.todayBorderColor = plasmoid.configuration.todayBorderColor;
        }
        if (plasmoid.configuration.backgroundColor) {
            root.backgroundColor = plasmoid.configuration.backgroundColor;
        }
    }
}

function updateMaxSquare(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.maxSquare !== undefined) {
        root.maxSquare = parseInt(plasmoid.configuration.maxSquare) || constants.DEFAULT_MAX_SQUARE;
    }
}

function updateOrientation(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.orientation !== undefined) {
        root.orientation = plasmoid.configuration.orientation;
    }
}

function updateWidth(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.width !== undefined) {
        root.width = parseInt(plasmoid.configuration.width) || constants.DEFAULT_WIDTH;
    }
}

function updateHeight(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.height !== undefined) {
        root.height = parseInt(plasmoid.configuration.height) || constants.DEFAULT_HEIGHT;
    }
}

function updateMargin(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.margin !== undefined) {
        root.margin = parseInt(plasmoid.configuration.margin) || constants.DEFAULT_MARGIN;
    }
}

function updateGap(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.gap !== undefined) {
        root.gap = parseInt(plasmoid.configuration.gap) || constants.DEFAULT_GAP;
    }
}

function updateBackgroundRadius(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.backgroundRadius !== undefined) {
        root.backgroundRadius = parseInt(plasmoid.configuration.backgroundRadius) || constants.DEFAULT_BACKGROUND_RADIUS;
    }
}

function updateCellRadiusFactor(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.cellRadiusFactor !== undefined) {
        root.cellRadiusFactor = parseFloat(plasmoid.configuration.cellRadiusFactor) || constants.DEFAULT_CELL_RADIUS_FACTOR;
    }
}

function updateCellBorderWidth(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.cellBorderWidth !== undefined) {
        root.cellBorderWidth = parseInt(plasmoid.configuration.cellBorderWidth) || constants.DEFAULT_CELL_BORDER_WIDTH;
    }
}

function updateUpdateInterval(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.updateInterval !== undefined) {
        root.updateInterval = parseInt(plasmoid.configuration.updateInterval) || constants.UPDATE_INTERVALS.DAILY;
    }
}

function updateUseCustomColors(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.useCustomColors !== undefined) {
        root.useCustomColors = plasmoid.configuration.useCustomColors;
    }
}

function updateFilledColor(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.filledColor !== undefined) {
        root.filledColor = plasmoid.configuration.filledColor;
    }
}

function updateEmptyColor(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.emptyColor !== undefined) {
        root.emptyColor = plasmoid.configuration.emptyColor;
    }
}

function updateTodayBorderColor(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.todayBorderColor !== undefined) {
        root.todayBorderColor = plasmoid.configuration.todayBorderColor;
    }
}

function updateBackgroundColor(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration && plasmoid.configuration.backgroundColor !== undefined) {
        root.backgroundColor = plasmoid.configuration.backgroundColor;
    }
}
