import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    id: page

    SilicaFlickable
    {
        anchors.fill: parent

        contentHeight: column.height

        Column
        {
            id: column

            width: page.width
            spacing: Theme.paddingSmall
            PageHeader
            {
                title: "Status"
            }
            Repeater
            {
                model: statusList
                delegate: Column
                {
                    width: page.width
                    spacing: Theme.paddingSmall

                    SectionHeader
                    {
                        text: title
                    }

                    Label
                    {
                        x: Theme.paddingLarge
                        text: tkudp.status[param]
                        color: Theme.primaryColor
                        font.pixelSize: Theme.fontSizeExtraLarge
                    }
                }
            }
        }
    }

    ListModel
    {
        id: statusList
        ListElement { title: "ADC count";             param: "__SL_G_U_A" }
        ListElement { title: "Temp count";            param: "__SL_G_U_T" }
        ListElement { title: "CPU temperature";       param: "__SL_G_UTS" }
        ListElement { title: "Supply voltage";        param: "__SL_G_UVS" }
        ListElement { title: "Aux motor current";     param: "__SL_G_UCM" }
        ListElement { title: "Joystick LR";           param: "__SL_G_UJL" }
        ListElement { title: "Joystick BR";           param: "__SL_G_UJB" }
        ListElement { title: "I2C count";             param: "__SL_G_U_I" }
        ListElement { title: "Ext temperature";       param: "__SL_G_UTE" }
        ListElement { title: "Acceleration X";        param: "__SL_G_UAX" }
        ListElement { title: "Acceleration Y";        param: "__SL_G_UAY" }
        ListElement { title: "Acceleration Z";        param: "__SL_G_UAZ" }
        ListElement { title: "Acceleration Pitch";    param: "__SL_G_UAP" }
        ListElement { title: "Acceleration Roll";     param: "__SL_G_UAR" }
        ListElement { title: "Battery voltage left";  param: "__SL_G_UBL" }
        ListElement { title: "Motor control left";    param: "__SL_G_UML" }
        ListElement { title: "Battery voltage right"; param: "__SL_G_UBR" }
        ListElement { title: "Motor control right";   param: "__SL_G_UMR" }
    }

}
