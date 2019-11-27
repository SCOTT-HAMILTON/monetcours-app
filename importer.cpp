#include "importer.h"
#include "subjectpath.h"

#include <QUrl>
#include <QDebug>
#include <QStandardPaths>
#include <QDir>
#include <quazip5/JlCompress.h>
#include <QFileInfo>
#include <pdftoyamlpath.h>

Importer::Importer(QObject *parent) :
    QObject(parent)
{

}

QString Importer::extractPdfs(QString archiveUrl)
{
    QString filePath;
    QUrl origin(archiveUrl);
    if (origin.isEmpty())
        filePath = archiveUrl;
    else
        filePath = origin.toLocalFile();

    qDebug() << "file Path to import : " << filePath;

    QString tmpPath = QStandardPaths::writableLocation(QStandardPaths::TempLocation);
    QDir dir(tmpPath);
    if (dir.exists("monet-app")){
        QDir tmp(dir.path()+"/monet-app");
        tmp.removeRecursively();
    }
    dir.mkpath("monet-app");
    dir.cd("monet-app");
    JlCompress::extractDir(filePath, dir.path());

    qDebug() << "files extracted to : " << dir.path();

    return dir.path();
}

bool Importer::importPdfs(QStringList files, QString directory)
{
    qDebug() << "importing files " << files << " located in " << directory;

    QDir extractedFilesDir(directory);
    if (!extractedFilesDir.exists()){
        qDebug() << "Error Importer, can't import pdfs, directory doesn't exists : " << directory;
        return false;
    }

    QDir dir (SubjectPath::path.subjectPath());

    QStringList dontExists;
    //Checking files existance
    foreach (auto file, files) {
        QString yaml = PdfToYamlPath::getYaml(file);
        QString filePath(extractedFilesDir.path()+"/"+file);
        QString yamlPath(extractedFilesDir.path()+"/"+yaml);
        if (!QFile::exists(filePath))
            dontExists.append(file);
        if (!QFile::exists(yamlPath)){
            dontExists.append(yaml);
        }

    }

    if (dontExists.size()>0){
        qDebug() << "Error, those files don't exists : " << dontExists;
        return false;
    }

    foreach (auto pdf, files){
        QString subject = QFileInfo(pdf).dir().dirName();
        qDebug() << "dirname : " << subject;
        if (!dir.exists(subject)){
            dir.mkdir(subject);
        }
        QString yaml(PdfToYamlPath::getYaml(pdf));
        QFile::copy(extractedFilesDir.path()+"/"+pdf, dir.path()+"/"+pdf);
        QFile::copy(extractedFilesDir.path()+"/"+yaml, dir.path()+"/"+yaml);
    }

    emit filesImported();

    return true;
}
