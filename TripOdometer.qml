import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 200
    height: 80

    // Trip distance in kilometers
    property real tripDistance: 0

    // Speed in km/h (must be set from Main.qml)
    property real currentSpeed: 0

    // Update timer (every second)
    Timer {
        id: updateTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            // Convert speed (km/h) to km per second: speed / 3600
            root.tripDistance += currentSpeed / 3600
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 10
        color: "#222"
        border.color: "#555"

        Column {
            anchors.centerIn: parent
            spacing: 5

            Text {
                text: "Trip: " + tripDistance.toFixed(2) + " km"
                font.pixelSize: 20
                color: "white"
            }

            Button {
                text: "Reset"
                onClicked: root.tripDistance = 0
                width: 80
                height: 30
            }
        }
    }
}
