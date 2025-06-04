import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    property bool absOn: true
    width: 80
    height: 80

    FontLoader {
        id: bmwFont
        source: "assets/fonts/RobotoCondensed-Regular.ttf"
    }

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "#000000"
        border.color: absOn ? "#ffa500" : "#555"
        border.width: 2
        opacity: absOn ? 1.0 : 0.2

        Text {
            anchors.centerIn: parent
            text: "ABS"
            font.family: bmwFont.name
            font.pixelSize: 20
            color: absOn ? "#ffa500" : "#555"
        }
    }
}
