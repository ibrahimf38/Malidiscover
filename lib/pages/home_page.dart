import 'package:app01/pages/acceil_page.dart';
import 'package:app01/pages/activite_page.dart';
import 'package:app01/pages/hotel_page.dart';
import 'package:app01/pages/restaurant_page.dart';
import 'package:app01/pages/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:app01/pages/setting_page.dart';
import 'package:app01/pages/search_page.dart';
import 'package:app01/pages/login_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  final pages = [HotelPage(), RestaurantPage(), MapPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Invité"),
              accountEmail: Text("invité@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.green.shade700,
                ),
              ),
              decoration: BoxDecoration(color: Colors.green.shade700),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Accueil"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AcceilPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profil"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Paramètres"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Déconnexion"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 4.0,
        title: Row(
          children: [
            Icon(Icons.explore, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "MaliDiscover",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
        
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // TODO: Rafraîchir les données
            },
          ),
          IconButton(
          icon: Icon(Icons.search, color: Colors.white),
           onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => SearchPage()));
           },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              // TODO: Gérer les options
              print("Option sélectionnée : $value");
            },
            itemBuilder: (BuildContext context) {
              return ['Aide', 'À propos'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: pages[pageIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.hotel, color: Colors.lightGreenAccent),
            label: "Hotel",
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant, color: Colors.lightGreenAccent),
            label: "Restaurant",
          ),
          NavigationDestination(
            icon: Icon(Icons.local_activity, color: Colors.lightGreenAccent),
            label: "Activités",
          ),
        ],
      ),
    );
  }
}
