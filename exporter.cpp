#include "exporter.h"
#include "subjectpath.h"
#include "pdftoyamlpath.h"

#include <QDebug>
#include <QDir>
#include <quazip5/JlCompress.h>
#include <QCoreApplication>
#include <QTextCodec>
#include <QStandardPaths>

Exporter::Exporter(QObject *parent) :
    QObject(parent)
{

}

bool Exporter::exportPdfs(QStringList files, QString archiveFile)
{
    qDebug() << "files to export : " << files;

    QUrl origin(archiveFile);

    archiveFile = origin.toLocalFile();

    if (QFileInfo info(archiveFile); info.completeSuffix() != "monet"){
        archiveFile = info.dir().path()+"/"+info.baseName()+".monet";
    }

    qDebug() << "corrected name : " << archiveFile;

    QDir dir(SubjectPath::path.subjectPath());

    QStringList dontExists;
    //Checking files existance
    foreach (auto file, files) {
        QString yaml = PdfToYamlPath::getYaml(file);
        QString filePath(dir.path()+"/"+file);
        QString yamlPath(dir.path()+"/"+yaml);
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

    {

        QDir tempFolderPath(QStandardPaths::standardLocations(QStandardPaths::TempLocation).first());
        {
            QDir(tempFolderPath.path()+"/monet-app").removeRecursively();
        }
        tempFolderPath.mkpath("monet-app");
        QDir curDir;
        curDir.setPath(tempFolderPath.path()+"/monet-app");



        foreach (auto file, files) {
            QString yaml = PdfToYamlPath::getYaml(file);
            QString filePath(dir.path()+"/"+file);
            QString yamlPath(dir.path()+"/"+yaml);
            QDir fileDir(filePath);
            fileDir.cd("..");
            qDebug() << "dirName : " << fileDir.dirName();
            curDir.mkdir(fileDir.dirName());
            qDebug() << "copy : " << filePath << " to " << curDir.path()+"/"+file;
            QFile::copy(filePath, curDir.path()+"/"+file);
            QFile::copy(yamlPath, curDir.path()+"/"+yaml);
            qDebug() << "yaml copy : from " << yamlPath << " to " << curDir.path()+"/"+yaml;

        }
        qDebug() << "archive file : " << archiveFile;

        qDebug() << "successed : ? " <<
        JlCompress::compressDir(archiveFile, curDir.path());

//        JlCompress::extractDir(archiveFile, fromCompressed);
        curDir.removeRecursively();
    }


    return true;
}
