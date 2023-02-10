import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class OSM extends StatefulWidget {
  const OSM({super.key});

  @override
  State createState() {
    return _OSM();
  }
}

class _OSM extends State<OSM> {
  late MapController _mapController;

  @override
  void initState() {
    super.initState();

    _mapController = MapController/*.customLayer*/(
      initMapWithUserPosition: false,
      initPosition: GeoPoint(
        latitude: 36.96758,
        longitude: 127.0161,
      ),
      // customTile: CustomTile(
      //   urlsServers: [
      //     TileURLs(url: "https://tile.openstreetmap.org/"),
      //   ],
      //   tileExtension: "@2x.png",
      //   sourceName: "somerandomsourcename",
        // tileSize: 128,
      // ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OSMFlutter(
        controller: _mapController,
        mapIsLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        trackMyPosition: false,
        initZoom: 12,
        minZoomLevel: 8,
        maxZoomLevel: 19,
        stepZoom: 1.0,
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: RoadConfiguration(
          startIcon: const MarkerIcon(
            icon: Icon(
              Icons.person,
              size: 64,
              color: Colors.brown,
            ),
          ),
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 56,
            ),
          ),
        ),
        onMapIsReady: (p0) {
          print(':: Map Ready: $p0 ::');
        },
      ),
    );
  }
}