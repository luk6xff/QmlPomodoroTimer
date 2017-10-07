import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import "."

Item {
    width: 320
    height: 240
    SystemPalette { id: palette }
    clip: true

    function saveSettings()
    {
        GlobalSettings.colors.timerColor = timerColor.color
        GlobalSettings.colors.activeIntervalColor = activeIntervalColor.color
        GlobalSettings.colors.inactiveIntervalColor = inactiveIntervalColor.color
        GlobalSettings.colors.buttonsColor = buttonsColor.color
    }

    property var colorDialogForId: null
    function openColorDialogForId(id)
    {
        colorDialogForId = id
        colorDialog.open()
    }

    ColorDialog {
        id: colorDialog
        modality: Qt.WindowModal
        title: root.title + " - color settings"
        color: "black"
        showAlphaChannel: true
        onAccepted: {
            if (colorDialogForId != null)
            {
               colorDialogForId.color = color
            }
        }
        onRejected: {
            //console.log("Rejected")
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        Label {
            font.bold: true
            text: "Color Settings"
        }

        ColorsSettingsItem {
            id: timerColor
            color: GlobalSettings.colors.timerColor
            title: "Timer Color"
            onClick: {
                openColorDialogForId(this)
            }
        }

        ColorsSettingsItem {
            id: activeIntervalColor
            color: GlobalSettings.colors.activeIntervalColor
            title: "ActiveInterval Color"
            onClick: {
                openColorDialogForId(this)
            }
        }

        ColorsSettingsItem {
            id: inactiveIntervalColor
            color: GlobalSettings.colors.inactiveIntervalColor
            title: "InactiveInterval Color"
            onClick: {
                openColorDialogForId(this)
            }
        }

        ColorsSettingsItem {
            id: buttonsColor
            color: GlobalSettings.colors.buttonsColor
            title: "Button Color"
            onClick: {
                openColorDialogForId(this)
            }
        }
    }

    Rectangle {
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
            height: implicitHeight
            width: parent.width
            Button {
                text: "Save"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: saveSettings()
            }
            Button {
                text: "Close"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: close()
            }
        }
    }
}
