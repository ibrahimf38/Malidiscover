import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres"),
        backgroundColor: Colors.green.shade700,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Mode sombre"),
            value: false,
            onChanged: (bool value) {
            
            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Langue"),
            onTap: () {
             
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("À propos"),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "MaliDiscover",
                applicationVersion: "1.0.0",
              );
            },
          ),
        ],
      ),
    );
  }
}
