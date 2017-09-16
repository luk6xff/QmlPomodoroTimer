import QtQuick 2.0


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


        Item
        {
            id: pomodoroIntervalContainer
            property int currentActiveInterval: 0
            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            Row
            {
                id: intervalContainer
                spacing: 5

                PomodoroInterval
                {
                    id: pomodoroIntervalPomodoro
                    name: "POMODORO"
                }
/*
                PomodoroInterval
                {
                    id: pomodoroIntervalShortBreak
                    name: "SHORT BREAK"
                }

*/
                PomodoroInterval
                {
                    id: pomodoroIntervalLongBreak
                    name: "LONG BREAK"
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

