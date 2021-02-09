#ifndef RADARPAINTER_H
#define RADARPAINTER_H

#include <QQuickPaintedItem>

struct Point
{
    QPoint point;
    int alpha;

    Point(const QPoint &p, int a) : point(p) , alpha(a) { }

};

class RadarPainter : public QQuickPaintedItem
{
    Q_OBJECT
public:
    explicit RadarPainter(QQuickItem *parent = nullptr);
    ~RadarPainter();

        Q_INVOKABLE void start();
protected:
    virtual void paint(QPainter *painter);

private:
    bool m_drawable = false;
    int m_angle = 0;
    QList<Point> m_points;
    QTimer *m_updateTimer;

};

#endif // RADARPAINTER_H
