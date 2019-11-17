#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include <QTranslator>
#include <QLocale>

#include <directorymaker.h>
#include <subjectslister.h>
#include <subjectadder.h>
#include <subjectdeleter.h>
#include <pdfmetalister.h>
#include <documentadder.h>
#include <documentdeleter.h>
#include <documentsaver.h>
#include <builder.h>
#include <subjectpath.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Monetcours");

    QGuiApplication app(argc, argv);

    QTranslator translator;
    QLocale locale;//(QLocale::English, QLocale::UnitedStates);

    if (translator.load("://translations/monetapp-"+locale.name()+".qm"))
        app.installTranslator(&translator);

    qmlRegisterType<SubjectsLister>("io.monetapp.subjectlister", 1, 0, "SubjectLister");
    qmlRegisterType<PdfMetaList>("io.monetapp.pdfmetalist", 1, 0, "PdfMetaList");
    qmlRegisterType<PdfMetaLister>("io.monetapp.pdfmetalister", 1, 0, "PdfMetaLister");
    qmlRegisterType<DocumentDeleter>("io.monetapp.documentdeleter", 1, 0, "DocumentDeleter");
    qmlRegisterType<Builder>("io.monetapp.monetbuilder", 1, 0, "MonetBuilder");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/QML/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    SubjectAdder subjectAdder;
    SubjectDeleter subjectDeleter;
    SubjectsLister subjectsLister;
    PdfMetaLister pdfMetaLister;
    PdfMetaList list;
    DocumentAdder documentAdder;
    DocumentSaver documentSaver;

    QObject::connect(&subjectAdder, &SubjectAdder::added, &subjectsLister, &SubjectsLister::update);
    QObject::connect(&subjectDeleter, &SubjectDeleter::deleted, &subjectsLister, &SubjectsLister::update);

    engine.rootContext()->setContextProperty("subjectAdder", &subjectAdder);
    engine.rootContext()->setContextProperty("subjectDeleter", &subjectDeleter);
    engine.rootContext()->setContextProperty("subjectsLister", &subjectsLister);
    engine.rootContext()->setContextProperty("documentAdder", &documentAdder);
    engine.rootContext()->setContextProperty("documentSaver", &documentSaver);
    engine.rootContext()->setContextProperty("subjectPath", &SubjectPath::path);

    engine.load(url);

    DirectoryMaker::makedir();

    SubjectsLister::list();


    return app.exec();
}
