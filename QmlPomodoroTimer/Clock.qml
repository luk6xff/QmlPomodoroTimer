import QtQuick 2.0


Item {
    id: clock
    property int  minutes: 0
    property int  seconds: 0

    property int alarmSec: 0

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
            if (seconds == alarmSec)
            {
                seconds = 99;
                running = false;
            }
        }

    }


}
