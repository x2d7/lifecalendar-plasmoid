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

        ComboBox {
            Kirigami.FormData.label: qsTr("Orientation")
            model: [
                { text: qsTr("Horizontal"), value: "horizontal" },
                { text: qsTr("Vertical"), value: "vertical" },
                { text: qsTr("Vertical (GitHub style)"), value: "vertical-heatmap" }
            ]
            textRole: "text"
            valueRole: "value"

            currentIndex: {
                const currentValue = plasmoid.configuration.orientation || "horizontal"
                return model.findIndex(item => item.value === currentValue)
            }

            onActivated: {
                plasmoid.configuration.orientation = model[currentIndex].value
            }
        }
    }
}
