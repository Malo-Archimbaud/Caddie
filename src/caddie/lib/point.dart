class Point {
  final double latitude;
  final double longitude;

  Point(this.latitude, this.longitude);
}

bool isPointInArea(Point p, List<Point> areaPoints) {
  if (areaPoints.length != 4) {
    throw ArgumentError('The area must be defined by exactly 4 points.');
  }

  bool isInside = false;
  int j = areaPoints.length - 1;

  for (int i = 0; i < areaPoints.length; i++) {
    if ((areaPoints[i].longitude > p.longitude) !=
            (areaPoints[j].longitude > p.longitude) &&
        (p.latitude <
            (areaPoints[j].latitude - areaPoints[i].latitude) *
                    (p.longitude - areaPoints[i].longitude) /
                    (areaPoints[j].longitude - areaPoints[i].longitude) +
                areaPoints[i].latitude)) {
      isInside = !isInside;
    }
    j = i;
  }
  return isInside;
}
