TARGET = udptest

CONFIG += sailfishapp

SOURCES += src/udptest.cpp \
    src/udp.cpp

OTHER_FILES += qml/udptest.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    rpm/udptest.changes.in \
    rpm/udptest.spec \
    translations/*.ts \
    udptest.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

HEADERS += \
    src/udp.h

