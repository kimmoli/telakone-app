#include "QUdpSocket"
#include "QHostAddress"
#include "udp.h"

#ifdef QT_NO_DEBUG
#undef QT_NO_DEBUG
#endif

UdpTest::UdpTest(QObject *parent) : QObject(parent)
{

}

void UdpTest::send(QString address, int port, QString data)
{
    QUdpSocket *udpsocket = new QUdpSocket(this);

    int res = udpsocket->writeDatagram(data.toLocal8Bit(), data.length(), QHostAddress(address), port);

    qDebug() << res << data << address << port;

    if (res < data.length())
        emit fail();
    else
        emit success();
}
