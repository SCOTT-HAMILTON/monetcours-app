#include "pdfmetalist.h"
#include <QDebug>
#include <QStringList>

PdfMetaList::PdfMetaList(QObject *parent) :
    QObject(parent)
{
    qDebug() << " A NEW LIST!!!!!";
    list = new QList<PdfMetaData>;
}

QString PdfMetaList::fileName(int index)
{
    if (index >= list->count())return "None";
    return list->at(index).fileName;
}

QString PdfMetaList::description(int index)
{
    if (index >= list->count())return "None";
    return list->at(index).description;
}

QString PdfMetaList::title(int index)
{
    if (index >= list->count())return "None";
    return list->at(index).title;
}

int PdfMetaList::count() const
{
    return list->count();
}

QList<PdfMetaData>* PdfMetaList::getList()
{
    return list;
}

QString PdfMetaList::getName()
{
    return name;
}

void PdfMetaList::setName(QString newname)
{
    name = newname;
}
