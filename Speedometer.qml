import QtQuick 2.15
import QtQuick.Controls 2.15


Item {
    id: root
    property real speed: 0
    width: 400
    height: 400

    FontLoader {
        id: bmwFont
        source: "assets/fonts/RobotoCondensed-Regular.ttf"
    }

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

                const cx = width / 2
                const cy = height / 2
                ctx.translate(cx, cy)

                // Arc
                ctx.beginPath()
                ctx.arc(0, 0, 160, Math.PI * 0.75, Math.PI * 2.25)
                ctx.strokeStyle = "#444"
                ctx.lineWidth = 10
                ctx.stroke()

                // Ticks
                for (let i = 0; i <= 240; i += 20) {
                    let angle = (i / 240) * Math.PI * 1.5 - Math.PI * 0.75
                    let r1 = 140
                    let r2 = 160
                    ctx.beginPath()
                    ctx.moveTo(r1 * Math.cos(angle), r1 * Math.sin(angle))
                    ctx.lineTo(r2 * Math.cos(angle), r2 * Math.sin(angle))
                    ctx.strokeStyle = "#fff"
                    ctx.lineWidth = 2
                    ctx.stroke()
                }

                // Needle
                let angle = (speed / 240) * Math.PI * 1.5 - Math.PI * 0.75
                ctx.save()
                ctx.rotate(angle)
                ctx.beginPath()
                ctx.moveTo(0, 0)
                ctx.lineTo(0, -130)
                ctx.strokeStyle = "red"
                ctx.lineWidth = 4
                ctx.stroke()
                ctx.restore()
            }

            Timer {
                interval: 16
                running: true
                repeat: true
                onTriggered: canvas.requestPaint()
            }
        }

        Text {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 30
            text: Math.round(speed) + " km/h"
            font.family: bmwFont.name
            font.pixelSize: 28
            color: "white"
        }
    }
}
