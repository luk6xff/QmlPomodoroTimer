import QtQuick 2.0

Rectangle {
    id: interval
    height: 20
    width: 20
    radius: 10
    property alias active: rect.enabled
    property alias textWidth: name.width
    property string name: ""
    property color activeColor: "green"
    property color inactiveColor: "blue"

    Column
    {
        spacing: 5
        Rectangle
        {
            id: rect
            height: interval.height
            width: interval.height
            radius: interval.radius
            color: enabled ? activeColor : inactiveColor
            enabled: false
            onEnabledChanged:
            {
               color = enabled ? activeColor : inactiveColor
            }
        }
        Text
        {
            anchors.horizontalCenter: rect.horizontalCenter
            id: name
            font.pointSize: 7
            text: '<b>'+ interval.name +'</b>'
        }
    }
}
