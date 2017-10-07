import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Styles 1.4
import "."

Item {
    id: otherSettings
    width: parent.width
    height: parent.height
    SystemPalette { id: palette }
    clip: true

    Column {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        Label {
            font.bold: true
            text: "Other Settings"
        }

        Item {
            Layout.preferredHeight: 6
        }


        MessageDialog {
            id: messageDialog
            modality: Qt.WindowModal
            standardButtons: StandardButton.Yes | StandardButton.No
            icon: StandardIcon.Warning
            property string lastChosen: ""
            title: qsTr("Restore default settings")
            text: qsTr("Do you really want to restore all the settings to default values ?")
            onYes: GlobalSettings.restoreDefaults()
            onNo: {
            }
        }

        ColumnLayout
        {
            spacing: 40
            RowLayout
            {
                spacing: 20
                Label {
                    text: "Restore defaults: "
                }
                Button {
                    text: "Restore"
                    onClicked: {
                        messageDialog.open()
                    }
                }
            }
        }
    }

    Rectangle {
        id: appInformation
        color: "lightblue"
        width: parent.width
        height: 200
        anchors {
            left: parent.left
            right: parent.right
            bottom: bottomBar.top
            leftMargin: 5
            rightMargin: 5
        }
        border.color: "black"

        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d");
                ctx.beginPath();
                ctx.moveTo(0, 0);
                ctx.lineTo(parent.width, parent.height);
                ctx.strokeStyle = "black";
                ctx.stroke()

                ctx.beginPath();
                ctx.moveTo(0, parent.height);
                ctx.lineTo(parent.width, 0);
                ctx.strokeStyle = "black";
                ctx.stroke()
            }
        }

        Label {
            font.bold: true
            text: "App info"
            font.pixelSize: 30
        }

        ColumnLayout
        {
            id: column
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width * 0.3
            spacing: 30
            property int valXPos: appInformation.width/4

            Item
            {
                Layout.preferredHeight: 10
            }

            Row
            {
                Label {
                    font.bold: true
                    text: "App version: "
                }
                Text
                {
                    x: column.valXPos
                    text: root.appVersion
                }
            }
            Row
            {
                Label {
                    font.bold: true
                    text: "App year: "
                }
                Text
                {
                    x: column.valXPos
                    text: root.appYear
                }
            }
            Row
            {
                Label {
                    font.bold: true
                    text: "App author: "
                }
                Text
                {
                    x: column.valXPos
                    text: root.appAuthor
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
                text: "Close"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: close()
            }
        }
    }
}
