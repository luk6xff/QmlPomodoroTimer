import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0

Window
{
    id: root
    visible: true
    width: 300
    height: 350 //Screen.desktopAvailableHeight
    onBeforeRendering:
    {
      debug(height);
      debug(width)
    }

    flags: Qt.ToolTip | Qt.FramelessWindowHint | Qt.WA_TranslucentBackground
    color: "#00000000"
    title: qsTr("QmlPomodoroTimer")

    function debug(param)
    {
        //console.log(param)
    }

    PomodoroTimer
    {
        anchors.centerIn: parent
    }

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        z: -1
        property int lastPositionX: 0
        property int lastPositionY: 0
        onReleased:
        {
             var point = mapToGlobal(mouseX, mouseY)
             root.x = point.x - lastPositionX
             root.y = point.y - lastPositionY
        }
        onPressAndHold:
        {
            var point = mapToGlobal(mouseX, mouseY)
            lastPositionX = point.x
            lastPositionY = point.y
        }
    }

}
