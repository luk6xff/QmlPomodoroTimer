import QtQuick 2.0

Item {
    id: interval
    height: rect.height + name.height
    width: rect.width
    property alias radius: rect.radius
    property alias active: rect.enabled
    property string name: ""
    property color activeColor: "green"
    property color inactiveColor: "blue"

    Column
    {
        id: col
        spacing: 5
        Rectangle
        {
            id: rect
            height: 30
            width: 30
            radius: 15
            enabled: false
            color: enabled ? activeColor : inactiveColor
            onEnabledChanged:
            {
               color = enabled ? activeColor : inactiveColor
            }
        }
        Text
        {
            id: name
            anchors.horizontalCenter: rect.horizontalCenter
            font.pointSize: 7
            text: '<b>'+ interval.name +'</b>'
        }
    }
}
