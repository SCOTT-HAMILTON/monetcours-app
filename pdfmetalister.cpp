#include "pdfmetalister.h"
#include "subjectpath.h"
#include "pdftoyamlpath.h"

#include <qiterator.h>
#include <QDir>
#include <QDebug>
#include <yaml-cpp/yaml.h>
#include <fstream>
#include <iostream>
#include <QCoreApplication>
#include <algorithm>

PdfMetaLister::PdfMetaLister(QObject *parent) :
    QObject(parent)
{
}

void PdfMetaLister::list()
{
    QList<PdfMetaData>* data = metalist->getList();
    QDir dir(SubjectPath::path.subjectPath()+"/"+directory);
    QStringList pdfs = listpdfs(directory);
    data->clear();
    data->reserve(pdfs.size());
    foreach (auto pdf, pdfs) {
        auto meta = load_config(dir.path(), pdf);
        data->append({pdf, meta.first, meta.second});
    }
}

QStringList PdfMetaLister::listInPath(QString path)
{
    qDebug() << "Listing pdfs in specified path : " << path;
    return listPdfsInPath(path);
}

QString PdfMetaLister::getDirectory() const
{
    return directory;
}

QStringList PdfMetaLister::listPdfsInPath(QString path)
{
    QDir dir(path);
    QStringList tmp = dir.entryList(QStringList() << "*.*",QDir::Files);
    QRegExp regex1(".*\.pdf");
    regex1.setCaseSensitivity(Qt::CaseInsensitive);
    QStringList pdfs = tmp.filter(regex1);

    pdfs.erase(std::remove_if(pdfs.begin(), pdfs.end(),
                              [](const QString& s){return s.toLower().endsWith("-dark.pdf");}),
               pdfs.end());

    return pdfs;
}


QStringList PdfMetaLister::listpdfs(QString directory)
{
    return listPdfsInPath(SubjectPath::path.subjectPath()+"/"+directory);
}

QPair<QString, QString> PdfMetaLister::load_config(QString directory, QString fileName)
{
    QDir dir(directory);

    QString yaml_path = PdfToYamlPath::getYaml(dir.path()+"/"+fileName);

    YAML::Node doc;
    try {
        doc = YAML::LoadFile(yaml_path.toStdString());
    } catch (const YAML::BadFile&){
        qDebug() << "Error YAML bad file : " << yaml_path;
    }

    QString title = QString::fromStdString(doc["name"].Scalar());
    QString desc = QString::fromStdString(doc["description"].Scalar());

    return QPair<QString, QString>(title, desc);
}

PdfMetaList *PdfMetaLister::getMetaList()
{
    return metalist;
}

void PdfMetaLister::setMetaList(PdfMetaList *list)
{
    metalist = list;
    emit metaListChanged();
}


void PdfMetaLister::setDirectory(QString newdir)
{
    directory = newdir;
    emit directoryChanged();
}
