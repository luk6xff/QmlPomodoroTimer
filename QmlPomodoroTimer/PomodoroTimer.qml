import QtQuick 2.8
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import "."
import "PomodoroUtils.js" as Utils



Item
{
    id: pomodoro
    anchors.fill: parent
    Rectangle
    {
       id : plate
       anchors.centerIn: parent
       width: 280
       height: 280
       radius: 140
       anchors.verticalCenterOffset: 0
       anchors.horizontalCenterOffset: 0
       property alias timeValue: time.text
       gradient: Gradient {
           GradientStop {
               position: 0.497
               color: "#f24444"
           }

           GradientStop {
               position: 1
               color: "#000000"
           }
       }

        Text
        {
           id: time
           anchors.centerIn: parent
           width: 164
           height: 43
           color: "#0c4e08"
           text: Utils.formatDisplayedTime(clock.minutes, clock.seconds)
           font.capitalization: Font.Capitalize
           font.bold: true
           font.family: "Tahoma"
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignVCenter
           font.pixelSize: 50
        }

        Item
        {
            height: parent.height/2
            x: parent.width/2
            y: 0
            transformOrigin: Item.Bottom
            rotation: 0

            ClockButton
            {
                id: resetButton
                buttonText: "Reset"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                anchors.bottomMargin: -10
                enabled: clock.running ? false : true
                onClicked:
                {
                    resetIntervalValues(intervalListView.model.get(intervalListView.currentIndex))
                }
            }
        }

        Item
        {
            height: parent.height/2
            x: parent.width/2
            y: 0
            transformOrigin: Item.Bottom
            rotation: 40

            ClockButton
            {
                id: startButton
                buttonText: "Start"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                anchors.bottomMargin: -10
                onClicked:
                {
                    clock.running = true;
                    changeIntervalOpacity()
                }
            }
        }

        Item
        {
            height: parent.height/2
            x: parent.width/2
            y: 0
            transformOrigin: Item.Bottom
            rotation: -40

            ClockButton
            {
                id: stopButton
                buttonText: "Stop"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.top
                anchors.bottomMargin: -10
                onClicked:
                {
                    clock.running = false;
                }
            }
        }

        ListModel
        {
            id: intervalModel
            ListElement {
                intname: "POMODORO"
                activestate: false
            }
            ListElement {
                intname: "SHORT-BREAK"
                activestate: false
            }
            ListElement {
                intname: "LONG-BREAK"
                activestate: false
            }
        }

        Component {
            id: intervalDelegate
            PomodoroInterval
            {
                name: model.intname
                active: model.activestate
                Layout.fillWidth: true
                Layout.fillHeight: true
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        if (!clock.running)
                        {
                            intervalListView.currentIndex = index
                        }
                    }
                }
            }
        }

        ListView {
            id: intervalListView
            Layout.alignment: Qt.AlignCenter
            spacing: 5
            width: plate.width/2
            antialiasing: true
            anchors.verticalCenterOffset: -75
            anchors.verticalCenter: plate.verticalCenter
            anchors.horizontalCenter: plate.horizontalCenter
            snapMode: ListView.NoSnap
            interactive: false
            layoutDirection: Qt.LeftToRight
            orientation: ListView.Horizontal
            model: intervalModel
            delegate: intervalDelegate
            focus: true
            Component.onCompleted: currentIndex = 0
            onCurrentIndexChanged:
            {
                for (var idx = 0; idx < intervalListView.count; idx++)
                {
                    if(idx != currentIndex)
                    {
                        model.get(idx).activestate = false;
                    }
                    else
                    {
                        model.get(idx).activestate = true;
                        //model.setProperty(idx,"activestate", true);
                    }
                }

                if (currentIndex < intervalListView.count && currentIndex >= 0)
                {
                    resetIntervalValues(model.get(currentIndex))
                }
            }
        }

        MouseArea
        {
            id: rectMouseArea
            anchors.fill: parent;
            acceptedButtons: Qt.RightButton
            onClicked:
            {
                var contextMenu;
                if (mouse.button === Qt.RightButton)
                {
                    var component;
                    //http://doc.qt.io/qt-5/qtqml-javascript-dynamicobjectcreation.html
                    component = Qt.createComponent("ContextMenu.qml");
                    var point = mapFromItem(parent, mouseX, mouseY)
                    contextMenu = component.createObject(parent, {"x":point.x, "y":point.y});
                    contextMenu.open()
                }
            }
        }
    }

    function resetIntervalValues(model)
    {
        clock.upOrDownCount = GlobalSettings.main.countMode
        switch (model.intname)
        {
            case "SHORT-BREAK":
                clock.setTime(GlobalSettings.main.shortBreakIntervalTimeMin,
                              GlobalSettings.main.shortBreakIntervalTimeSec)
                break;

            case "LONG-BREAK":
                clock.setTime(GlobalSettings.main.longBreakIntervalTimeMin,
                              GlobalSettings.main.longBreakIntervalTimeSec)
                break;

            case "POMODORO":
            default:
                clock.setTime(GlobalSettings.main.pomodoroIntervalTimeMin,
                              GlobalSettings.main.pomodoroIntervalTimeSec)
                break;
        }
        changeIntervalOpacity()
    }

    function changeIntervalOpacity()
    {
        if (clock.running)
        {
            intervalListView.opacity = 0.5
        }
        else
        {
            intervalListView.opacity = 1
        }
    }

    Clock
    {
        id: clock
        running: false
        onTimePassed:
        {
            changeIntervalOpacity()
        }
    }
}

