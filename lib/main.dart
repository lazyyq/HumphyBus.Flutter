import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'fleaflet.dart';
import 'fleafletvector.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'page/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp(
        title: Consts.appName,
        theme: ThemeData(
          colorScheme: lightColorScheme ?? _defaultLightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
          useMaterial3: true,
        ),
        home: const MapHomePage(),
      );
    });
  }
}

class MapHomePage extends StatefulWidget {
  const MapHomePage({super.key});

  final title = 'Flutter OSM Test';

  @override
  State<MapHomePage> createState() => _MapHomePage();
}

class _MapHomePage extends State<MapHomePage> {
  int mapIdx = 0;

  late List<Widget> _maps;
  late bool switchVisible;

  @override
  void initState() {
    super.initState();

    _maps = [
      Fleaflet(),
      FleafletVector(),
    ];

    switchVisible = _maps[mapIdx] is Fleaflet;
  }

  void switchMap() {
    setState(() {
      mapIdx = (mapIdx + 1) % _maps.length;
      switchVisible = _maps[mapIdx] is Fleaflet;
    });
  }

  Widget multiFabItem(
      {IconData? icon, String? tooltip, void Function()? onPressed}) {
    return IconButton(
      icon: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
      tooltip: tooltip,
      onPressed: onPressed,
    );
  }

  Widget multiFabDivider() {
    return Divider(
      thickness: 0.5,
      height: 0,
      indent: 8,
      endIndent: 8,
      color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface.withAlpha(150),
        title: const Text(Consts.appName),
        actions: [
          IconButton(
            onPressed: () async {
              var pref = await SharedPreferences.getInstance();
              var initValues = {
                for (var key in SettingsPage.initKeys) key: pref.get(key)
              };
              if (context.mounted) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage(initValues: initValues);
                  },
                ));
              }
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: _maps[mapIdx],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withAlpha(200),
          border: Border.all(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
            width: 0.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        width: 48,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            multiFabItem(
              icon: Icons.recycling,
              tooltip: 'Clear cache',
              onPressed: () {
                DefaultCacheManager().emptyCache();
              },
            ),
            multiFabDivider(),
            Visibility(
              visible: switchVisible,
              child: Column(
                children: [
                  multiFabItem(
                    icon: Icons.map,
                    tooltip: 'Change map type',
                    onPressed: () {
                      (_maps[mapIdx] as Fleaflet).switchTemplate();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            multiFabDivider(),
            multiFabItem(
              icon: Icons.refresh,
              tooltip: 'Switch map',
              onPressed: switchMap,
            ),
          ],
        ),
      ),
    );
  }
}
