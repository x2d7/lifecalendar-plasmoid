import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
        name: qsTr("General")
        icon: "configure"
        source: "configGeneral.qml"
    }
    ConfigCategory {
        name: qsTr("Custom Dates")
        icon: "view-calendar"
        source: "configCustomDates.qml"
    }
}