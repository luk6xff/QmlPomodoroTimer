import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

Item {
    id: settings
    width: parent.width
    height: parent.height
    SystemPalette { id: palette }
    clip: true
    property bool autoNextInterval

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
            Item { Layout.preferredHeight: 4 } // padding
            CheckBox {
                id: automaticStartOfnextInterval
                text: "Autostart of next interval"
                checked: true
                Binding on checked { value: settings.autoNextInterval = true }
            }
            RowLayout {
                Label {
                    text: "Counter direction: "
                }
                ComboBox {
                    currentIndex: 0
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
                    SettingsIntervalTime {
                        id: pomodoroAlarmValue
                        name: "Pomodoro alarm time"
                    }
                 }
                RowLayout
                {
                    SettingsIntervalTime {
                        id: shortBreakAlarmValue
                        name: "Short break alarm time"
                    }
                }
                RowLayout
                {
                    SettingsIntervalTime {
                        id: longBreakAlarmValue
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
                {}
            }
            Button {
                text: "Close"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: settings.parent.close()
            }
        }
    }
}
