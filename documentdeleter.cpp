#include "documentdeleter.h"
#include "subjectpath.h"
#include "pdftoyamlpath.h"

#include <QDir>
#include <QDebug>

DocumentDeleter::DocumentDeleter(QObject *parent) :
    QObject(parent)
{
}

bool DocumentDeleter::deleteDoc(QString filePath, QString subject)
{
    QFile file(SubjectPath::subjectPath()+"/"+subject+"/"+filePath);

    QFile yaml(PdfToYamlPath::getYaml(file.fileName()));
    qDebug() << "files: " << file << " + " << yaml;
    return file.remove() && yaml.remove();
}

bool DocumentDeleter::deleteDocument(QString filePath, QString subject)
{
    bool ret = deleteDoc(filePath, subject);
    if (ret) emit(deleted());
    return ret;
}
