import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.plasmoid 2.0
import "js/constants.js" as Constants

Kirigami.Page {
    id: page
    title: qsTr("General")

    property int cfg_maxSquare: Constants.DEFAULT_MAX_SQUARE
    property string cfg_orientation: Constants.ORIENTATIONS.HORIZONTAL
    property int cfg_maxSquareDefault: Constants.DEFAULT_MAX_SQUARE
    property string cfg_orientationDefault: Constants.ORIENTATIONS.HORIZONTAL

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
    }
}
