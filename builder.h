#ifndef BUILDER_H
#define BUILDER_H

#include <QObject>
#include <QString>
#include <QThread>
#include <QDir>
#include <QDebug>
#include <QCoreApplication>
#include <QProcess>
#include <iostream>

class MonetbuildThread : public QThread
{
    Q_OBJECT
public:
    explicit MonetbuildThread(QObject* parent = nullptr) :
        QThread(parent)
    {}
    void setDir(QDir newdir){
        dir = newdir;
    }
protected:
    virtual void run() override{
#ifdef Q_OS_WIN
        QString script_path('"'+QCoreApplication::applicationDirPath()
                              +"/Monetcours-windows/monetbuild.ps1"+'"');
        QString param('"'+dir.absolutePath()+'"');
        qDebug() << "script_path" << script_path;
        qDebug() << "param : " << param;
        QString cmd("powershell.exe -File "+script_path+' '+param);
        std::cerr << "cmd : " << cmd.toStdString() << '\n';
        [](std::string cmd){
            QProcess p;
            p.start(cmd.c_str());
            p.waitForFinished();
            std::cerr << p.readAllStandardOutput().toStdString() << '\n';

            QFile logsFile(QCoreApplication::applicationDirPath()+"/logs.out");
            logsFile.write(p.readAllStandardOutput().toStdString().c_str());
        }(cmd.toStdString());
#else
        std::string cmd("monetbuild.sh \""+dir.absolutePath().toStdString()+'"');
        qDebug() << "cmd : " << cmd.c_str();
        std::system(cmd.c_str());
#endif
        emit builded();
    }


signals:
    void builded();

private:
    QDir dir;

};

class Builder : public QObject
{
    Q_OBJECT

public:
    explicit Builder(QObject* parent = nullptr);
    ~Builder();
    Q_INVOKABLE void build();

public slots:
    void emitFinished();

signals:
    void finished();

private:
    MonetbuildThread* builder;
};

#endif // BUILDER_H
