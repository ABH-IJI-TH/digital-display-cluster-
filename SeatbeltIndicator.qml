import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root
    property bool seatbeltFastened: false

    width: 60
    height: 60

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: seatbeltFastened ? "transparent" : "#800000"
        border.color: seatbeltFastened ? "transparent" : "red"
        border.width: 2
        visible: !seatbeltFastened

        Column {
            anchors.centerIn: parent
            spacing: 4

            Image {
                source: "assets/icons/seatbelt_red.png" // Use your actual icon path
                width: 40
                height: 40
                visible: !seatbeltFastened
            }

            Text {
                text: "Seatbelt"
                color: "white"
                font.pixelSize: 12
                visible: !seatbeltFastened
            }
        }
    }
}
