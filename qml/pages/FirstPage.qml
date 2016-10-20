import QtQuick 2.0
import Sailfish.Silica 1.0
import kimmoli.UdpTest 1.0

Page
{
    id: page

    SilicaFlickable
    {
        anchors.fill: parent

        PullDownMenu
        {
            MenuItem
            {
                text: "blaa"
                onClicked: console.log("blaa")
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
                title: "UDP"
            }
            Label
            {
                id: huu
                x: Theme.paddingLarge
                text: "UDP"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }

            Button
            {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "send"
                onClicked: udp.send("192.168.1.1", 4554, "testipaketti")
            }


        }
    }

    UdpTest
    {
        id: udp
        onFail: huu.text = "Failed"
        onSuccess: huu.text = "OK"
    }
}


