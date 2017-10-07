import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0

Window
{
    id: root
    visible: true
    width: 300
    height: 400

    flags: Qt.FramelessWindowHint | Qt.WA_TranslucentBackground
    color: "#00000000"
    title: qsTr("QmlPomodoroTimer")

    PomodoroTimer
    {
        anchors.centerIn: parent
        state: "Reset"
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        z: -1
        property int lastPositionX: 0
        property int lastPositionY: 0

        onPressed:
        {
            lastPositionX = mouse.x
            lastPositionY = mouse.y
        }
        onMouseXChanged: root.x += mouse.x - lastPositionX
        onMouseYChanged: root.y += mouse.y - lastPositionY
    }

}
