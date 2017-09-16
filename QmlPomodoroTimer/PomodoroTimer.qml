import QtQuick 2.0


Item
{
    id: pomodoro
    anchors.fill: parent
    //anchors.centerIn: parent
    //height: timer.height
    //width: timer.width
    Rectangle
    {
       id : timer
       anchors.centerIn: parent
       width: 300
       height: 300
       radius: 150
       //transformOrigin: Item.Center
       property alias timeText: time.text
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
           text: qsTr("24:59")
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
            }
        }
    }
}

