#include <QCoreApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "SystemActions.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QGuiApplication::setApplicationName("Lumen Desktop");
    QGuiApplication::setOrganizationName("Lumen");

    QQuickStyle::setStyle("Basic");

    SystemActions systemActions;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("systemActions", &systemActions);

    const QUrl url(QStringLiteral("qrc:/Lumen/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, [] { QCoreApplication::exit(EXIT_FAILURE); },
                     Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
