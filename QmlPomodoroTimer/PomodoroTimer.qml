import QtQuick 2.8
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import QtMultimedia 5.8
import "."
import "PomodoroUtils.js" as Utils



Item
{
    id: pomodoro
    anchors.fill: parent
    state: "Reset"

    Rectangle
    {
       id : plate
       anchors.centerIn: parent
       width: 280
       height: 280
       radius: 140
       anchors.verticalCenterOffset: 0
       anchors.horizontalCenterOffset: 0
       /*Image {
           id: pomodoroImg
           anchors.fill: plate
           anchors.centerIn: plate
           width: parent.width; height: parent.height
           fillMode: Image.PreserveAspectFit
           sourceSize.width: 1024
           sourceSize.height: 1024
           source: "qrc:/pomodoroImg.png"
       }*/
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
           anchors.verticalCenterOffset: 16
           width: 164
           height: 43
           color: "#0c4e08"
           text: Utils.formatDisplayedTime(clock.minutes, clock.seconds)
           font.capitalization: Font.Capitalize
           font.bold: true
           font.family: "Tahoma"
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignVCenter
           font.pixelSize: 70
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
                enabled: ((pomodoro.state === "Reset" ||
                          pomodoro.state === "Stop")
                          ? true : false)
                onClicked:
                {
                    if (pomodoro.state === "Reset" ||
                         pomodoro.state === "Stop")
                    {
                        pomodoro.state = "Reset"
                        playAlarm.stop()
                        resetIntervalValues(intervalListView.model.get(intervalListView.currentIndex))
                    }
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
                    pomodoro.state = "Active"
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
                    pomodoro.state = "Stop"
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
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        if (pomodoro.state === "Reset")
                        {
                            intervalListView.currentIndex = index
                        }
                    }
                }
            }
        }

        ListView {
            id: intervalListView
            boundsBehavior: Flickable.StopAtBounds
            visible: true
            Layout.alignment: Qt.AlignCenter
            spacing: width/3
            width: plate.width/2
            scale: 1
            antialiasing: true
            anchors.verticalCenterOffset: -75
            anchors.verticalCenter: plate.verticalCenter
            anchors.horizontalCenter: plate.horizontalCenter
            interactive: true
            layoutDirection: Qt.LeftToRight
            orientation: ListView.Horizontal
            model: intervalModel
            delegate: intervalDelegate
            focus: true
            currentIndex: 0

            Component.onCompleted:
            {
              currentIndex: 0
              model.get(currentIndex).activestate = true;
              resetIntervalValues(model.get(currentIndex))
              positionViewAtIndex(1, ListView.Center)
            }

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

                if (currentIndex >= 0 && currentIndex < intervalListView.count)
                {
                    resetIntervalValues(model.get(currentIndex))
                }
                positionViewAtIndex(1, ListView.Center)
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
    }

    //machine state
    states: [
        State {
            name: "Active"
            PropertyChanges {
                target: clock
                running: true
            }
            PropertyChanges {
                target: intervalListView
                opacity: 0.5
            }
        },
        State {
            name: "Stop"
            PropertyChanges {
                target: clock
                running: false
            }
            PropertyChanges {
                target: intervalListView
                opacity: 0.5
            }
        },
        State {
            name: "Reset"
            PropertyChanges {
                target: clock
                running: false
            }
            PropertyChanges {
                target: intervalListView
                opacity: 1
            }
        }
    ]


    MediaPlayer
    {
        id: playAlarm
        loops: MediaPlayer.Infinite
        source: "qrc:/sounds/sound0.mp3"
        volume: QtMultimedia.convertVolume(GlobalSettings.main.alarmVolume / 100.0,
                                           QtMultimedia.LogarithmicVolumeScale,
                                           QtMultimedia.LinearVolumeScale)
    }

    Clock
    {
        id: clock
        running: false
        onTimePassed:
        {
            pomodoro.state = "Stop"
            playAlarm.play()
        }
    }
}

