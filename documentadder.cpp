#include "documentadder.h"
#include "subjectpath.h"

#include <QDebug>
#include <QDir>
#include <QFile>

DocumentAdder::DocumentAdder(QObject *parent) :
    QObject(parent)
{
}

bool DocumentAdder::addDocument(PdfMetaData metapdf, QString subject)
{
    qDebug() << "ADDING PDF : meta data : {"
             << metapdf.fileName << ',' << metapdf.title << ',' <<
                metapdf.description << '}' << "for the " << subject << " class.";
    QDir dest;
    QString source;
    {
        QUrl origin(metapdf.fileName);
        if (origin.isEmpty())
            source = metapdf.fileName;
        else
            source = origin.toLocalFile();
        QDir fileName(source);
        dest.setPath(SubjectPath::subjectPath()+"/"+subject+"/"+fileName.dirName());
    }

    qDebug() << "copy " << source << " to " << dest.path();
    bool ret_copy = QFile::copy(source, dest.path());

    bool ret_touch = [&](){
        QString yaml_path(dest.absolutePath().chopped(3)+"yaml");
        if (dest.absolutePath().endsWith("-dark.pdf")){
            yaml_path = dest.absolutePath().chopped(9)+".yaml";
        }
        QFile yaml_file(yaml_path);
        bool ret = yaml_file.open(QIODevice::NewOnly);
        QString content("name: "+metapdf.title+"\ndescription: "+metapdf.description);
        qDebug() << "content : " << content;
        yaml_file.write(content.toStdString().c_str()) && ret;
        yaml_file.close();
        return ret;
    }();

    return ret_copy && ret_touch;
}

bool DocumentAdder::addDocument(QUrl filePath, QString subject, QString title, QString description)
{
    return addDocument(PdfMetaData{filePath.toString(), title, description}, subject);
}

bool DocumentAdder::add(QUrl filePath, QString subject, QString title, QString description)
{
    return DocumentAdder::addDocument(filePath, subject, title, description);
}
