import 'package:app01/pages/home_page.dart';
import 'package:app01/pages/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AcceilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animation en fond (pleine page)
          SizedBox.expand(
            child: Lottie.asset(
              'assets/lotties/animation.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  label: Text("Home"),
                  icon: Icon(Icons.home),
                ),
                SizedBox(height: 20),
                FloatingActionButton.extended(
                  
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfilePage()),
                    );
                  },
                  label: Text("Connection"),
                  icon: Icon(Icons.connect_without_contact),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
