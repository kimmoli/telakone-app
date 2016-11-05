TARGET = telakone

CONFIG += sailfishapp

SOURCES += src/telakone.cpp \
    src/udp.cpp
    
HEADERS += \
    src/udp.h

OTHER_FILES += qml/telakone.qml \
    qml/cover/CoverPage.qml \
    telakone.desktop \
    qml/pages/MainPage.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

DISTFILES += \
    rpm/telakone.spec \
    qml/pages/StatusPage.qml
