#include "udp.h"

#ifdef QT_NO_DEBUG
#undef QT_NO_DEBUG
#endif

#define TK_MESSAGE_HEADER 0x544b

UdpInterface::UdpInterface(QObject *parent) : QObject(parent)
{

}

void UdpInterface::append16(QByteArray *ba, u_int16_t data)
{
    ba->append((char)(data & 0xFF));
    ba->append((char)((data >> 8) & 0xFF));
}

void UdpInterface::append32(QByteArray *ba, u_int32_t data)
{
    ba->append((char)(data & 0xFF));
    ba->append((char)((data >> 8) & 0xFF));
    ba->append((char)((data >> 16) & 0xFF));
    ba->append((char)((data >> 24) & 0xFF));
}

void UdpInterface::send(QString address, int port, int dest, int event)
{
    QUdpSocket *udpsocket = new QUdpSocket(this);

    QByteArray data;
    append16(&data, TK_MESSAGE_HEADER);
    append16(&data, 0);
    append16(&data, 1);
    append16(&data, dest);
    append32(&data, event);

    int res = udpsocket->writeDatagram(data, data.length(), QHostAddress(address), port);

    qDebug() << res << data.toHex() << address << port;

    if (res < data.length())
        emit fail();
    else
        emit success();
}

void UdpInterface::initClient(int port)
{
    qDebug() << "client at" << port;
    udpSocket = new QUdpSocket(this);
    udpSocket->bind(QHostAddress::AnyIPv4, port);

    connect(udpSocket, SIGNAL(readyRead()), this, SLOT(readDatagram()));
}

void UdpInterface::readDatagram()
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

        QDataStream ds(datagram);
        ds.setByteOrder(QDataStream::LittleEndian);
        ds.setFloatingPointPrecision(QDataStream::SinglePrecision);

        u_int32_t header;
        int t_int;
        float t_float;

        ds >> header;

        if (header == 0x53544154 || header == 0x54415453)
        {
            _status.clear();

            ds >> t_int;
            _status.insert("__SL_G_U_A", QString("%1").arg(t_int));
            ds >> t_int;
            _status.insert("__SL_G_U_T", QString("%1").arg(t_int));
            ds >> t_float;
            _status.insert("__SL_G_UTS", QString("%1 C").arg(t_float));
            ds >> t_float;
            _status.insert("__SL_G_UVS", QString("%1 V").arg(t_float));
            ds >> t_float;
            _status.insert("__SL_G_UCM", QString("%1 A").arg(t_float));
            ds >> t_int;
            _status.insert("__SL_G_UJL", QString("%1").arg(t_int));
            ds >> t_int;
            _status.insert("__SL_G_UJB", QString("%1").arg(t_int));
            ds >> t_int;
            _status.insert("__SL_G_U_I", QString("%1").arg(t_int));
            ds >> t_float;
            _status.insert("__SL_G_UTE", QString("%1 C").arg(t_float));
            ds >> t_float;
            _status.insert("__SL_G_UAX", QString("%1 g").arg(t_float));
            ds >> t_float;
            _status.insert("__SL_G_UAY", QString("%1 g").arg(t_float));
            ds >> t_float;
            _status.insert("__SL_G_UAZ", QString("%1 g").arg(t_float));
            ds >> t_float;
            _status.insert("__SL_G_UAP", QString("%1").arg(t_float));
            ds >> t_float;
            _status.insert("__SL_G_UAR", QString("%1").arg(t_float));

            qDebug() << _status;

            emit statusChanged();
        }
    }
}
