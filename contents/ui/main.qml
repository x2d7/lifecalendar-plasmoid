import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import "js/MainModel.js" as MainModel
import "js/constants.js" as Constants
import "js/themeManager.js" as ThemeManager

PlasmoidItem {
    id: root
    width: 440
    height: 140

    property int margin: Constants.DEFAULT_MARGIN
    property int gap: Constants.DEFAULT_GAP
    property int percentAreaHeight: 22

    property string orientation: Constants.ORIENTATIONS.HORIZONTAL
    property int maxSquare: Constants.DEFAULT_MAX_SQUARE

    property int totalDays: MainModel.daysInYear()
    property int todayIndex: MainModel.dayOfYear()

    property real availableWidth: root.width - 2 * margin
    property real availableHeight: root.height - 2 * margin

    property int gridColumns: orientation === Constants.ORIENTATIONS.VERTICAL_HEATMAP ? 53 : Math.max(1, Math.ceil(Math.sqrt(totalDays * (availableWidth / availableHeight))))
    property int gridRows: orientation === Constants.ORIENTATIONS.VERTICAL_HEATMAP ? 7 : Math.ceil(totalDays / gridColumns)

    property real cellSize: Math.min(
        maxSquare,
        (availableWidth - (gridColumns - 1) * gap) / gridColumns,
        (availableHeight - (gridRows - 1) * gap) / gridRows
    )

    property color filledColor: ThemeManager.getFilledColor(PlasmaCore.Theme)
    property color emptyColor: ThemeManager.getEmptyColor(PlasmaCore.Theme)
    property color todayBorder: ThemeManager.getTodayBorder(PlasmaCore.Theme)
    property color bgColor: ThemeManager.getBackground(PlasmaCore.Theme)
    property color textColor: ThemeManager.getTextColor(PlasmaCore.Theme)

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

                                readonly property int cellRow: orientation === Constants.ORIENTATIONS.VERTICAL_HEATMAP ? MainModel.dayOfWeek(dayNumber) : Math.floor((dayNumber - 1) / gridColumns)
                                readonly property int cellCol: orientation === Constants.ORIENTATIONS.VERTICAL_HEATMAP ? MainModel.weekOfYear(dayNumber) : (dayNumber - 1) % gridColumns

                                width: cellSize
                                height: cellSize
                                x: cellCol * (cellSize + gap)
                                y: cellRow * (cellSize + gap)
                                radius: Math.max(1, Math.floor(cellSize * 0.15))
                                property bool passed: {
                                    if (orientation === Constants.ORIENTATIONS.VERTICAL_HEATMAP) {
                                        return dayNumber <= todayIndex
                                    } else if (orientation === Constants.ORIENTATIONS.VERTICAL) {
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


}
