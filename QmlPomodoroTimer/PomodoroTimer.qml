import QtQuick 2.8
import QtQuick.Layouts 1.0


Item
{
    id: pomodoro
    anchors.fill: parent
    Rectangle
    {
       id : plate
       anchors.centerIn: parent
       width: 300
       height: 300
       radius: 150
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
           text: clock.seconds
           font.capitalization: Font.Capitalize
           font.bold: true
           font.family: "Tahoma"
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignVCenter
           font.pixelSize: 30
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
                    clock.minutes = 0;
                    clock.seconds = 0;
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
            }
            ListElement {
                intname: "SHORT-BREAK"
            }
            ListElement {
                intname: "LONG-BREAK"
            }
        }

        Component {
            id: intervalDelegate
                PomodoroInterval
                {
                    name: intname
                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            intervalListView.currentIndex = index
                            parent.active = parent.active ^ 1
                        }
                    }
                }
        }
        function intervalTypeChanged()
        {
            //changedIdx =
        }
        ListView {
            id: intervalListView
            spacing: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 10
            height: parent.height/2
            width:  parent.width/2
            orientation: ListView.Horizontal
            model: intervalModel
            delegate: intervalDelegate
            highlight: Rectangle { color: "mediumseagreen"; radius: 5 }
            highlightFollowsCurrentItem: true
            focus: true
            Component.onCompleted: currentIndex = 0
            onCurrentIndexChanged:
            {
                for (var idx = 0; idx < intervalListView.count; idx++)
                {
                    if(idx != intervalListView.currentIndex)
                    {
                        intervalListView.model.setProperty(idx,"activae", false);
                    }
                    else
                    {
                        intervalListView.model.setProperty(idx,"active", true);
                    }
                }
            }
        }
    }


    Clock
    {
        id: clock
        running: true
        seconds: 0
        minutes: 0
        alarmSec: 5
    }
}

