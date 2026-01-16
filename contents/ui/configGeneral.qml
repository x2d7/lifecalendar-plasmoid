import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 6.5
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.plasmoid 2.0
import "js/constants.js" as Constants

Kirigami.Page {
    id: page
    title: qsTr("General")

    property int cfg_maxSquare: Constants.DEFAULT_MAX_SQUARE
    property int cfg_maxSquareDefault: Constants.DEFAULT_MAX_SQUARE
    property string cfg_orientation: Constants.ORIENTATIONS.HORIZONTAL
    property string cfg_orientationDefault: Constants.ORIENTATIONS.HORIZONTAL
    property int cfg_width: Constants.DEFAULT_WIDTH
    property int cfg_widthDefault: Constants.DEFAULT_WIDTH
    property int cfg_height: Constants.DEFAULT_HEIGHT
    property int cfg_heightDefault: Constants.DEFAULT_HEIGHT
    property int cfg_margin: Constants.DEFAULT_MARGIN
    property int cfg_marginDefault: Constants.DEFAULT_MARGIN
    property int cfg_gap: Constants.DEFAULT_GAP
    property int cfg_gapDefault: Constants.DEFAULT_GAP
    property int cfg_backgroundRadius: Constants.DEFAULT_BACKGROUND_RADIUS
    property int cfg_backgroundRadiusDefault: Constants.DEFAULT_BACKGROUND_RADIUS
    property double cfg_cellRadiusFactor: Constants.DEFAULT_CELL_RADIUS_FACTOR
    property double cfg_cellRadiusFactorDefault: Constants.DEFAULT_CELL_RADIUS_FACTOR
    property int cfg_cellBorderWidth: Constants.DEFAULT_CELL_BORDER_WIDTH
    property int cfg_cellBorderWidthDefault: Constants.DEFAULT_CELL_BORDER_WIDTH
    property int cfg_updateInterval: Constants.UPDATE_INTERVALS.DAILY
    property int cfg_updateIntervalDefault: Constants.UPDATE_INTERVALS.DAILY
    property bool cfg_useCustomColors: false
    property bool cfg_useCustomColorsDefault: false
    property color cfg_filledColor: "#3daee9"
    property color cfg_filledColorDefault: "#3daee9"
    property color cfg_emptyColor: "#bfbfbf"
    property color cfg_emptyColorDefault: "#bfbfbf"
    property color cfg_todayBorderColor: "#3daee9"
    property color cfg_todayBorderColorDefault: "#3daee9"
    property color cfg_backgroundColor: "#00000000"
    property color cfg_backgroundColorDefault: "#00000000"

    Kirigami.FormLayout {
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing

        ComboBox {
            id: orientationCombo
            Kirigami.FormData.label: qsTr("Orientation")
            model: Object.values(Constants.ORIENTATIONS)

            Component.onCompleted: {
                currentIndex = model.indexOf(cfg_orientation)
            }

            onActivated: {
                var newVal = model[currentIndex]
                plasmoid.configuration.orientation = newVal
                cfg_orientation = newVal
            }
        }

        SpinBox {
            id: maxSquareSpin
            Kirigami.FormData.label: qsTr("Max square size")
            from: Constants.MIN_SQUARE
            to: Constants.MAX_SQUARE

            Component.onCompleted: {
                value = cfg_maxSquare
            }

            onValueModified: {
                plasmoid.configuration.maxSquare = value
                cfg_maxSquare = value
            }
        }

        SpinBox {
            id: gapSpin
            Kirigami.FormData.label: qsTr("Gap between cells")
            from: 0
            to: 20

            Component.onCompleted: {
                value = cfg_gap
            }

            onValueModified: {
                plasmoid.configuration.gap = value
                cfg_gap = value
            }
        }

        SpinBox {
            id: backgroundRadiusSpin
            Kirigami.FormData.label: qsTr("Background radius")
            from: Constants.MIN_BACKGROUND_RADIUS
            to: Constants.MAX_BACKGROUND_RADIUS

            Component.onCompleted: {
                value = cfg_backgroundRadius
            }

            onValueModified: {
                plasmoid.configuration.backgroundRadius = value
                cfg_backgroundRadius = value
            }
        }

        SpinBox {
            id: cellBorderWidthSpin
            Kirigami.FormData.label: qsTr("Cell border width")
            from: Constants.MIN_CELL_BORDER_WIDTH
            to: Constants.MAX_CELL_BORDER_WIDTH

            Component.onCompleted: {
                value = cfg_cellBorderWidth
            }

            onValueModified: {
                plasmoid.configuration.cellBorderWidth = value
                cfg_cellBorderWidth = value
            }
        }

        ComboBox {
            id: updateIntervalCombo
            Kirigami.FormData.label: qsTr("Update interval")
            model: [
                qsTr("Hourly"),
                qsTr("Daily"),
                qsTr("Weekly"),
                qsTr("Monthly")
            ]
            property var intervals: [
                Constants.UPDATE_INTERVALS.HOURLY,
                Constants.UPDATE_INTERVALS.DAILY,
                Constants.UPDATE_INTERVALS.WEEKLY,
                Constants.UPDATE_INTERVALS.MONTHLY
            ]

            Component.onCompleted: {
                var index = intervals.indexOf(cfg_updateInterval)
                if (index >= 0) {
                    currentIndex = index
                }
            }

            onActivated: {
                var newVal = intervals[currentIndex]
                plasmoid.configuration.updateInterval = newVal
                cfg_updateInterval = newVal
            }
        }

        CheckBox {
            id: useCustomColorsCheck
            Kirigami.FormData.label: qsTr("Use custom colors")
            checked: cfg_useCustomColors

            onCheckedChanged: {
                plasmoid.configuration.useCustomColors = checked
                cfg_useCustomColors = checked
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
        }

        Label {
            text: qsTr("Custom Colors")
            font.bold: true
            visible: cfg_useCustomColors
        }

        RowLayout {
            Kirigami.FormData.label: qsTr("Filled days color")
            visible: cfg_useCustomColors

            Rectangle {
                width: 32
                height: 32
                color: cfg_filledColor
                border.color: "black"
                border.width: 1

                MouseArea {
                    anchors.fill: parent
                    onClicked: filledColorDialog.open()
                }
            }

            Button {
                text: qsTr("Choose...")
                onClicked: filledColorDialog.open()
            }
        }

        ColorDialog {
            id: filledColorDialog
            title: qsTr("Choose filled days color")
            selectedColor: cfg_filledColor
            onAccepted: {
                plasmoid.configuration.filledColor = selectedColor
                cfg_filledColor = selectedColor
            }
        }

        RowLayout {
            Kirigami.FormData.label: qsTr("Empty days color")
            visible: cfg_useCustomColors

            Rectangle {
                width: 32
                height: 32
                color: cfg_emptyColor
                border.color: "black"
                border.width: 1

                MouseArea {
                    anchors.fill: parent
                    onClicked: emptyColorDialog.open()
                }
            }

            Button {
                text: qsTr("Choose...")
                onClicked: emptyColorDialog.open()
            }
        }

        ColorDialog {
            id: emptyColorDialog
            title: qsTr("Choose empty days color")
            selectedColor: cfg_emptyColor
            onAccepted: {
                plasmoid.configuration.emptyColor = selectedColor
                cfg_emptyColor = selectedColor
            }
        }

        RowLayout {
            Kirigami.FormData.label: qsTr("Today border color")
            visible: cfg_useCustomColors

            Rectangle {
                width: 32
                height: 32
                color: cfg_todayBorderColor
                border.color: "black"
                border.width: 1

                MouseArea {
                    anchors.fill: parent
                    onClicked: todayBorderColorDialog.open()
                }
            }

            Button {
                text: qsTr("Choose...")
                onClicked: todayBorderColorDialog.open()
            }
        }

        ColorDialog {
            id: todayBorderColorDialog
            title: qsTr("Choose today border color")
            selectedColor: cfg_todayBorderColor
            onAccepted: {
                plasmoid.configuration.todayBorderColor = selectedColor
                cfg_todayBorderColor = selectedColor
            }
        }

        RowLayout {
            Kirigami.FormData.label: qsTr("Background color")
            visible: cfg_useCustomColors

            Rectangle {
                width: 32
                height: 32
                color: cfg_backgroundColor
                border.color: "black"
                border.width: 1

                MouseArea {
                    anchors.fill: parent
                    onClicked: backgroundColorDialog.open()
                }
            }

            Button {
                text: qsTr("Choose...")
                onClicked: backgroundColorDialog.open()
            }
        }

        ColorDialog {
            id: backgroundColorDialog
            title: qsTr("Choose background color")
            selectedColor: cfg_backgroundColor
            onAccepted: {
                plasmoid.configuration.backgroundColor = selectedColor
                cfg_backgroundColor = selectedColor
            }
        }
    }
}
