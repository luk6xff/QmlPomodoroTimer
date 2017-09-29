import QtQuick 2.8
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import QmlPomodoroTimer.GlobalSettings 1.0
import "PomodoroUtils.js" as Utils



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
           text: Utils.formatDisplayedTime(clock.minutes, clock.seconds)
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
                    propagateComposedEvents: true
                    onClicked:
                    {
                        intervalListView.currentIndex = index
                        mouse.accepted = true
                    }
                }
            }
        }

        ListView {
            id: intervalListView
            Layout.alignment: Qt.AlignCenter
            spacing: 10
            //preferredHighlightBegin: parent.width/2 - parent.width/4
            //preferredHighlightEnd: parent.width/2 + parent.width/4
            highlightRangeMode: ListView.ApplyRange
            width: parent.width/2
            antialiasing: true
            anchors.verticalCenterOffset: -75
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            flickableDirection: Flickable.HorizontalFlick
            boundsBehavior: Flickable.StopAtBounds
            snapMode: ListView.NoSnap
            layoutDirection: Qt.LeftToRight
            orientation: ListView.Horizontal
            model: intervalModel
            delegate: intervalDelegate
            highlight: Rectangle {
                height: 20
                width: 20
                color: "mediumseagreen"
                radius: 5
            }
            highlightFollowsCurrentItem: true
            focus: true
            Component.onCompleted: currentIndex = 0
            onCurrentIndexChanged:
            {
                console.log(intervalListView.delegate.height, intervalListView.model.iconWidth)
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
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            propagateComposedEvents: true
            z: -1
            onClicked:
            {
                var contextMenu;
                if (mouse.button === Qt.LeftButton)
                {
                }
                else if (mouse.button === Qt.RightButton)
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
        switch (model.intname)
        {
            case "SHORT-BREAK":
                clock.minutes = GlobalSettings.settings.settingsPomodoroIntervalTimeMin;
                clock.seconds = 0;
                break;

            case "LONG-BREAK":
                clock.minutes = 10;
                clock.seconds = 0;
                break;

            case "POMODORO":
            default:
                clock.setTime(0,2)
                break;
        }
    }

    Clock
    {
        id: clock
        running: true
    }
}

