.pragma library

function initializeConfig(root, plasmoid, constants) {
    if (plasmoid && plasmoid.configuration) {
        if (plasmoid.configuration.maxSquare !== undefined && plasmoid.configuration.maxSquare !== null) {
            root.maxSquare = parseInt(plasmoid.configuration.maxSquare) || constants.DEFAULT_MAX_SQUARE;
        }
        if (plasmoid.configuration.orientation) {
            root.orientation = plasmoid.configuration.orientation;
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
