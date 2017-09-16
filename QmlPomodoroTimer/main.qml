import QtQuick 2.8
import QtQuick.Window 2.0

Window
{
    id: root
    visible: true
    width: 480
    height: 480 //Screen.desktopAvailableHeight
    onBeforeRendering:
    {
      debug(height);
      debug(width)
    }

    //flags: Qt.ToolTip | Qt.FramelessWindowHint | Qt.WA_TranslucentBackground
    //color: "#00000000"
    title: qsTr("QmlPomodoroTime")

    function debug(param)
    {
        console.log(param)
    }

    PomodoroTimer
    {
        //x: root.width/5
        //anchors.rightMargin: root.width/4
        anchors.centerIn: parent
    }

}
