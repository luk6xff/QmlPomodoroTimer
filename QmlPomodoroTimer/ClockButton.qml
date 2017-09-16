import QtQuick 2.0

Item {

    id: button
    width: 68
    height: 43
    property alias buttonText: buttonName.text
    property color color: "blue"
    property color hoverColor: "green"
    property color pressColor: "red"
    property int fontSize: 10
    property int borderWidth: 1
    property int borderRadius: 5
    scale: state === "Pressed" ? 0.6 : 1.0
    onEnabledChanged: state = ""
    signal clicked

    // scale animation
    Behavior on scale {
        NumberAnimation {
            duration: 100
            easing.type: Easing.InOutQuad
        }
    }

    // Rectangle to draw the button
    Rectangle {
        id: rectangleButton
        anchors.fill: parent
        radius: borderRadius
        color: button.enabled ? button.color : "grey"
        border.width: borderWidth
        border.color: "black"
    }

    Text {
        id: buttonName
        font.pointSize: fontSize
        anchors.centerIn: parent
    }



    // modify color of the button in different button states
    states: [
        State {
            name: "Hovering"
            when: mouseArea.containsMouse
            PropertyChanges {
                target: rectangleButton
                color: hoverColor
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: rectangleButton
                color: pressColor
            }
        }
    ]

    // transitions between states
    transitions: [
        Transition {
            from: ""
            to: "Hovering"
            ColorAnimation { duration: 200 }
        },
        Transition {
            from: "*"
            to: "Pressed"
            ColorAnimation { duration: 200 }
        }
    ]

    // Mouse area to react on click events
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: { button.state="Hovering"}
        onExited: { button.state=""}
        onClicked: { button.clicked();}
        onPressed: { button.state="Pressed" }
        onReleased: {
            if (containsMouse)
            {
              button.state="Hovering";
            }
            else
            {
              button.state="";
            }
        }
    }

    onClicked: console.log("Clicked!")
}
