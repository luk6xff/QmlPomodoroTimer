import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Window 2.0

Window {
    visible: true
    title: root.title + " - settings"
    width: 400
    height: 400

    TabView {
        anchors.fill: parent
        anchors.margins: 8
        Tab {
            title: "Settings"
            Settings { anchors.fill:parent }
        }
        Tab {
            title: "Colors"
            Colors { }
        }
    }
}
