import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1

Row {
    id: colorSettingsItem
    spacing: parent.spacing
    height: colorLabel.implicitHeight * 2.0
    property string title: ""
    property alias color: colorRect.color
    signal click
    Label {
        id: textLabel
        text: "<b>"+parent.title+":</b> "
        anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle {
        id: colorRect
        color: "black"
        height: parent.height
        width: height * 2
        border.color: "black"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                click()
            }
        }
    }
    Label {
        id: colorLabel
        text: "[" + colorRect.color + "]"
        anchors.verticalCenter: parent.verticalCenter
    }
}
