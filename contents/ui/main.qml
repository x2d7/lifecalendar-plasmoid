import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import "js/MainModel.js" as MainModel
import "js/constants.js" as Constants
import "js/themeManager.js" as ThemeManager
import "js/GridCalculator.js" as GridCalculator
import "js/ConfigHandler.js" as ConfigHandler

PlasmoidItem {
    id: root
    width: 440
    height: 140

    property int margin: Constants.DEFAULT_MARGIN
    property int gap: Constants.DEFAULT_GAP
    property int percentAreaHeight: 22

    property string orientation: Constants.ORIENTATIONS.HORIZONTAL
    property int maxSquare: Constants.DEFAULT_MAX_SQUARE

    property int updateTrigger: 0
    property int totalDays: { updateTrigger; MainModel.daysInYear() }
    property int todayIndex: { updateTrigger; MainModel.dayOfYear() }

    property real availableWidth: root.width - 2 * margin
    property real availableHeight: root.height - 2 * margin

    property int gridColumns: GridCalculator.calculateGridColumns(totalDays, availableWidth, availableHeight, orientation, Constants)
    property int gridRows: GridCalculator.calculateGridRows(totalDays, gridColumns, orientation, Constants)

    property real cellSize: GridCalculator.calculateCellSize(availableWidth, availableHeight, gridColumns, gridRows, gap, maxSquare)

    property color filledColor: ThemeManager.getFilledColor(PlasmaCore.Theme)
    property color emptyColor: ThemeManager.getEmptyColor(PlasmaCore.Theme)
    property color todayBorder: ThemeManager.getTodayBorder(PlasmaCore.Theme)
    property color bgColor: ThemeManager.getBackground(PlasmaCore.Theme)
    property color textColor: ThemeManager.getTextColor(PlasmaCore.Theme)

    Component.onCompleted: {
        ConfigHandler.initializeConfig(root, plasmoid, Constants)
    }

    Connections {
        target: plasmoid.configuration
        onMaxSquareChanged: ConfigHandler.updateMaxSquare(root, plasmoid, Constants)
        onOrientationChanged: ConfigHandler.updateOrientation(root, plasmoid, Constants)
    }

    Timer {
        id: dailyUpdateTimer
        repeat: true
        running: true
        interval: {
            var now = new Date();
            var midnight = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1, 0, 0, 0, 0);
            return midnight - now;
        }
        onTriggered: {
            updateTrigger++
            interval = 24 * 60 * 60 * 1000;
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

                                readonly property int cellRow: GridCalculator.getCellRow(dayNumber, gridColumns, orientation, Constants, MainModel)
                                readonly property int cellCol: GridCalculator.getCellCol(dayNumber, gridColumns, orientation, Constants, MainModel)

                                width: cellSize
                                height: cellSize
                                x: cellCol * (cellSize + gap)
                                y: cellRow * (cellSize + gap)
                                radius: Math.max(1, Math.floor(cellSize * 0.15))
                                property bool passed: GridCalculator.isDayPassed(dayNumber, todayIndex, orientation, cellRow, cellCol, gridRows, gridColumns, Constants)
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
