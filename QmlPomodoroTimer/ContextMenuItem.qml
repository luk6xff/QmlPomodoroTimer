import QtQuick 2.0
import QtQuick.Controls 2.1

MenuItem {
    id: contextMenuItem
    text: qsTr("...")
    height: 30
    width: 90
    contentItem: Text {
        text: contextMenuItem.text
        font: contextMenuItem.font
        opacity: enabled ? 1.0 : 0.3
        color: contextMenuItem.down ? "black" : "green"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    antialiasing: true
    background: Rectangle {
        id: backgrnd
        implicitWidth: contextMenuItem.width
        implicitHeight: contextMenuItem.height
        opacity: enabled ? 1 : 0.3
        color: "LightSteelBlue"
        border.color: contextMenuItem.down ? "black" : "green"
        border.width: 1
        radius: 2
    }
}

