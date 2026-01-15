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

    property int gridColumns: orientation === "vertical-heatmap" ? 53 : Math.max(1, Math.ceil(Math.sqrt(totalDays * (availableWidth / availableHeight))))
    property int gridRows: orientation === "vertical-heatmap" ? 7 : Math.ceil(totalDays / gridColumns)

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
            if (plasmoid.configuration.orientation) orientation = plasmoid.configuration.orientation
        }
    }

    Connections {
        target: plasmoid.configuration
        onMaxSquareChanged: {
            if (plasmoid && plasmoid.configuration && plasmoid.configuration.maxSquare !== undefined) {
                maxSquare = parseInt(plasmoid.configuration.maxSquare) || maxSquare
            }
        }
        onOrientationChanged: {
            if (plasmoid && plasmoid.configuration && plasmoid.configuration.orientation !== undefined) {
                orientation = plasmoid.configuration.orientation
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

                                readonly property int cellRow: orientation === "vertical-heatmap" ? dayOfWeek(dayNumber) : Math.floor((dayNumber - 1) / gridColumns)
                                readonly property int cellCol: orientation === "vertical-heatmap" ? weekOfYear(dayNumber) : (dayNumber - 1) % gridColumns

                                width: cellSize
                                height: cellSize
                                x: cellCol * (cellSize + gap)
                                y: cellRow * (cellSize + gap)
                                radius: Math.max(1, Math.floor(cellSize * 0.15))
                                property bool passed: {
                                    if (orientation === "vertical-heatmap") {
                                        return dayNumber <= todayIndex
                                    } else if (orientation === "vertical") {
                                        return (cellCol * gridRows + cellRow + 1) <= todayIndex
                                    } else {
                                        return (cellRow * gridColumns + cellCol + 1) <= todayIndex
                                    }
                                }
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
    function dayOfWeek(dayNumber) {
        const year = (new Date()).getFullYear()
        const date = new Date(year, 0, dayNumber)
        return date.getDay()
    }
    function weekOfYear(dayNumber) {
        const year = (new Date()).getFullYear()
        const date = new Date(year, 0, dayNumber)
        const firstDayOfYear = new Date(year, 0, 1)
        const firstDayOfWeek = firstDayOfYear.getDay()
        const daysSinceFirstSunday = (dayNumber - 1 + firstDayOfWeek) % 7
        return Math.floor((dayNumber - 1 + firstDayOfWeek) / 7)
    }
}
