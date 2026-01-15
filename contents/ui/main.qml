import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

PlasmoidItem {
    id: root
    width: 440
    height: 140

    property int margin: 6
    property int gap: 2
    property int percentAreaHeight: 22

    property string orientation: "horizontal"
    property int maxSquare: 14

    property int totalDays: daysInYear()
    property int todayIndex: dayOfYear()

    property real availableWidth: root.width - 2 * margin
    property real availableHeight: root.height - 2 * margin

    property int gridColumns: Math.max(1, Math.ceil(Math.sqrt(totalDays * (availableWidth / availableHeight))))
    property int gridRows: Math.ceil(totalDays / gridColumns)

    property real cellSize: Math.min(
        maxSquare,
        (availableWidth - (gridColumns - 1) * gap) / gridColumns,
        (availableHeight - (gridRows - 1) * gap) / gridRows
    )

    property color filledColor: (PlasmaCore.Theme && PlasmaCore.Theme.highlightColor) ? PlasmaCore.Theme.highlightColor : "#3daee9"
    property color emptyColor: (PlasmaCore.Theme && PlasmaCore.Theme.midColor) ? PlasmaCore.Theme.midColor : "#bfbfbf"
    property color todayBorder: (PlasmaCore.Theme && PlasmaCore.Theme.highlightColor) ? PlasmaCore.Theme.highlightColor : "#3daee9"
    property color bgColor: (PlasmaCore.Theme && PlasmaCore.Theme.backgroundColor) ? PlasmaCore.Theme.backgroundColor : "transparent"
    property color textColor: (PlasmaCore.Theme && PlasmaCore.Theme.textColor) ? PlasmaCore.Theme.textColor : "#ffffff"

    Component.onCompleted: {
        if (plasmoid && plasmoid.configuration) {
            if (plasmoid.configuration.maxSquare !== undefined && plasmoid.configuration.maxSquare !== null) {
                maxSquare = parseInt(plasmoid.configuration.maxSquare) || maxSquare
            }
        }
    }

    Connections {
        target: plasmoid.configuration
        onMaxSquareChanged: {
            if (plasmoid && plasmoid.configuration && plasmoid.configuration.maxSquare !== undefined) {
                maxSquare = parseInt(plasmoid.configuration.maxSquare) || maxSquare
            }
        }
    }

    fullRepresentation: Item {
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            color: bgColor
            radius: 4

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: margin
                spacing: 4

                Flickable {
                    id: flick
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    width: availableWidth
                    height: availableHeight
                    contentWidth: Math.max(width, gridColumns * (cellSize + gap) - gap)
                    contentHeight: Math.max(height, gridRows * (cellSize + gap) - gap)

                    Item {
                        id: gridContainer
                        width: gridColumns * (cellSize + gap) - gap
                        height: gridRows * (cellSize + gap) - gap
                        anchors.centerIn: parent

                        Repeater {
                            id: rep
                            model: totalDays
                            delegate: Rectangle {
                                property int dayNumber: index + 1

                                readonly property int cellRow: Math.floor((dayNumber - 1) / gridColumns)
                                readonly property int cellCol: (dayNumber - 1) % gridColumns

                                width: cellSize
                                height: cellSize
                                x: cellCol * (cellSize + gap)
                                y: cellRow * (cellSize + gap)
                                radius: Math.max(1, Math.floor(cellSize * 0.15))
                                property bool passed: (cellRow * gridColumns + cellCol + 1) <= todayIndex
                                color: passed ? filledColor : emptyColor
                                border.width: 0
                                border.color: "transparent"
                            }
                        }
                    }
                }
            }
        }
    }

    function dayOfYear() {
        const now = new Date()
        const start = new Date(now.getFullYear(),0,1)
        return Math.floor((now - start) / (1000*60*60*24)) + 1
    }
    function daysInYear() {
        const y = (new Date()).getFullYear()
        return ((y % 4 === 0 && y % 100 !== 0) || (y % 400 === 0)) ? 366 : 365
    }
}
