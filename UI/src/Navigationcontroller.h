#ifndef NAVIGATIONCONTROLLER_H
#define NAVIGATIONCONTROLLER_H

#include <QObject>

class Navigationcontroller : public QObject {
    Q_OBJECT
public:
    Navigationcontroller(QObject* parent = nullptr) : QObject{parent} {}

signals:
    void goSettingsView();
    void goShowElementsView();
};

#endif // NAVIGATIONCONTROLLER_H
