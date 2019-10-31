#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <directorymaker.h>
#include <subjectslister.h>
#include <subjectadder.h>
#include <subjectdeleter.h>
#include <pdfmetalister.h>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("Monetcours");

    QGuiApplication app(argc, argv);

    qmlRegisterType<SubjectsLister>("io.monetapp.subjectlister", 1, 0, "SubjectLister");
    qmlRegisterType<PdfMetaList>("io.monetapp.pdfmetalist", 1, 0, "PdfMetaList");
    qmlRegisterType<PdfMetaLister>("io.monetapp.pdfmetalister", 1, 0, "PdfMetaLister");


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
    pdfMetaLister.setDirectory("Math");
    pdfMetaLister.setMetaList(&list);
    pdfMetaLister.list();

    qDebug() << " THE LIST : " << list.count();

    for (int i = 0; i < list.count(); i++){
        qDebug() << "PDF : {" << list.fileName(i) << ','
            << list.title(i) << ',' << list.description(i) << '}';
    }


    QObject::connect(&subjectAdder, &SubjectAdder::added, &subjectsLister, &SubjectsLister::update);
    QObject::connect(&subjectDeleter, &SubjectDeleter::deleted, &subjectsLister, &SubjectsLister::update);

    engine.rootContext()->setContextProperty("subjectAdder", &subjectAdder);
    engine.rootContext()->setContextProperty("subjectDeleter", &subjectDeleter);
    engine.rootContext()->setContextProperty("subjectsLister", &subjectsLister);
//    engine.rootContext()->setContextProperty("pdfMetaLister", &pdfMetaLister);


    engine.load(url);

    DirectoryMaker::makedir();

    SubjectsLister::list();


    return app.exec();
}
