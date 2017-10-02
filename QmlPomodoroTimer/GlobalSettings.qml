pragma Singleton
import QtQuick 2.5
import Qt.labs.settings 1.0


QtObject
{
    property Settings main:
    Settings
    {
        property bool autoStartOfNextInterval: false
        property int pomodoroIntervalTimeMin: 25
        property int pomodoroIntervalTimeSec: 0
        property int shortBreakIntervalTimeMin: 5
        property int shortBreakIntervalTimeSec: 0
        property int longBreakIntervalTimeMin: 10
        property int longBreakIntervalTimeSec: 0
        property int countModeIdx: 0
        property string countMode: "UP"
    }

    property Settings colors:
    Settings
    {
        //TODO
    }

}
