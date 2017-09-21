import QtQuick 2.3
import QtQuick.Window 2.0

Window
{
    id: root
    visible: true
    width: 400
    height: 400 //Screen.desktopAvailableHeight
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
        //x: root.width/5
        //anchors.rightMargin: root.width/4
        anchors.centerIn: parent
    }
/*
    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        property int lastPositionX: 0
        property int lastPositionY: 0
        onClicked:
        {
            lastPositionX = mouseX
            lastPositionY = mouseY
        }

        onMouseXChanged:
        {
            root.x = mouseX - lastPositionX
        }
        onMouseYChanged:
        {
            root.y = mouseY - lastPositionY
        }
    }
    */

}
