import QtQuick 2.3
import QtQuick.Controls 2.1

Item {
    Menu
    {

    }
    id: contextMenuWindow
    Rectangle {
        id: contextMenuRect
        color: "white";
        width: 60;
        height: 40;
        x: parent.x
        y: parent.y

        Column {
            //anchors.centerIn: parent;
            spacing: 1
            ContextMenuItem {
                //focus: true
                color: "lightblue"
            }
            ContextMenuItem {
                color: "palegreen"
            }
        }
    }
}
