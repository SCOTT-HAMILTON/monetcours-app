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

        QDir curDir;
        {
            QString tmpPath(QStandardPaths::standardLocations(QStandardPaths::TempLocation).first());
            QDir tmp(tmpPath);
            tmp.mkpath("monet-app");
            curDir.setPath(tmpPath+"/monet-app");
        }

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
            QFile::copy(filePath, curDir.path()+"/"+yaml);

        }
        qDebug() << "archive file : " << archiveFile;

        qDebug() << "successed : ? " <<
        JlCompress::compressDir(archiveFile, curDir.path());

//        JlCompress::extractDir(archiveFile, fromCompressed);
    }


    return true;
}

bool Exporter::createTestArchive(QuaZip &zip, const QString &zipName, const QStringList &fileNames, QTextCodec *codec, const QString &dir)
{
    if (codec != NULL) {
        zip.setFileNameCodec(codec);
    }
    if (!zip.open(QuaZip::mdCreate)) {
        qWarning("Couldn't open %s", zipName.toUtf8().constData());
        return false;
    }
    int i = 0;
    QDateTime dt1;
    foreach (QString fileName, fileNames) {
        QuaZipFile zipFile(&zip);
        QString filePath = QDir(dir).filePath(fileName);
        QFileInfo fileInfo(filePath);
        QuaZipNewInfo newInfo(fileName, filePath);
        if (i == 0) // to test code that needs different timestamps
            newInfo.dateTime = newInfo.dateTime.addSecs(-60);
        else if (i == 1) // will use for the next file too
            dt1 = newInfo.dateTime;
        else if (i == 2) // to test identical timestamps
            newInfo.dateTime = dt1;
        if (!zipFile.open(QIODevice::WriteOnly,
                newInfo, NULL, 0,
                fileInfo.isDir() ? 0 : 8)) {
            qWarning("Couldn't open %s in %s", fileName.toUtf8()
                .constData(), zipName.toUtf8().constData());
            return false;
        }
        if (!fileInfo.isDir()) {
            QFile file(filePath);
            if (!file.open(QIODevice::ReadOnly)) {
                qWarning("Couldn't open %s", filePath.toUtf8()
                    .constData());
                return false;
            }
            while (!file.atEnd()) {
                char buf[4096];
                qint64 l = file.read(buf, 4096);
                if (l <= 0) {
                    qWarning("Couldn't read %s", filePath.toUtf8()
                        .constData());
                    return false;
                }
                if (zipFile.write(buf, l) != l) {
                    qWarning("Couldn't write to %s in %s",
                        filePath.toUtf8().constData(),
                        zipName.toUtf8().constData());
                    return false;
                }
            }
            file.close();
        }
        zipFile.close();
        ++i;
    }
    zip.setComment(QString("This is the test archive"));
    zip.close();
    if (zipName.startsWith("<")) { // something like "<QIODevice pointer>"
        return true;
    } else {
        return QFileInfo(zipName).exists();
    }
}
