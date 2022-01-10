import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Preferences extends StatefulWidget {
  Preferences({Key? key}) : super(key: key);

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<Preferences> {
  bool isSwitched = false;
  changePage() {
    Navigator.pushNamed(context, '/rd');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings Page"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Preferences'),
            tiles: [
              SettingsTile(
                title: Text('Diet'),
                value: Text('None'),
                leading: Icon(Icons.food_bank),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: Text('Disliked ingredients'),
                leading: Icon(Icons.no_meals),
                onPressed: (BuildContext context) {
                  changePage();
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Settings'),
            tiles: [
              SettingsTile(
                title: Text('Change password'),
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile(
                title: Text('Change email'),
                leading: Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: Text('Notifications'),
                leading: Icon(Icons.notifications_active),
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
