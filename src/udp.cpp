#include "udp.h"

#ifdef QT_NO_DEBUG
#undef QT_NO_DEBUG
#endif

UdpTest::UdpTest(QObject *parent) : QObject(parent)
{

}

void UdpTest::send(QString address, int port, int dest, int event)
{
    QUdpSocket *udpsocket = new QUdpSocket(this);

    QByteArray data;
    data.append("TK");
    data.append((char)0x00);
    data.append((char)0x01);
    data.append((char)(dest & 0xff));
    data.append((char)((event >> 8) & 0xff));
    data.append((char)(event & 0xff));
    data.append((char)0xff);

    int res = udpsocket->writeDatagram(data, data.length(), QHostAddress(address), port);

    qDebug() << res << data.toHex() << address << port;

    if (res < data.length())
        emit fail();
    else
        emit success();
}

void UdpTest::initClient(int port)
{
    qDebug() << "client at" << port;
    udpSocket = new QUdpSocket(this);
    udpSocket->bind(QHostAddress::AnyIPv4, port);

    connect(udpSocket, SIGNAL(readyRead()), this, SLOT(readDatagram()));
}

void UdpTest::readDatagram()
{
    while (udpSocket->hasPendingDatagrams())
    {
        QByteArray datagram;
        datagram.resize(udpSocket->pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        udpSocket->readDatagram(datagram.data(), datagram.size(),
                                &sender, &senderPort);

        qDebug() << sender << datagram.toHex();

        emit receive(datagram.toHex());
    }
}
