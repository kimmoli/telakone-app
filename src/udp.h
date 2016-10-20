#ifndef UDPTEST_H
#define UDPTEST_H

#include <QObject>

class UdpTest : public QObject
{
    Q_OBJECT
public:
    explicit UdpTest(QObject *parent = 0);

    Q_INVOKABLE void send(QString address, int port, QString data);

signals:
    void fail();
    void success();

public slots:
};

#endif // UDPTEST_H
