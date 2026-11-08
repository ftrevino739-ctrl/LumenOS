#include "SystemActions.h"

#include <QDesktopServices>
#include <QDir>
#include <QProcess>
#include <QSysInfo>
#include <QUrl>

SystemActions::SystemActions(QObject *parent)
    : QObject(parent)
{
}

bool SystemActions::openHomeFolder() const
{
    return QDesktopServices::openUrl(QUrl::fromLocalFile(QDir::homePath()));
}

bool SystemActions::openSettings() const
{
    return QProcess::startDetached(QStringLiteral("systemsettings"), {});
}

bool SystemActions::openTerminal() const
{
    const QStringList terminals = {
        QStringLiteral("konsole"),
        QStringLiteral("kgx"),
        QStringLiteral("xterm")
    };

    for (const QString &terminal : terminals) {
        if (QProcess::startDetached(terminal, {}))
            return true;
    }
    return false;
}

bool SystemActions::openBrowser() const
{
    return QDesktopServices::openUrl(QUrl(QStringLiteral("https://www.kde.org")));
}

bool SystemActions::openUrl(const QString &url) const
{
    const QUrl parsed(url);
    if (!parsed.isValid() ||
        (parsed.scheme() != QStringLiteral("https") &&
         parsed.scheme() != QStringLiteral("http"))) {
        return false;
    }
    return QDesktopServices::openUrl(parsed);
}

bool SystemActions::launchApplication(const QString &application) const
{
    // Deliberately allow-list desktop applications; never pass arbitrary shell commands.
    static const QStringList allowed = {
        QStringLiteral("dolphin"),
        QStringLiteral("systemsettings"),
        QStringLiteral("konsole"),
        QStringLiteral("firefox"),
        QStringLiteral("org.kde.discover")
    };

    if (!allowed.contains(application))
        return false;

    return QProcess::startDetached(application, {});
}

QVariantMap SystemActions::systemInformation() const
{
    return {
        {QStringLiteral("prettyName"), QSysInfo::prettyProductName()},
        {QStringLiteral("kernel"), QSysInfo::kernelVersion()},
        {QStringLiteral("architecture"), QSysInfo::currentCpuArchitecture()},
        {QStringLiteral("hostname"), QSysInfo::machineHostName()}
    };
}
