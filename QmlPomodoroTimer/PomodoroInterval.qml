import QtQuick 2.0

Item {
    id: interval
    property alias active: rect.enabled
    property string name: ""
    readonly property color activeColor: "green"
    readonly property color inactiveColor: "red"

    Column
    {
        spacing: 5
        Rectangle
        {
            id: rect
            height: 20
            width: 20
            radius: 10
            color: inactiveColor
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
