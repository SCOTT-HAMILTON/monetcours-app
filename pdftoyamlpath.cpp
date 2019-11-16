#include "pdftoyamlpath.h"

QString PdfToYamlPath::getYaml(QString pdfPath)
{
    QString yaml_path(pdfPath.chopped(3)+"yaml");
    if (pdfPath.endsWith("-dark.pdf")){
        yaml_path = pdfPath.chopped(9)+".yaml";
    }
    return yaml_path;
}
