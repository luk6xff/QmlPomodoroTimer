#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
   QGuiApplication app(argc, argv);
   app.setOrganizationName("luktech");
   app.setOrganizationDomain("luktech.com");
   app.setApplicationName("QMLPomodoroTimer");

   //register singletons
   qmlRegisterSingletonType( QUrl("qrc:/GlobalSettings.qml"), "QmlPomodoroTimer.GlobalSettings", 1, 0, "GlobalSettings");
   QQmlApplicationEngine engine;
   engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

   return app.exec();
}
