import QtQuick 2.15
import org.kde.plasma.plasmoid 2.0

PlasmoidItem {
    id: root

    property int squareSize: plasmoid.configuration.squareSize || 100

    Component.onCompleted: {
        if (plasmoid && plasmoid.configuration && plasmoid.configuration.squareSize !== undefined) {
            squareSize = plasmoid.configuration.squareSize
        }
    }

    Connections {
        target: plasmoid.configuration
        onSquareSizeChanged: {
            if (plasmoid && plasmoid.configuration && plasmoid.configuration.squareSize !== undefined) {
                squareSize = plasmoid.configuration.squareSize
            }
        }
    }

    fullRepresentation: Item {
        anchors.fill: parent

        Rectangle {
            color: "blue"
            width: squareSize
            height: squareSize
            anchors.centerIn: parent
        }
    }
}
