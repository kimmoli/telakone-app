#ifndef UDPTEST_H
#define UDPTEST_H

#include <QObject>
#include "QUdpSocket"
#include "QHostAddress"

class UdpTest : public QObject
{
    Q_OBJECT
public:
    explicit UdpTest(QObject *parent = 0);

    Q_INVOKABLE void send(QString address, int port, int dest, int event);
    Q_INVOKABLE void initClient(int port);

signals:
    void fail();
    void success();
    void receive(QString datagram);

private slots:
    void readDatagram();

private:
    QUdpSocket *udpSocket;
};

#endif // UDPTEST_H
