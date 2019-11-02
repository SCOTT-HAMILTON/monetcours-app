#include "documentsaver.h"
#include "subjectpath.h"
#include "pdftoyamlpath.h"

#include <QDebug>
#include <QDir>
#include <QFile>

DocumentSaver::DocumentSaver(QObject *parent) :
    QObject(parent)
{
}

bool DocumentSaver::saveDocument(PdfMetaData metapdf, QString subject)
{
    qDebug() << "SAVING PDF : meta data : {"
             << metapdf.fileName << ',' << metapdf.title << ',' <<
                metapdf.description << '}' << "for the " << subject << " class.";
    QDir dest(SubjectPath::subjectPath()+"/"+subject+"/"+metapdf.fileName);


    qDebug() << "dest : file : " << dest;
    bool ret_save = [&](){
        QString yaml_path = PdfToYamlPath::getYaml(dest.absolutePath());
        QFile yaml_file(yaml_path);
        if (yaml_file.exists()){
            yaml_file.remove();
        }
        bool ret = yaml_file.open(QIODevice::NewOnly);
        QString content("name: "+metapdf.title+"\ndescription: "+metapdf.description);
        qDebug() << "content : " << content;
        yaml_file.write(content.toStdString().c_str()) && ret;
        yaml_file.close();
        return ret;
    }();

    return ret_save;
}

bool DocumentSaver::saveDocument(QUrl filePath, QString subject, QString title, QString description)
{
    return saveDocument(PdfMetaData{filePath.toString(), title, description}, subject);
}

bool DocumentSaver::save(QUrl filePath, QString subject, QString title, QString description)
{
    return DocumentSaver::saveDocument(filePath, subject, title, description);
}
