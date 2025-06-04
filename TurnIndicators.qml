import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: indicatorRoot
    width: 100
    height: 50

    // External control properties
    property bool leftOn: false
    property bool rightOn: false
    property bool hazardOn: false

    // Internal blinking control
    property bool blinkVisible: false

    Timer {
        id: blinkTimer
        interval: 500
        repeat: true
        running: leftOn || rightOn || hazardOn
        onTriggered: blinkVisible = !blinkVisible
    }

    Row {
        anchors.centerIn: parent
        spacing: 40

        Rectangle {
            width: 30
            height: 30
            radius: 5
            color: blinkVisible && (leftOn || hazardOn) ? "green" : "#333"
            border.color: "black"
        }

        Rectangle {
            width: 30
            height: 30
            radius: 5
            color: blinkVisible && (rightOn || hazardOn) ? "green" : "#333"
            border.color: "black"
        }
    }
}

