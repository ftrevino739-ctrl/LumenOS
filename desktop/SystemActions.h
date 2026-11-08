#pragma once

#include <QObject>
#include <QString>
#include <QVariantMap>

class SystemActions final : public QObject
{
    Q_OBJECT

public:
    explicit SystemActions(QObject *parent = nullptr);

    Q_INVOKABLE bool openHomeFolder() const;
    Q_INVOKABLE bool openSettings() const;
    Q_INVOKABLE bool openTerminal() const;
    Q_INVOKABLE bool openBrowser() const;
    Q_INVOKABLE bool openUrl(const QString &url) const;
    Q_INVOKABLE bool launchApplication(const QString &application) const;
    Q_INVOKABLE QVariantMap systemInformation() const;
};
