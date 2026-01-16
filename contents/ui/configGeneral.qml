import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.plasmoid 2.0
import "js/constants.js" as Constants

Kirigami.Page {
    id: page
    title: qsTr("General")

    property var cfg_maxSquare
    property var cfg_orientation

    Kirigami.FormLayout {
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing

        ComboBox {
            Kirigami.FormData.label: qsTr("Orientation")
            model: Object.values(Constants.ORIENTATIONS)

            currentIndex: {
                if (plasmoid.configuration.orientation === Constants.ORIENTATIONS.VERTICAL) return 1
                if (plasmoid.configuration.orientation === Constants.ORIENTATIONS.VERTICAL_HEATMAP) return 2
                return 0
            }

            onActivated: {
                plasmoid.configuration.orientation = currentText
            }
        }

        SpinBox {
            Kirigami.FormData.label: qsTr("Max square size")
            from: Constants.MIN_SQUARE
            to: Constants.MAX_SQUARE

            value: plasmoid.configuration.maxSquare > 0
                   ? plasmoid.configuration.maxSquare
                   : Constants.DEFAULT_MAX_SQUARE

            onValueModified: {
                plasmoid.configuration.maxSquare = value
            }
        }
    }
}
