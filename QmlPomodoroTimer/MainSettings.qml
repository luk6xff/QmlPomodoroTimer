import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import "."

Item {
    id: settings
    width: parent.width
    height: parent.height
    SystemPalette { id: palette }
    clip: true

    function saveSettings()
    {
        GlobalSettings.main.autoStartOfNextInterval = automaticStartOfnextInterval.checked
        GlobalSettings.main.pomodoroIntervalTimeMin = pomodoroAlarmValue.min
        GlobalSettings.main.pomodoroIntervalTimeSec = pomodoroAlarmValue.sec
        GlobalSettings.main.shortBreakIntervalTimeMin = shortBreakAlarmValue.min
        GlobalSettings.main.shortBreakIntervalTimeSec = shortBreakAlarmValue.sec
        GlobalSettings.main.longBreakIntervalTimeMin = longBreakAlarmValue.min
        GlobalSettings.main.longBreakIntervalTimeSec = longBreakAlarmValue.sec
        GlobalSettings.main.countModeIdx = countMode.currentIndex
        GlobalSettings.main.countMode = countMode.textAt(countMode.currentIndex)
    }

    ScrollView {
        id: scrollView
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: bottomBar.top
            leftMargin: 12
        }
        ColumnLayout {
            spacing: 15
            Item {
                Layout.preferredHeight: 4
            }
            CheckBox {
                id: automaticStartOfnextInterval
                text: "Autostart of next interval"
                checked: GlobalSettings.main.autoStartOfNextInterval
            }
            RowLayout {
                Label {
                    text: "Counter direction: "
                }
                ComboBox {
                    id: countMode
                    currentIndex: GlobalSettings.main.countModeIdx
                    model: ListModel {
                        id: cbItems
                        ListElement { text: "UP"; color: "Yellow" }
                        ListElement { text: "DOWN"; color: "Green" }
                    }
                    width: 200
                }
            }
            ColumnLayout
            {
                spacing: 40
                RowLayout
                {
                    MainSettingsIntervalTime {
                        id: pomodoroAlarmValue
                        min: GlobalSettings.main.pomodoroIntervalTimeMin
                        sec: GlobalSettings.main.pomodoroIntervalTimeSec
                        name: "Pomodoro alarm time"
                    }
                 }
                RowLayout
                {
                    MainSettingsIntervalTime {
                        id: shortBreakAlarmValue
                        min: GlobalSettings.main.shortBreakIntervalTimeMin
                        sec: GlobalSettings.main.shortBreakIntervalTimeSec
                        name: "Short break alarm time"
                    }
                }
                RowLayout
                {
                    MainSettingsIntervalTime {
                        id: longBreakAlarmValue
                        min: GlobalSettings.main.longBreakIntervalTimeMin
                        sec: GlobalSettings.main.longBreakIntervalTimeSec
                        name: "Long break alarm time"
                    }
                }
            }
        }
    }

    Rectangle {
        id: bottomBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: buttonRow.height * 1.2
        color: Qt.darker(palette.window, 1.1)
        border.color: Qt.darker(palette.window, 1.3)
        Row {
            id: buttonRow
            spacing: 6
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 12
            width: parent.width
            Button {
                text: "Save"
                anchors.verticalCenter: parent.verticalCenter
                onClicked:
                {
                    saveSettings()
                }
            }
            Button {
                text: "Close"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: close()
            }
        }
    }
}
