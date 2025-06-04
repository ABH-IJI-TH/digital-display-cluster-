// GearDisplay.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 80
    height: 80

    property int currentGear: 1

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: "#000000cc"
        border.color: "white"
        border.width: 2

        Text {
            anchors.centerIn: parent
            text: currentGear.toString()
            font.pixelSize: 36
            font.bold: true
            color: "white"
        }
    }
}
