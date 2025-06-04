import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    property real rpm: 0              // External RPM input (from Main.qml)
    property real displayRpm: 0       // Smoothed value for animation
    width: 400
    height: 400

    FontLoader {
        id: bmwFont
        source: "assets/fonts/RobotoCondensed-Regular.ttf"
    }

    // Animate displayRpm to follow rpm smoothly
    NumberAnimation on displayRpm {
        duration: 400
        easing.type: Easing.InOutQuad
    }

    // Trigger RPM animation when rpm changes
    Component.onCompleted: displayRpm = rpm
    onRpmChanged: displayRpm = rpm

    Rectangle {
        anchors.fill: parent
        color: "black"
        radius: 20

        Canvas {
            id: canvas
            anchors.fill: parent

            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                ctx.translate(width / 2, height / 2)

                // Outer arc
                ctx.beginPath()
                ctx.arc(0, 0, 160, Math.PI * 0.75, Math.PI * 2.25)
                ctx.strokeStyle = "#222"
                ctx.lineWidth = 10
                ctx.stroke()

                // Tick marks from 0 to 8000 RPM
                for (let i = 0; i <= 8000; i += 1000) {
                    let angle = (i / 8000) * Math.PI * 1.5 - Math.PI * 0.75
                    let r1 = 140
                    let r2 = 160
                    ctx.beginPath()
                    ctx.moveTo(r1 * Math.cos(angle), r1 * Math.sin(angle))
                    ctx.lineTo(r2 * Math.cos(angle), r2 * Math.sin(angle))
                    ctx.strokeStyle = i >= 6000 ? "#ff3333" : "#ffffff"
                    ctx.lineWidth = 2
                    ctx.stroke()
                }

                // Needle (based on displayRpm)
                let angle = (displayRpm / 8000) * Math.PI * 1.5 - Math.PI * 0.75
                ctx.save()
                ctx.rotate(angle)
                ctx.beginPath()
                ctx.moveTo(0, 0)
                ctx.lineTo(0, -130)
                ctx.strokeStyle = "orange"
                ctx.lineWidth = 4
                ctx.stroke()
                ctx.restore()
            }

            // Redraw continuously
            Timer {
                interval: 16
                running: true
                repeat: true
                onTriggered: canvas.requestPaint()
            }
        }

        // RPM Label
        Text {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 30
            text: Math.round(displayRpm) + " RPM"
            font.family: bmwFont.name
            font.pixelSize: 28
            color: "white"
        }
    }
}
