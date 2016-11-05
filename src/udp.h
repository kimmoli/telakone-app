#ifndef UDPINTERFACE_H
#define UDPINTERFACE_H

#include <QObject>
#include <QUdpSocket>
#include <QHostAddress>
#include <QByteArray>

class UdpInterface : public QObject
{
    Q_OBJECT
public:
    explicit UdpInterface(QObject *parent = 0);

    Q_INVOKABLE void send(QString address, int port, int dest, int event);
    Q_INVOKABLE void initClient(int port);

    Q_PROPERTY(QVariantMap status READ readStatus NOTIFY statusChanged())
    QVariantMap readStatus() { return _status; }

signals:
    void fail();
    void success();
    void statusChanged();

private slots:
    void readDatagram();

private:
    void append16(QByteArray *ba, u_int16_t data);
    void append32(QByteArray *ba, u_int32_t data);
    QUdpSocket *udpSocket;
    QVariantMap _status;
};

#endif // UDPINTERFACE_H
