pragma Singleton
import QtQuick 2.5
import Qt.labs.settings 1.0


QtObject
{

    property Settings main:
    Settings
    {
        category: "main"
        property bool autoStartOfNextInterval: defaults.autoStartOfNextInterval
        property int pomodoroIntervalTimeMin: defaults.pomodoroIntervalTimeMin
        property int pomodoroIntervalTimeSec: defaults.pomodoroIntervalTimeSec
        property int shortBreakIntervalTimeMin: defaults.shortBreakIntervalTimeMin
        property int shortBreakIntervalTimeSec: defaults.shortBreakIntervalTimeSec
        property int longBreakIntervalTimeMin: defaults.longBreakIntervalTimeMin
        property int longBreakIntervalTimeSec: defaults.longBreakIntervalTimeSec
        property int countModeIdx: defaults.countModeIdx
        property string countMode: defaults.countMode
        property int alarmVolume: defaults.alarmVolume
    }

    property Settings colors:
    Settings
    {
        category: "colors"
        property string timerColor: defaults.timerColor
        property string activeIntervalColor: defaults.activeIntervalColor
        property string inactiveIntervalColor: defaults.inactiveIntervalColor
        property string buttonsColor: defaults.buttonsColor
    }


    readonly property QtObject defaults:
    QtObject
    {
        // main
        readonly property bool autoStartOfNextInterval: false
        readonly property int pomodoroIntervalTimeMin: 25
        readonly property int pomodoroIntervalTimeSec: 0
        readonly property int shortBreakIntervalTimeMin: 5
        readonly property int shortBreakIntervalTimeSec: 0
        readonly property int longBreakIntervalTimeMin: 10
        readonly property int longBreakIntervalTimeSec: 0
        readonly property int countModeIdx: 0
        readonly property string countMode: "DOWN"
        readonly property int alarmVolume: 30
        // colors
        readonly property string timerColor: "#0c4e08"
        readonly property string activeIntervalColor: "green"
        readonly property string inactiveIntervalColor: "blue"
        readonly property string buttonsColor: "#7e87f8"
    }

    function restoreDefaults()
    {
        // main
        main.autoStartOfNextInterval = defaults.autoStartOfNextInterval
        main.pomodoroIntervalTimeMin = defaults.pomodoroIntervalTimeMin
        main.pomodoroIntervalTimeSec = defaults.pomodoroIntervalTimeSec
        main.shortBreakIntervalTimeMin = defaults.shortBreakIntervalTimeMin
        main.shortBreakIntervalTimeSec = defaults.shortBreakIntervalTimeSec
        main.longBreakIntervalTimeMin = defaults.longBreakIntervalTimeMin
        main.longBreakIntervalTimeSec = defaults.longBreakIntervalTimeSec
        main.countModeIdx = defaults.countModeIdx
        main.countMode = defaults.countMode
        main.alarmVolume = defaults.alarmVolume
        // colors
        colors.timerColor = defaults.timerColor
        colors.activeIntervalColor = defaults.activeIntervalColor
        colors.inactiveIntervalColor = defaults.inactiveIntervalColor
        colors.buttonsColor = defaults.buttonsColor
    }


}
