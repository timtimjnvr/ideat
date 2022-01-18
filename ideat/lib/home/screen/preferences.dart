import 'package:flutter/material.dart';
import 'package:ideat/home/screen/black_list.dart';
import 'package:settings_ui/settings_ui.dart';

class Preferences extends StatefulWidget {
  const Preferences({Key? key}) : super(key: key);

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<Preferences> {
  bool isSwitched = false;
  changePage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder:(context) => const BlackList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings page"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Preferences'),
            tiles: [
              SettingsTile(
                title: const Text('Diet'),
                value: const Text('None'),
                leading: const Icon(Icons.food_bank),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: const Text('Disliked ingredients'),
                leading: const Icon(Icons.no_meals),
                onPressed: (BuildContext context) {
                  changePage();
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Settings'),
            tiles: [
              SettingsTile(
                title: const Text('Change password'),
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: const Text('Change email'),
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: const Text('Notifications'),
                leading: const Icon(Icons.notifications_active),
                initialValue: true,
                onToggle: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
