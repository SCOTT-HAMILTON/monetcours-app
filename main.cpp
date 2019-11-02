#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

#include <directorymaker.h>
#include <subjectslister.h>
#include <subjectadder.h>
#include <subjectdeleter.h>
#include <pdfmetalister.h>
#include <documentadder.h>
#include <documentdeleter.h>
#include <documentsaver.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Monetcours");

    QGuiApplication app(argc, argv);

    qmlRegisterType<SubjectsLister>("io.monetapp.subjectlister", 1, 0, "SubjectLister");
    qmlRegisterType<PdfMetaList>("io.monetapp.pdfmetalist", 1, 0, "PdfMetaList");
    qmlRegisterType<PdfMetaLister>("io.monetapp.pdfmetalister", 1, 0, "PdfMetaLister");
    qmlRegisterType<DocumentDeleter>("io.monetapp.documentdeleter", 1, 0, "DocumentDeleter");


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

    pdfMetaLister.setDirectory("Math");
    pdfMetaLister.setMetaList(&list);
    pdfMetaLister.list();

    QObject::connect(&subjectAdder, &SubjectAdder::added, &subjectsLister, &SubjectsLister::update);
    QObject::connect(&subjectDeleter, &SubjectDeleter::deleted, &subjectsLister, &SubjectsLister::update);

    engine.rootContext()->setContextProperty("subjectAdder", &subjectAdder);
    engine.rootContext()->setContextProperty("subjectDeleter", &subjectDeleter);
    engine.rootContext()->setContextProperty("subjectsLister", &subjectsLister);
    engine.rootContext()->setContextProperty("documentAdder", &documentAdder);
    engine.rootContext()->setContextProperty("documentSaver", &documentSaver);

    engine.load(url);

    DirectoryMaker::makedir();

    SubjectsLister::list();


    return app.exec();
}
