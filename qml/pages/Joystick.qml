import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    property real joyLR: 0
    property real joyBF: 0
    property real motorLeft: 0
    property real motorRight: 0
    property real fullscaleDisp : container.y - Theme.paddingLarge
    property real fullscale: 1000

    function rescale(value, oldscale, newscale)
    {
        return (newscale * value) / oldscale - newscale/2
    }

    Timer
    {
        running: true
        repeat: true
        interval: 100
        onTriggered:
        {
            joyLR = rescale(rect.x, (container.width - rect.width), fullscale)
            joyBF = rescale(rect.y, (container.height - rect.height), fullscale)

            motorLeft = Math.max(Math.min(joyBF + joyLR, fullscale/2), -fullscale/2);
            motorRight = Math.max(Math.min(joyBF - joyLR, fullscale/2), -fullscale/2);

            senddata(6, ((motorLeft & 0xfff) << 16) | (motorRight & 0xfff), 1)
        }
    }

    Rectangle
    {
        width: 100
        height: Math.abs(rescale(motorLeft+fullscale/2, fullscale, fullscaleDisp))
        x: 100
        y: fullscaleDisp/2 + Theme.paddingLarge/2 + Math.min(rescale(motorLeft+fullscale/2, fullscale, fullscaleDisp), 0)
    }

    Rectangle
    {
        width: 100
        height: Math.abs(rescale(motorRight+fullscale/2, fullscale, fullscaleDisp))
        x: parent.width - 200
        y: fullscaleDisp/2 + Theme.paddingLarge/2 + Math.min(rescale(motorRight+fullscale/2, fullscale, fullscaleDisp), 0)
    }

    Rectangle
    {
        id: container
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingLarge/2
        width: parent.width-Theme.paddingLarge
        height: width
        border.color: Theme.primaryColor
        border.width: 2
        radius: 10
        color: "transparent"

        Rectangle
        {
            id: rect
            x: container.width/2-rect.width/2
            y: container.height/2-rect.height/2
            width: 200
            height: 200
            color: Theme.primaryColor
            radius: 100

            MouseArea
            {
                preventStealing: true
                anchors.fill: parent
                drag.target: rect
                drag.axis: Drag.XAndYAxis
                drag.minimumX: 0
                drag.maximumX: container.width - rect.width
                drag.minimumY: 0
                drag.maximumY: container.height - rect.height
                onPressed: rect.color = Theme.highlightColor
                onReleased: {
                    rect.color = Theme.primaryColor
                    rx.start()
                    ry.start()
                }
            }

            NumberAnimation {
                id: rx
                target: rect
                property: "x"
                duration: 200
                to: container.width/2-rect.width/2
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                id: ry
                target: rect
                property: "y"
                duration: 200
                to: container.height/2-rect.height/2
                easing.type: Easing.InOutQuad
            }
        }
    }

}
