import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

Item {
    id: settingsIntervalTime
    property string name;
    property alias min: min.value
    property alias sec: sec.value
    RowLayout {
        Label {
            text: settingsIntervalTime.name
        }
        SpinBox {
            id: min
            decimals: 0
        }
        Label {
            text: "[min]"
        }

        SpinBox {
            id: sec
            decimals: 0
            onValueChanged:
            {
                if (value > 59)
                {
                    value = 0;
                }
            }
        }
        Label {
            text: "[sec]"
        }
    }
}
