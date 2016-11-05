import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    id: page

    function senddata(dest, event)
    {
        if (!st.running)
        {
            tkudp.send(hosturl.text, port.text, dest, event)
            st.start()
        }
    }

    Timer
    {
        id: st
        interval: 100
    }

    SilicaFlickable
    {
        anchors.fill: parent

        PullDownMenu
        {
            MenuItem
            {
                text: "Status"
                onClicked: pageStack.push(Qt.resolvedUrl("StatusPage.qml"))
            }
        }

        contentHeight: column.height

        Column
        {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader
            {
                title: "Telakone"
            }

            TextField
            {
                id: hosturl
                label: "Host IP"
                width: parent.width
                focus: false
                text: conf.hosturl
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked:
                {
                    conf.hosturl = hosturl.text
                    hosturl.focus = false
                }
            }
            TextField
            {
                id: port
                label: "Port"
                width: parent.width
                focus: false
                text: conf.hostport
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked:
                {
                    conf.hostport = port.text
                    port.focus = false
                }
            }

            Button
            {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Blink slow"
                onClicked: senddata(2, 2)
            }
            Button
            {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Blink fast"
                onClicked: senddata(2, 4)
            }
            Button
            {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Blink off"
                onClicked: senddata(2, 1)
            }
            Slider
            {
                id: sl
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - Theme.paddingLarge
                minimumValue: -100
                maximumValue: 100
                value: 0
                valueText: value
                stepSize: 10
                onValueChanged: senddata(5, (value & 0xff) | 0x8000)
                onDownChanged: if (!sl.down) sl.value = 0
            }
            Label
            {
                id: rx
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - Theme.paddingLarge
            }
        }
    }
}


