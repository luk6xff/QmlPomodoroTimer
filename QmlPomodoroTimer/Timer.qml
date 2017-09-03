import QtQuick 2.0

Rectangle {
   id : timer
   x: 170
   y: 72
   width: 300
   height: 300
   radius: 150
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

   Text {
       id: time
       x: 67
       y: 61
       width: 164
       height: 43
       color: "#0c4e08"
       text: qsTr("Text")
       font.capitalization: Font.Capitalize
       font.bold: true
       font.family: "Tahoma"
       horizontalAlignment: Text.AlignHCenter
       verticalAlignment: Text.AlignVCenter
       font.pixelSize: 30
   }

   Rectangle {
       id: reset_button
       x: 116
       width: 68
       height: 43
       color: "#ffffff"
       z: 0
       rotation: 0
       anchors.top: parent.top
       anchors.topMargin: -37
   }

   ClockButton {

   }
   Rectangle {
       id: start_button
       x: 14
       y: 1
       width: 68
       height: 43
       color: "#ffffff"
       anchors.top: parent.top
       z: 0
       anchors.topMargin: 0
       rotation: -39
   }

   Rectangle {
       id: stop_button
       x: 218
       y: 7
       width: 68
       height: 43
       color: "#ffffff"
       anchors.top: parent.top
       z: 0
       rotation: 39
       anchors.topMargin: 0
   }
}
