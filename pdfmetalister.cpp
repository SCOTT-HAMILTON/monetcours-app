#include "pdfmetalister.h"
#include "subjectpath.h"

#include <qiterator.h>
#include <QDir>
#include <QDebug>
#include <yaml-cpp/yaml.h>
#include <fstream>
#include <iostream>
#include <QCoreApplication>

PdfMetaLister::PdfMetaLister(QObject *parent) :
    QObject(parent)
{
}

void PdfMetaLister::list()
{
    qDebug() << "generating the list... for " << metalist->getName();
    QList<PdfMetaData>* data = metalist->getList();
    QDir dir(SubjectPath::subjectPath()+"/"+directory);
    qDebug() << "dir : " << dir;
    QStringList pdfs = listpdfs(directory);
    data->clear();
    data->reserve(pdfs.size());
    foreach (auto pdf, pdfs) {
        auto meta = load_config(dir.path(), pdf);
        data->append({pdf, meta.first, meta.second});
    }
}

QString PdfMetaLister::getDirectory() const
{
    return directory;
}

QStringList PdfMetaLister::listpdfs(QString directory)
{
    QDir dir(SubjectPath::subjectPath()+"/"+directory);
    QStringList tmp = dir.entryList(QStringList() << "*.*",QDir::Files);
    QRegExp regex(".*\.pdf");
    regex.setCaseSensitivity(Qt::CaseInsensitive);
    QStringList pdfs = tmp.filter(regex);

    return pdfs;
}

QPair<QString, QString> PdfMetaLister::load_config(QString directory, QString fileName)
{
    QDir dir(directory);

    QString yaml_path = dir.path()+"/"+fileName.chopped(3)+"yaml";

    if (yaml_path.endsWith("-dark.yaml")){
        yaml_path = yaml_path.chopped(10)+".yaml";
    }

    YAML::Node doc = YAML::LoadFile(yaml_path.toStdString());

    QString title = QString::fromStdString(doc["name"].Scalar());
    QString desc = QString::fromStdString(doc["description"].Scalar());

    qDebug() << "title : '" << title << "'";
    qDebug() << "desc : '" << desc << "'";

    return QPair<QString, QString>(title, desc);
}

PdfMetaList *PdfMetaLister::getMetaList()
{
    return metalist;
}

void PdfMetaLister::setMetaList(PdfMetaList *list)
{
    qDebug() << "Setting metalist : " << list << ", name : " << list->getName();
    metalist = list;
    emit metaListChanged();
}


void PdfMetaLister::setDirectory(QString newdir)
{
    directory = newdir;
    emit directoryChanged();
}
