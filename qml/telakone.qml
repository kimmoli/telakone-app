import QtQuick 2.0
import Sailfish.Silica 1.0
import Kimmoli.Telakone.Udp 1.0
import org.nemomobile.configuration 1.0

ApplicationWindow
{
    initialPage: Qt.resolvedUrl("pages/MainPage.qml")
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    UdpInterface
    {
        id: tkudp
        Component.onCompleted: tkudp.initClient(conf.hostport)
    }

    ConfigurationGroup
    {
        id: conf
        path: "/apps/telakone/settings"
        property string hosturl: "localhost"
        property string hostport: "4554"
    }

    function senddata(dest, event, force)
    {
        if (!st.running || force)
        {
            tkudp.send(conf.hosturl, conf.hostport, dest, event)
            st.start()
        }
    }

    Timer
    {
        id: st
        interval: 100
    }
}


