import QtQuick 2.3
import QtQuick.Controls 2.1

Menu
{
    id: contextMenu
    x: parent.x
    y: parent.y
    height: closeApp.height * 2 + column.spacing * 2
    width: closeApp.width

    Column {
        id: column
        anchors.centerIn: parent;
        spacing: 1
        ContextMenuItem{
            id: settings
            text: "Settings"
            onTriggered:
            {
                var component = Qt.createComponent("SettingsDialog.qml");
                var settings = component.createObject(root);
                settings.show()
            }
        }
        ContextMenuItem {
            id: closeApp
            text: "Close App"
            onTriggered: Qt.quit()
        }
    }
}
