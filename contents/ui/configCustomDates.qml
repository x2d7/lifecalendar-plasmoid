import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 6.5
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.plasmoid 2.0

Kirigami.Page {
    id: page
    title: qsTr("Custom Dates")
    
    property string cfg_customDates: "[]"
    property string cfg_customDatesDefault: "[]"
    
    property var customDatesArray: []
    
    function parseCustomDates() {
        try {
            customDatesArray = JSON.parse(cfg_customDates)
            customDatesModel.clear()
            customDatesArray.forEach(function(dateObj) {
                customDatesModel.append(dateObj)
            })
        } catch (e) {
            console.error("Error parsing custom dates:", e)
            customDatesArray = []
            customDatesModel.clear()
        }
    }
    
    function saveCustomDates() {
        var datesArray = []
        for (var i = 0; i < customDatesModel.count; i++) {
            var item = customDatesModel.get(i)
            datesArray.push({
                "day": item.day,
                "month": item.month,
                "description": item.description,
                "color": item.color
            })
        }
        cfg_customDates = JSON.stringify(datesArray)
        plasmoid.configuration.customDates = cfg_customDates
    }
    
    Component.onCompleted: {
        parseCustomDates()
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Kirigami.Units.largeSpacing
        
        Label {
            text: qsTr("Custom Dates with Special Borders")
            font.bold: true
            font.pointSize: 12
        }
        
        Label {
            text: qsTr("Add specific dates that will have colored borders and tooltips")
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
        }
        
        ListView {
            id: datesListView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: ListModel {
                id: customDatesModel
            }
            
            delegate: Kirigami.SwipeListItem {
                id: listItem
                width: ListView.view.width
                
                contentItem: RowLayout {
                    spacing: Kirigami.Units.largeSpacing
                    
                    Rectangle {
                        width: 32
                        height: 32
                        color: model.color
                        border.color: "black"
                        border.width: 1
                        radius: 4
                        
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                editDialog.selectedColor = model.color
                                editColorDialog.open()
                            }
                        }
                    }
                    
                    ColumnLayout {
                        Label {
                            text: qsTr("Day %1 of month %2").arg(model.day).arg(model.month)
                            font.bold: true
                        }
                        Label {
                            text: model.description
                            elide: Text.ElideRight
                            Layout.fillWidth: true
                        }
                    }
                }
                
                actions: [
                    Kirigami.Action {
                        icon.name: "document-edit"
                        tooltip: qsTr("Edit")
                        onTriggered: {
                            editDialog.editIndex = index
                            editDialog.dayValue = model.day
                            editDialog.monthValue = model.month
                            editDialog.description = model.description
                            editDialog.selectedColor = model.color
                            editDialog.open()
                        }
                    },
                    Kirigami.Action {
                        icon.name: "edit-delete"
                        tooltip: qsTr("Delete")
                        onTriggered: {
                            customDatesModel.remove(index)
                            saveCustomDates()
                        }
                    }
                ]
            }
        }
        
        Button {
            text: qsTr("Add New Date")
            icon.name: "list-add"
            Layout.alignment: Qt.AlignHCenter
            
            onClicked: {
                editDialog.editIndex = -1
                editDialog.dayValue = 1
                editDialog.monthValue = 1
                editDialog.description = ""
                editDialog.selectedColor = "#ff0000"
                editDialog.open()
            }
        }
    }
    
    Kirigami.Dialog {
        id: editDialog
        title: qsTr("Edit Custom Date")
        
        property int editIndex: -1
        property int dayValue: 1
        property int monthValue: 1
        property string description: ""
        property color selectedColor: "#ff0000"
        
        standardButtons: Dialog.Save | Dialog.Cancel
        
        onAccepted: {
            if (editIndex >= 0) {
                // Update existing
                customDatesModel.set(editIndex, {
                    "day": dayValue,
                    "month": monthValue,
                    "description": description,
                    "color": selectedColor
                })
            } else {
                // Add new
                customDatesModel.append({
                    "day": dayValue,
                    "month": monthValue,
                    "description": description,
                    "color": selectedColor
                })
            }
            saveCustomDates()
        }
        
        Kirigami.FormLayout {
            anchors.fill: parent
            
            SpinBox {
                id: daySpinBox
                Kirigami.FormData.label: qsTr("Day:")
                from: 1
                to: 31
                value: editDialog.dayValue
                onValueChanged: editDialog.dayValue = value
            }
            
            SpinBox {
                id: monthSpinBox
                Kirigami.FormData.label: qsTr("Month:")
                from: 1
                to: 12
                value: editDialog.monthValue
                onValueChanged: editDialog.monthValue = value
            }
            
            TextField {
                id: descriptionField
                Kirigami.FormData.label: qsTr("Description:")
                placeholderText: qsTr("Enter date description")
                text: editDialog.description
                onTextChanged: editDialog.description = text
                Layout.fillWidth: true
            }
            
            RowLayout {
                Kirigami.FormData.label: qsTr("Border Color:")
                
                Rectangle {
                    width: 32
                    height: 32
                    color: editDialog.selectedColor
                    border.color: "black"
                    border.width: 1
                    radius: 4
                    
                    MouseArea {
                        anchors.fill: parent
                        onClicked: editColorDialog.open()
                    }
                }
                
                Button {
                    text: qsTr("Choose...")
                    onClicked: editColorDialog.open()
                }
            }
        }
    }
    
    ColorDialog {
        id: editColorDialog
        title: qsTr("Choose Border Color")
        selectedColor: editDialog.selectedColor
        onAccepted: {
            editDialog.selectedColor = selectedColor
        }
    }
}