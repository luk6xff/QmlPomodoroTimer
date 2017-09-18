import QtQuick 2.0

Rectangle {
    id: interval
    height: 20
    width: 20
    radius: 10
    property alias active: rect.enabled
    property string name: ""
    readonly property color activeColor: "green"
    readonly property color inactiveColor: "blue"

    Column
    {
        spacing: 5
        Rectangle
        {
            id: rect
            height: interval.height
            width: interval.height
            radius: interval.radius
            color: inactiveColor
            enabled: true
            onEnabledChanged:
            {
               color = enabled ? activeColor : inactiveColor
            }
        }
        Text
        {
            id: name
            text: '<b>'+ interval.name +'</b>'
        }
    }
    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            rect.enabled = rect.enabled ^ true
        }
    }

}
