#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>

int main(int argc, char *argv[])
{
   QGuiApplication app(argc, argv);
   app.setOrganizationName("luktech");
   app.setOrganizationDomain("luktech.com");
   app.setApplicationName("QMLPomodoroTimer");
   app.setWindowIcon(QIcon(":/pomodoroImg.png"));

   QQmlApplicationEngine engine;
   engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

   return app.exec();
}
