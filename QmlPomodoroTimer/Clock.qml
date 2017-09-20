import QtQuick 2.0


Item {
    id: clock
    property int  minutes: 0
    property int  seconds: 0
    property alias alarmTime: alarmTime
/*
    property Item alarmTime: Item
    {
        property int minutes: 10
        property int seconds: 5
    }
*/
    /*
    property var alarmTime:
    {
        'minutes': 109,
        'seconds': 5
    }
    */
    QtObject
    {
        id: alarmTime
        property int minutes: 25
        property int seconds: 1
    }
    property int upOrDownCount: 0 //0-downCount, 1-upCount

    property alias running: timer.running
    signal timePassed
    Timer
    {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            seconds++;
            console.log(seconds, alarmTime.seconds, alarmTime.minutes)
            if (seconds === alarmTime.seconds)
            {
                seconds = 99;
                running = false;
            }
        }
    }
}
