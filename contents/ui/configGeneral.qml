import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.plasmoid 2.0

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
            model: ["horizontal", "vertical", "vertical-heatmap"]

            currentIndex: {
                if (plasmoid.configuration.orientation === "vertical") return 1
                if (plasmoid.configuration.orientation === "vertical-heatmap") return 2
                return 0
            }

            onActivated: {
                plasmoid.configuration.orientation = currentText
            }
        }

        SpinBox {
            Kirigami.FormData.label: qsTr("Max square size")
            from: 6
            to: 64

            value: plasmoid.configuration.maxSquare > 0
                   ? plasmoid.configuration.maxSquare
                   : 14

            onValueModified: {
                plasmoid.configuration.maxSquare = value
            }
        }
    }
}
