import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.plasmoid 2.0

Kirigami.Page {
    id: page
    title: qsTr("General")

    property var cfg_squareSize

    Kirigami.FormLayout {
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing

        SpinBox {
            Kirigami.FormData.label: qsTr("Square size")
            from: 50
            to: 200

            value: plasmoid.configuration.squareSize > 0
                   ? plasmoid.configuration.squareSize
                   : 100

            onValueModified: {
                plasmoid.configuration.squareSize = value
            }
        }
    }
}
