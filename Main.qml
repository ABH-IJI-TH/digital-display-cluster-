// Main.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root
    visible: true
    width: 1280
    height: 720
    title: qsTr("BMW Digital Cluster")

    property real speed: 0
    property real rpm: 0
    property real fuelLevel: 1.0
    property bool leftSignal: false
    property bool rightSignal: false
    property bool hazardSignal: false
    property bool seatbeltFastened: false
    property int currentGear: 1

    FontLoader {
        id: bmwFont
        source: "assets/fonts/RobotoCondensed-Regular.ttf"
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            speed = (speed + 1) % 240
            fuelLevel -= 0.0005
            if (fuelLevel < 0) fuelLevel = 1.0

            // Automatic gear selection based on speed
            if (speed < 20)
                currentGear = 1
            else if (speed < 40)
                currentGear = 2
            else if (speed < 60)
                currentGear = 3
            else if (speed < 90)
                currentGear = 4
            else if (speed < 130)
                currentGear = 5
            else
                currentGear = 6

            // Smooth RPM transition
            let gearRatio = Math.max(currentGear, 1)
            let targetRpm = (speed / gearRatio) * 100
            rpm += (targetRpm - rpm) * 0.1
            if (rpm > 8000) rpm = 8000
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#111"

        RowLayout {
            anchors.centerIn: parent
            spacing: 50

            Speedometer {
                id: speedo
                speed: root.speed
            }

            FuelGauge {
                id: fuelGauge
                fuelLevel: root.fuelLevel
            }

            Tachometer {
                id: tacho
                rpm: root.rpm
            }
        }

        TurnIndicators {
            id: indicators
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 30
            leftOn: root.leftSignal
            rightOn: root.rightSignal
            hazardOn: root.hazardSignal
        }

        SeatbeltIndicator {
            id: seatbeltWarning
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.rightMargin: 20
            seatbeltFastened: root.seatbeltFastened
        }

        TripOdometer {
            id: trip
            currentSpeed: root.speed
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 20
            anchors.leftMargin: 20
        }

        GearDisplay {
            id: gearDisplay
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 20
            anchors.leftMargin: 20
            currentGear: root.currentGear
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 30
            spacing: 20

            Button {
                text: "Left"
                onClicked: {
                    leftSignal = !leftSignal
                    if (leftSignal) {
                        rightSignal = false
                        hazardSignal = false
                    }
                }
            }

            Button {
                text: "Right"
                onClicked: {
                    rightSignal = !rightSignal
                    if (rightSignal) {
                        leftSignal = false
                        hazardSignal = false
                    }
                }
            }

            Button {
                text: "Hazard"
                onClicked: {
                    hazardSignal = !hazardSignal
                    if (hazardSignal) {
                        leftSignal = false
                        rightSignal = false
                    }
                }
            }

            Button {
                text: seatbeltFastened ? "Unfasten Seatbelt" : "Fasten Seatbelt"
                onClicked: seatbeltFastened = !seatbeltFastened
            }
        }
    }
}
