import QtQuick 2.0

Item {
    id: clock
    property int  minutes: 0
    property int  seconds: 0

    QtObject
    {
        id: alarmTime
        property int minutes: 2
        property int seconds: 1
    }
    property alias alarmTimeMin: alarmTime.minutes
    property alias alarmTimeSec: alarmTime.seconds

    property var setTime: function(min, sec)
    {
        switch (upOrDownCount)
        {
            case "DOWN":
            default:
                minutes = min;
                seconds = sec;
                alarmTime.minutes = 0;
                alarmTime.seconds = 0;
                break;
            case "UP":
                minutes = 0;
                seconds = 0;
                alarmTime.minutes = min;
                alarmTime.seconds = sec;
                break;
        }
    }

    property string upOrDownCount: ""
    property alias running: timer.running
    signal timePassed

    Timer
    {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            switch (upOrDownCount)
            {
                case "DOWN":
                default:
                    if (--seconds < 0)
                    {
                        seconds = 59;
                        minutes--;
                    }
                    break;
                case "UP":
                    if (++seconds > 59)
                    {
                        seconds = 0;
                        minutes++;
                    }
                    break;
            }
            if (seconds === alarmTime.seconds && minutes === alarmTime.minutes)
            {
                running = false;
                timePassed()
            }
        }
    }
}
