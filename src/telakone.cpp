#include <sailfishapp.h>
#include <QtQml>
#include <QScopedPointer>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlContext>
#include <QCoreApplication>
#include "udp.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationDomain("kimmoli");
    QCoreApplication::setOrganizationName("kimmoli");
    QCoreApplication::setApplicationName("telakone");
    QCoreApplication::setApplicationVersion("0.0.1");

    qmlRegisterType<UdpInterface>("Kimmoli.Telakone.Udp", 1, 0, "UdpInterface");

    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());
    view->setSource(SailfishApp::pathTo("qml/telakone.qml"));
    view->show();

    return app->exec();
}

