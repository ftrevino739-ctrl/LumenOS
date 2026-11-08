#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QGuiApplication::setApplicationName("VitreOS Desktop");
    QGuiApplication::setOrganizationName("VitreOS");

    QQuickStyle::setStyle("Basic");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/qt/qml/VitreOS/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, [] { QCoreApplication::exit(EXIT_FAILURE); },
                     Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
