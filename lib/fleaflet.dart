import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'utils.dart';
import 'consts.dart';

class CachedTileProvider extends TileProvider {
  CachedTileProvider();

  @override
  ImageProvider getImage(Coords coords, TileLayer options) {
    return CachedNetworkImageProvider(getTileUrl(coords, options));
  }
}

class Fleaflet extends StatefulWidget {
  Fleaflet({super.key});

  _Fleaflet? _fleaflet;

  @override
  State createState() {
    _fleaflet = _Fleaflet();
    return _fleaflet!;
  }

  void switchTemplate() {
    _fleaflet!.switchTemplate();
  }

  getIdx() => _fleaflet?.layerIdx ?? "Unitialized";
}

class _Fleaflet extends State<Fleaflet> {
  var layers = [
    TileLayer(
      urlTemplate:
          "https://tileserver.kykint.com/styles/osm-openmaptiles/{z}/{x}/{y}@2x.webp",
      userAgentPackageName: 'com.kykint.osmtest',
      minNativeZoom: 12,
      maxNativeZoom: 17,
      tileProvider: CachedTileProvider(),
    ),
    TileLayer(
      urlTemplate:
          "https://tileserver.kykint.com/styles/maptiler-basic/{z}/{x}/{y}@2x.webp",
      userAgentPackageName: 'com.kykint.osmtest',
      maxNativeZoom: 16,
      tileProvider: CachedTileProvider(),
    ),
    TileLayer(
      urlTemplate:
          "https://tileserver.kykint.com/styles/osm-bright/{z}/{x}/{y}@2x.webp",
      userAgentPackageName: 'com.kykint.osmtest',
      maxNativeZoom: 16,
      // retinaMode: true,
    ),
    /*
    TileLayer(
      urlTemplate: "http://192.168.110.3:8080/styles/maptiler-basic/{z}/{x}/{y}@3x.png",
      userAgentPackageName: 'com.kykint.osmtest',
      maxNativeZoom: 20,
    ),
    TileLayer(
      urlTemplate: "http://192.168.110.3:8080/styles/osm-bright/{z}/{x}/{y}@2x.png",
      userAgentPackageName: 'com.kykint.osmtest',
      maxNativeZoom: 20,
      // retinaMode: true,
    ),

     */
    TileLayer(
      urlTemplate:
          "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png?api_key={api_key}",
      additionalOptions: {
        "api_key": "1a8a6af6-82c8-4d78-b67d-c656a145a967",
      },
      userAgentPackageName: 'com.kykint.osmtest',
      maxNativeZoom: 20,
    ),
    TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}@2x.png',
      userAgentPackageName: 'com.kykint.osmtest',
    ),
    TileLayer(
      urlTemplate: 'https://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.kykint.osmtest',
    ),
  ];

  int layerIdx = 0;

  void switchTemplate() {
    setState(() {
      layerIdx = (layerIdx + 1) % layers.length;
    });
  }

  late List<LatLng> lngs;

  @override
  void initState() {
    super.initState();
    lngs = humphreysBorderCoords.map((e) => LatLng(e[0], e[1])).toList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var humphreysBorderCoords = [
    [36.9691682, 127.0367575],
    [36.9694197, 127.0367542],
    [36.969448, 127.0335371],
    [36.9694428, 127.0326733],
    [36.9693942, 127.0315353],
    [36.9694206, 127.0313015],
    [36.9695164, 127.0304315],
    [36.9695732, 127.0297448],
    [36.9696203, 127.0294994],
    [36.9696964, 127.0287511],
    [36.9697639, 127.0279444],
    [36.9697959, 127.0276716],
    [36.969901, 127.0273293],
    [36.9700299, 127.0270385],
    [36.970313, 127.0266328],
    [36.970546, 127.0264807],
    [36.9738873, 127.0247488],
    [36.974031, 127.0246495],
    [36.9742308, 127.0244314],
    [36.97485, 127.0234443],
    [36.9748308, 127.0228824],
    [36.9748664, 127.0227701],
    [36.97491, 127.0227362],
    [36.9758293, 127.0222145],
    [36.9759357, 127.022096],
    [36.9759761, 127.0220134],
    [36.9762567, 127.0201596],
    [36.9763264, 127.0198153],
    [36.9772596, 127.0164397],
    [36.9772778, 127.0159596],
    [36.9772939, 127.0158979],
    [36.9773421, 127.0158161],
    [36.9773892, 127.0156431],
    [36.9773817, 127.0155734],
    [36.9776592, 127.0145729],
    [36.9784177, 127.0119108],
    [36.9784799, 127.0117915],
    [36.9785152, 127.0116386],
    [36.9785217, 127.0115367],
    [36.9791661, 127.0096319],
    [36.9807758, 127.0061508],
    [36.9806518, 127.0057289],
    [36.9818599, 127.00349],
    [36.987359, 126.9928369],
    [36.9880536, 126.9909796],
    [36.9881975, 126.9898966],
    [36.9882977, 126.9894217],
    [36.9882875, 126.9889364],
    [36.988326, 126.9882525],
    [36.9881497, 126.9867033],
    [36.9878128, 126.9853473],
    [36.9869164, 126.9839],
    [36.9838585, 126.9813706],
    [36.9803837, 126.979849],
    [36.980118, 126.9796666],
    [36.9787282, 126.9790688],
    [36.9783342, 126.978971],
    [36.9781458, 126.9789624],
    [36.9779067, 126.9789773],
    [36.9765153, 126.9792047],
    [36.9763503, 126.9792515],
    [36.9757875, 126.9795486],
    [36.9732207, 126.9812692],
    [36.9730126, 126.9814423],
    [36.9725175, 126.981693],
    [36.9723544, 126.9817064],
    [36.9713127, 126.9821138],
    [36.9704454, 126.9826305],
    [36.9701764, 126.9827646],
    [36.9651641, 126.9859457],
    [36.9635458, 126.9867049],
    [36.9632961, 126.9867558],
    [36.9631092, 126.986749],
    [36.9615663, 126.9861461],
    [36.9605894, 126.9860274],
    [36.960565, 126.9901431],
    [36.9606244, 126.9902742],
    [36.9606715, 126.990378],
    [36.960738, 126.9905247],
    [36.9607166, 126.9905263],
    [36.96071, 126.9905366],
    [36.9606043, 126.9906114],
    [36.9605431, 127.0046702],
    [36.9605019, 127.0048315],
    [36.959474, 127.0057884],
    [36.9589925, 127.0075251],
    [36.9577704, 127.0108163],
    [36.9574707, 127.0106587],
    [36.9561875, 127.0140796],
    [36.9550663, 127.0162162],
    [36.9545685, 127.0161598],
    [36.9544766, 127.016921],
    [36.9540833, 127.0168716],
    [36.9534799, 127.0181188],
    [36.9526989, 127.0198857],
    [36.9526697, 127.0198971],
    [36.9515943, 127.0184229],
    [36.9515143, 127.0184195],
    [36.9514289, 127.0185526],
    [36.9513825, 127.0185504],
    [36.9512903, 127.018546],
    [36.9512293, 127.0185431],
    [36.9512043, 127.0185419],
    [36.9511663, 127.0185401],
    [36.9511554, 127.0183978],
    [36.950687, 127.0183704],
    [36.9502972, 127.0179574],
    [36.9499839, 127.0171036],
    [36.9498525, 127.0169777],
    [36.949775, 127.016995],
    [36.9497299, 127.0170084],
    [36.9497256, 127.0168971],
    [36.9496485, 127.0168015],
    [36.9494663, 127.0167282],
    [36.9493759, 127.0166348],
    [36.9489263, 127.0166668],
    [36.9485107, 127.0166964],
    [36.9479884, 127.0167929],
    [36.9477009, 127.0168734],
    [36.9477048, 127.0169882],
    [36.9478814, 127.0174207],
    [36.948296, 127.01836],
    [36.9484527, 127.0197754],
    [36.9483927, 127.0197881],
    [36.9466049, 127.0201564],
    [36.9461803, 127.0202385],
    [36.945463, 127.0203694],
    [36.9453322, 127.0207063],
    [36.9455875, 127.0209782],
    [36.9458857, 127.0212958],
    [36.9466964, 127.0221593],
    [36.9473975, 127.0276953],
    [36.9469304, 127.0280906],
    [36.9469441, 127.0335825],
    [36.9472417, 127.0335823],
    [36.9475077, 127.0338799],
    [36.9468372, 127.0347699],
    [36.9467151, 127.0349723],
    [36.9467013, 127.0352827],
    [36.9460255, 127.0349502],
    [36.9459776, 127.0350516],
    [36.9460098, 127.0350918],
    [36.9460805, 127.0354512],
    [36.9463828, 127.035647],
    [36.9464192, 127.0355773],
    [36.9466421, 127.0357543],
    [36.9469873, 127.0359313],
    [36.947182, 127.0359942],
    [36.9472444, 127.0360244],
    [36.9474654, 127.0363712],
    [36.9475079, 127.0363288],
    [36.9475885, 127.0364479],
    [36.9476485, 127.0365366],
    [36.9476317, 127.0366994],
    [36.9492426, 127.0389324],
    [36.9499111, 127.0381871],
    [36.9499497, 127.0382407],
    [36.9501952, 127.0379567],
    [36.9502466, 127.0380418],
    [36.9502985, 127.0381275],
    [36.9513579, 127.0386806],
    [36.9531587, 127.0396053],
    [36.9532614, 127.039713],
    [36.9533805, 127.0399598],
    [36.9534404, 127.0402619],
    [36.9532476, 127.0413152],
    [36.95288, 127.0432027],
    [36.9528302, 127.0439393],
    [36.9529354, 127.0447798],
    [36.9532582, 127.0455766],
    [36.9544712, 127.0470304],
    [36.9547278, 127.0472925],
    [36.9550531, 127.0473412],
    [36.9556062, 127.0468171],
    [36.9559876, 127.0464532],
    [36.9562777, 127.0461301],
    [36.9565985, 127.0453735],
    [36.9569889, 127.044919],
    [36.9572045, 127.0447175],
    [36.9575331, 127.045095],
    [36.957622, 127.0449687],
    [36.9576728, 127.0448944],
    [36.9577435, 127.044784],
    [36.957776, 127.0447433],
    [36.9578847, 127.0445842],
    [36.957636, 127.0443074],
    [36.957711, 127.0441536],
    [36.9577761, 127.0440184],
    [36.9579416, 127.0438279],
    [36.9584412, 127.0432414],
    [36.9586288, 127.0433556],
    [36.9588038, 127.0430919],
    [36.9589925, 127.0428077],
    [36.9588593, 127.042557],
    [36.9596301, 127.0410972],
    [36.9601068, 127.0407824],
    [36.961245, 127.0400307],
    [36.9650278, 127.0403839],
    [36.9653002, 127.0403717],
    [36.967697, 127.0395748],
    [36.9683197, 127.0370046],
    [36.9687773, 127.036838],
    [36.9687767, 127.0367628],
    [36.9688703, 127.0367615],
    [36.9689743, 127.0367601],
    [36.9690265, 127.0367594],
    [36.9691328, 127.036758],
    [36.9691682, 127.0367575]
  ];

  @override
  Widget build(BuildContext context) {
    print('should use retina: ${MediaQuery.of(context).devicePixelRatio}');
    return Container(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(
            Consts.humphreysCenterCoords['lat'] ?? 0,
            Consts.humphreysCenterCoords['lng'] ?? 0,
          ),
          minZoom: 12.5,
          zoom: 15,
          maxZoom: 17,
          interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          onPositionChanged: (position, hasGesture) {
            print('zoom level:${position.zoom}');
          },
          maxBounds: LatLngBounds(
            LatLng(
              Consts.humphreysMapBounds[CoordsType.y0]!,
              Consts.humphreysMapBounds[CoordsType.x0]!,
            ),
            LatLng(
              Consts.humphreysMapBounds[CoordsType.y1]!,
              Consts.humphreysMapBounds[CoordsType.x1]!,
            ),
          ),
        ),
        nonRotatedChildren: [
          OverflowBox(
            alignment: Alignment.bottomRight,
            maxWidth: double.infinity,
            child: AttributionWidget.defaultWidget(
              source: layers[layerIdx].urlTemplate ?? '',
              onSourceTapped: () {},
            ),
          )
        ],
        children: [
          layers[layerIdx],
          PolygonLayer(
            polygonCulling: true,
            polygons: [
              Polygon(
                points: lngs,
                borderColor: const Color.fromARGB(100, 204, 102, 0),
                borderStrokeWidth: 4,
              ),
            ],
          )
        ],
      ),
    );
  }

/*
  final _templateRe = RegExp(r'\{ *([\w_-]+) *\}');

  /// Replaces the templating placeholders with the provided data map.
  ///
  /// Example input: https://tile.openstreetmap.org/{z}/{x}/{y}.png
  ///
  /// Throws an [Exception] if any placeholder remains unresolved.
  String template(String str, Map<String, String> data) {
    data['z'] = (int.parse(data['z']!)-1).toString();
    print('str:${str}, data:$data');
    return str.replaceAllMapped(_templateRe, (Match match) {
      final firstMatch = match.group(1);
      if (firstMatch == null) {
        throw Exception('incorrect URL template: $str');
      }
      final value = data[firstMatch];
      if (value == null) {
        throw Exception('No value provided for variable ${match.group(1)}');
      } else {
        return value;
      }
    });
  }

 */
}
