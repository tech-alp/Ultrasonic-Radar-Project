#include <QQuickStyle>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtWidgets/QApplication>

#include "src/mastercontroller.h"
#include "src/sensortagdataprovider.h"
#include "src/bluetoothsetting.h"

#include "src/AppInfo.h"

int main(int argc, char *argv[])
{
    // Init. application
    QApplication app(argc, argv);
    app.setApplicationName(APP_NAME);
    app.setApplicationVersion(APP_VERSION);
    app.setOrganizationName(APP_DEVELOPER);
    app.setOrganizationDomain(APP_SUPPORT_URL);
    app.setWindowIcon(APP_ICON);

    QQuickStyle::setStyle("Material");
    Mastercontroller masterController;

    //QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/");
    engine.rootContext()->setContextProperty("masterController",&masterController);
    qmlRegisterType<SensorTagDataProvider>("SensorTag.DataProvider",1,0,"SensorTagData");
    qmlRegisterType<BluetoothSetting>("BluetoothSetting",1,0,"Bluetoothsetting");
    const QUrl url(QStringLiteral("qrc:/views/MasterView.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
