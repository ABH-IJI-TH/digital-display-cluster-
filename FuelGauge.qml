import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

Item {
    id: root
    width: 200
    height: 200
    property real fuelLevel: 0.5  // 0.0 to 1.0

    FontLoader {
        id: bmwFont
        source: "assets/fonts/RobotoCondensed-Regular.ttf"
    }

    function getFuelColor(level) {
        var r, g, b;
        if (level > 0.5) {
            let t = (1.0 - level) * 2
            r = Math.round(t * 255)
            g = 255
            b = 0
        } else {
            let t = (0.5 - level) * 2
            r = 255
            g = Math.round(255 * (1 - t))
            b = 0
        }
        return Qt.rgba(r / 255, g / 255, b / 255, 1)
    }

    // Background arc (full circle)
    Shape {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        ShapePath {
            strokeWidth: 12
            strokeColor: "#333"
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: width / 2
                centerY: height / 2
                radiusX: width / 2 - 12
                radiusY: height / 2 - 12
                startAngle: -210
                sweepAngle: 240
            }
        }
    }

    // Fuel arc (partial)
    Shape {
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        ShapePath {
            strokeWidth: 12
            strokeColor: getFuelColor(fuelLevel)
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                centerX: width / 2
                centerY: height / 2
                radiusX: width / 2 - 12
                radiusY: height / 2 - 12
                startAngle: -210
                sweepAngle: 240 * fuelLevel  // Partial arc based on level
            }
        }
    }

    // Text Label
    Column {
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: Math.round(fuelLevel * 100) + "%"
            color: "white"
            font.pixelSize: 26
            font.bold: true
            font.family: bmwFont.name
        }

        Text {
            text: "FUEL"
            color: "gray"
            font.pixelSize: 16
            font.family: bmwFont.name
        }
    }
}

