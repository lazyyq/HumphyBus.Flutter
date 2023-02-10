import 'utils.dart';

var humphreysCenterCoords = {
  'lat': 36.9671960,
  'lng': 127.0107142,
};

var _humphreysMapLimits = {
  'left': -0.0407142,
  'right': 0.0541858,
  'bottom': -0.04745,
  'top': 0.04745,
};

var humphreysMapBounds = {
  CoordsType.y0: humphreysCenterCoords['lat']! + _humphreysMapLimits['bottom']!,
  CoordsType.y1: humphreysCenterCoords['lat']! + _humphreysMapLimits['top']!,
  CoordsType.x0: humphreysCenterCoords['lng']! + _humphreysMapLimits['left']!,
  CoordsType.x1: humphreysCenterCoords['lng']! + _humphreysMapLimits['right']!,
};
