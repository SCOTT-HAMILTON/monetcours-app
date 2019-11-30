QT += quick qml webengine

CONFIG += c++17

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        builder.cpp \
        directorymaker.cpp \
        documentadder.cpp \
        documentdeleter.cpp \
        documentsaver.cpp \
        exporter.cpp \
        gitstatuschecker.cpp \
        importer.cpp \
        main.cpp \
        pdfmetalist.cpp \
        pdfmetalister.cpp \
        pdftoyamlpath.cpp \
        subjectadder.cpp \
        subjectdeleter.cpp \
        subjectpath.cpp \
        subjectslister.cpp

RESOURCES += qml.qrc \
    translations.qrc

TRANSLATIONS = translations/monetapp-en_US.ts
TRANSLATIONS += translations/monetapp-fr_FR.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

DEFINES += QUAZIP_STATIC
CONFIG += static staticlib link_prl ordered DEFINES += QT_NODLL

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

win32:CONFIG(release, debug|release):{
    LIBS += -L$$PWD/../../../git/yaml-cpp/lib/ -lyaml-cpp
    LIBS += -L$$PWD/../../../git/yaml-cpp/lib/ -lyaml-cppd

    LIBS += -L$$PWD/../../../git/quazip/lib/ -lquazip
    LIBS += -L$$PWD/../../../git/quazip/lib/ -lquazipd

    LIBS += -L$$PWD/../../../git/git2/lib/ -lgit2
    LIBS += -L$$PWD/../../../git/git2/lib/ -lgit2d

    INCLUDEPATH += $$PWD/../../../git/yaml-cpp/include
    DEPENDPATH += $$PWD/../../../git/yaml-cpp/include

    INCLUDEPATH += $$PWD/../../../git/quazip/include
    DEPENDPATH += $$PWD/../../../git/quazip/include

    INCLUDEPATH += $$PWD/../../../git/git2/include
    DEPENDPATH += $$PWD/../../../git/git2/include
}
else:unix: {
    LIBS += -L/usr/local/lib

    LIBS += -lyaml-cpp
    LIBS += -lquazip5
    LIBS += -lz -lpcre -lssl -lcrypto -ldl -lssh2 -static-libgcc -lgit2
}

win32:CONFIG(release, debug|release):


HEADERS += \
    builder.h \
    directorymaker.h \
    documentadder.h \
    documentdeleter.h \
    documentsaver.h \
    exporter.h \
    gitstatuschecker.h \
    importer.h \
    pdfmetadata.h \
    pdfmetalist.h \
    pdfmetalister.h \
    pdftoyamlpath.h \
    subjectadder.h \
    subjectdeleter.h \
    subjectpath.h \
    subjectslister.h
