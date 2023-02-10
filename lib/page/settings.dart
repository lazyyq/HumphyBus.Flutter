import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:restart_app/restart_app.dart';
import '../utils.dart';

class SettingsPage extends StatefulWidget {
  static final initKeys = ['debugEnabled'];
  final choices = ['Zero', 'One', 'Two', 'Three'];

  Map<String, dynamic>? initValues = {};

  SettingsPage({this.initValues});

  @override
  State createState() {
    return _SettingsPage();
  }
}

class _SettingsPage extends State<SettingsPage> {
  // bool debugEnabled = widget.initValues?['debugEnabled']??false;
  var debugEnabled = false;

  @override
  void initState() {
    super.initState();
    // initValues();

    // var pref = await SharedPreferences.getInstance();
    setState(() {
      // debugEnabled = pref.getBool('debugEnabled') ?? false;
      print("${widget.initValues?['debugEnabled'] ?? "NotFOund"}");
      debugEnabled = widget.initValues?['debugEnabled'] ?? false;
    });
  }

  void initValues() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      debugEnabled = pref.getBool('debugEnabled') ?? false;
    });
  }

  SettingsThemeData getSettingsTheme(BuildContext context) => SettingsThemeData(
        settingsSectionBackground: Theme.of(context).scaffoldBackgroundColor,
        settingsListBackground: Theme.of(context).scaffoldBackgroundColor,
        tileHighlightColor: Theme.of(context).highlightColor,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        lightTheme: getSettingsTheme(context),
        darkTheme: getSettingsTheme(context),
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.cloud_outlined),
                title: Text('Environment'),
                value: Text('Production'),
                onPressed: (context) async {
                  var pref = await SharedPreferences.getInstance();
                  int choice = pref.getInt('testkey') ?? 0;
                  if (!context.mounted) return;

                  int? newchoice = await showDialog<int>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Choose'),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 24),
                        content: StatefulBuilder(
                          builder: (context, setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                widget.choices.length,
                                (index) {
                                  return RadioListTile(
                                    value: index,
                                    title: Text(widget.choices[index]),
                                    subtitle: Text('this is subtitle'),
                                    toggleable: true,
                                    groupValue: choice,
                                    onChanged: (value) {
                                      if (value != null) {
                                        pref.setInt('testkey', value);
                                      }
                                      print('onChanged()\nvalue:$value');
                                      Navigator.of(context).pop(value);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                  // print('newchoice: $newchoice');
                  // if (newchoice != null) {
                  //   pref.setInt('testkey', newchoice);
                  // }
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.refresh),
                title: const Text('Clear map cache'),
                onPressed: (context) async {
                  await DefaultCacheManager().emptyCache();
                  if (context.mounted) {
                    /*
                    var action = defaultTargetPlatform == TargetPlatform.android
                        ? SnackBarAction(
                            label: 'Restart app',
                            onPressed: () {
                              Restart.restartApp();
                            })
                        : null;
                    */
                    Utils.snack(context, const Text('Cache cleared!'));
                  }
                },
              ),
              SettingsTile.switchTile(
                initialValue: debugEnabled,
                onPressed: (context) {},
                onToggle: (value) async {
                  setState(() {
                    debugEnabled = value;
                  });
                  unawaited(() async {
                    var pref = await SharedPreferences.getInstance();
                    pref.setBool('debugEnabled', value);
                  }.call());
                  print('debugEnabled, $value');
                },
                leading: const Icon(Icons.bug_report),
                title: const Text('Debug (Dummy)'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> getDefault() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool('debugEnabled') ?? false;
  }
}
